import 'package:feems/pages/studentProfle.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  QRViewController? _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  String? qrCodeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
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
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: _takeQRCodeDataAndCallAPI,
            child: Text('Check QRcode',style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
          ),
          SizedBox(height: 20),if (qrCodeData != null) buildAlertDialog(context),


        ],
      ),
    );
  }

  Widget buildAlertDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // Set background color
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.qr_code_scanner, // Adjust the icon as needed
            size: 40, color: Colors.green[400],// Adjust the size of the icon as needed
          ),
          SizedBox(width: 20), // Add space between icon and text
          Text(
            'Scanned Successfully',
            style: TextStyle(color: Colors.green[500],fontWeight: FontWeight.w500,fontSize: 20), // Set text color
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (scanData?.code != null) {
        setState(() {
          qrCodeData = scanData.code;
        });
      }
    });
  }

  void _takeQRCodeDataAndCallAPI() async {
    if (qrCodeData != null) {

      if (!qrCodeData!.contains('studentName')) {
        // Data is invalid, show popup
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid QR Code', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500),),
              content: Text('The scanned QR code does not contain valid student data.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return; // Exit function early
      }






      Map<String, dynamic> qrDataMap = json.decode(qrCodeData!);

      if (!qrDataMap.containsKey('studentName') || !qrDataMap.containsKey('admissionno')) {
        print("ILLIGAL QRCODE");
        // Data is invalid, show popup
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid QR Code', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500),),
              content: Text('The scanned QR code does not contain valid student data.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }


      print(qrDataMap['studentName']);
      print(qrDataMap['admissionno']);
      print(qrDataMap);

      String name=qrDataMap['studentName'],number=qrDataMap['admissionno'];


      var client =http.Client();
      var response = await client.post(
        Uri.parse('http://192.168.1.33:3001/qrcode/validateQRCode'),
        body: jsonEncode({'studentName': name,'admissionNumber':number}),
        headers:<String,String>{
          "Content-Type": "application/json"
        },
      );
      print("response is:-");
      print(response);



      if (response.statusCode == 200) {
        print("get a positive code of 200");
        // Data is valid, extract studentId from the response
        Map<String, dynamic> responseData = {};
        final response2=json.decode(response.body);
        final String studentId = response2['_id'];
        print("this is studnet id:"+studentId);


        Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentProfile(studentId: studentId)));
      } else {
        // Data is invalid, show popup
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid QR Code',style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w500),),
              content: Text('The scanned QR code is not valid.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid QR Code',style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w500),),
            content:Text('The scanned QR code is not valid.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK',style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w500),),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

class ValidQRCodeDetailsPage extends StatelessWidget {
  final String qrCodeData;

  ValidQRCodeDetailsPage({required this.qrCodeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Valid QR Code Details'),
      ),
      body: Center(
        child: Text('QR Code Data: $qrCodeData'),
      ),
    );
  }
}
