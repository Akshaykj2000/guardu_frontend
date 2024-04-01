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
    print("Student id :"+studentId);



    var client = http.Client();
    var apiUri = Uri.parse("http://192.168.1.34:3001/qrcode/getQrCodeImage");
    var response = await client.post(apiUri,
      headers: <String, String>
      {
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String, String>
      { 'studentId': studentId
      }
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
        title: Text('QR Code Image'),
      ),
      body: Center(
        child: imageUrl.isEmpty
            ? CircularProgressIndicator()
            : Image.memory(
          base64Decode(imageUrl.split(',').last),
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
