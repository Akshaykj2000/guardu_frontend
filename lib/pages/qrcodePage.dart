import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class QRCodeImageScreen extends StatefulWidget {
  @override
  _QRCodeImageScreenState createState() => _QRCodeImageScreenState();
}

class _QRCodeImageScreenState extends State<QRCodeImageScreen> {
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    getQRCodeImage();
  }

  Future<void> getQRCodeImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String studentId = prefs.getString("userid") ?? "";
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
      body: Stack(
        children: [
          Center(
            child: imageUrl.isNotEmpty
                ? Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(
                    base64Decode(imageUrl.split(',').last),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            )
                :    Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Image.asset('assets/img.png', width: 400, height: 400),

                Text("No QR code available ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black54),)
              ],
            )
          ),
        ],
      ),
    );
  }
}
