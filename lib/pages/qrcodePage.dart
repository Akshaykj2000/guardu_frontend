import 'package:feems/pages/myProfile.dart';
import 'package:feems/pages/studentBottomNavigator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class QRCodeImageScreen extends StatefulWidget {
  @override
  _QRCodeImageScreenState createState() => _QRCodeImageScreenState();
}

class _QRCodeImageScreenState extends State<QRCodeImageScreen> {
  String imageUrl = '',name='',studentId='';

  @override
  void initState() {
    super.initState();
    getQRCodeImage();
  }

  Future<void> getQRCodeImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     studentId = prefs.getString("userid") ?? "";

     name = prefs.getString("name") ?? "";
    print("Student id :" + studentId);

    var client = http.Client();
    var apiUri = Uri.parse("http://192.168.1.34:3001/qrcode/getQrCodeImage");
    var response = await client.post(apiUri,
      headers: <String, String>
      {
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String, String>
      { 'studentId': studentId }
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        imageUrl = 'data:image/png;base64,' + base64Encode(response.bodyBytes);
      });
    } else {
      print('Failed to load QR code image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Image.asset('assets/LOGO4.png', width: 143, height: 35),
            ),
          ],
        ),
        shape: Border(
          bottom: BorderSide(
            color: Colors.black26,
            width: 1.0, // Border width
          ),
        ),
      ),
      body: Center(
        child: imageUrl.isNotEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 20),
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.memory(
                        base64Decode(imageUrl.split(',').last),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Scan this QR Code",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black54),
            ),
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 47,width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue[800],
                      side: BorderSide(color: Colors.blueAccent),
                    ),

                    onPressed: () {  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentNavigationBarApp()));
                    },
                    child: Text('Back', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.blue[800]),),
                  ),
                ),
                SizedBox(
                  height: 47,width: 130,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        )
                    ),

                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile(studentId: studentId)));
                    },
                    child: Text('Myprofile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
                  ),
                ),
              ],
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img.png', width: 200, height: 200),
            SizedBox(height: 20),
            Text(
              "No QR code available ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
