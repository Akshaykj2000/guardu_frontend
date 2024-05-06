import 'dart:convert';
import 'dart:io';
import 'package:feems/models/hodModel.dart';
import 'package:feems/models/messageModel.dart';
import 'package:http/http.dart' as http;

String localhost="192.168.1.36";
class hodApiService{

  Future<dynamic> loginApi(String email ,String password) async{
    var client =http.Client();
    var url = Uri.parse("http://"+localhost+":3001/hod/login");
    var response =await client.post(url,
        headers: <String,String>{
          "Content-Type" :"application/json ; charset=UTF-8"
        },
        body: jsonEncode(<String,String>{
          "email": email,
          "hodpassword": password,
        })
    );

    if(response.statusCode ==200){
      print("hellow"+response.body);
      return jsonDecode(response.body);
    }
    else{
      throw Exception("Fail to send data");
    }
  }



  Future<dynamic> Sentdata(String hodname,department,gender,dob,age,phone,status,email,hodpassword) async {
    var client = http.Client();
    var apiurl = Uri.parse("http://"+localhost+":3001/hod/signup");
    var response = await client.post(apiurl, headers: <String, String>
    {
      "Content-Type": "application/Json;charset=UTF-8 "
    }, body: jsonEncode(<String, String>
    {
      "hodname": hodname,
      "department":department,
      "gender": gender,
      "dateofbirth": dob,
      "age": age,
      "phone": phone,
      "status":status,
      "email":email,
      "hodpassword": hodpassword,

    }
    )
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      throw Exception("Failed");
    }
  }

  Future<dynamic> SendRequest(String hodId,studentId,subject,description,department) async {
    var client = http.Client();
    var apiurl = Uri.parse("http://"+localhost+":3001/student/requestMessage");
    var response = await client.post(apiurl, headers: <String, String>
    {
      "Content-Type": "application/Json;charset=UTF-8 "
    }, body: jsonEncode(<String, String>
    {
      "hodId": hodId,
      "studentId":studentId,
      "subject": subject,
      "description": description,
      "department": department
    }
    )
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      throw Exception("Failed");
    }
  }


  Future<List<MessageModel>> getMessagesForHOD(String hodId) async {

    var client = http.Client();
    var apiUri = Uri.parse("http://"+localhost+":3001/student/requestDetails");
    var response = await client.post(apiUri,
      headers: <String, String>
      {
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String, String>
      { 'hodId': hodId
      }
      ),
    );
    if (response.statusCode == 200) {
      return messageModelFromJson(response.body);
    }
    else {
      throw Exception("Failed to send data");
    }
  }

  Future<dynamic> acceptStudentMessage(String requestId,String studentId,String admissionno,String studentName) async {

    var client = http.Client();
    var apiUri = Uri.parse("http://"+localhost+":3001/qrcode/createQrCode");
    var response = await client.post(apiUri,
      headers: <String, String>
      {
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String, String>
      {
        'requestId': requestId,
        'studentId': studentId,
        'admissionno': admissionno,
        'studentName': studentName,
      }
      ),
    );
    if (response.statusCode == 200) {
      var resp = response.body;
      return jsonDecode(resp);
    }
    else {
      throw Exception("Failed to send data");
    }
  }

  Future<dynamic> rejectMessage(String requestId) async {

    var client = http.Client();
    var apiUri = Uri.parse("http://"+localhost+":3001/student/rejectMessage");
    var response = await client.post(apiUri,
      headers: <String, String>
      {
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String, String>
      { '_id': requestId
      }
      ),
    );
    if (response.statusCode == 200) {
      var resp = response.body;
      return jsonDecode(resp);
    }
    else {
      throw Exception("Failed to send data");
    }
  }




}