import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:feems/models/studentModel.dart';

class studentApiService{

  Future<dynamic> loginApi(String email ,String password) async{
  var client =http.Client();
  var url = Uri.parse("http://192.168.1.35:3001/student/login");
  var response =await client.post(url,
      headers: <String,String>{
        "Content-Type" :"application/json ; charset=UTF-8"
      },
      body: jsonEncode(<String,String>{
        "emailid": email,
        "password": password,
      })
  );

  if(response.statusCode ==200){
    return jsonDecode(response.body);
  }
  else{
    throw Exception("Fail to send data");
  }
}



  Future<dynamic> Sentdata(String name,admissionNo,dob,age,contactno,gender,classname,department,emailid,password,requestStatus) async {
    var client = http.Client();
    var apiurl = Uri.parse("http://192.168.1.35:3001/student/signup");
    var response = await client.post(apiurl, headers: <String, String>
    {
      "Content-Type": "application/Json;charset=UTF-8 "
    }, body: jsonEncode(<String, String>
    {
      "name": name,
      "admissionno": admissionNo,
      "dateofbirth": dob,
      "age": age,
      "contactno": contactno,
      "gender": gender,
      "class": classname,
      "department":department,
      "emailid":emailid,
      "password": password,
      "requestStatus":requestStatus
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

  Future<dynamic> viewProfile(String user_ID ) async{
    var client =http.Client();
    var url=Uri.parse("http://192.168.1.35:3001/student/myprofile");
    try{
      var response =await client.post(url,
        body: jsonEncode({"studentId":user_ID}),
        headers:<String,String>{
          "Content-Type": "application/json"
        },
      );
      if(response.statusCode == 200){
        return json.decode(response.body);
      }
      else{
        print(response);
        print("eroor");
        throw Exception("Invalid");
      }
    }
    finally{client.close();}
  }

  Future<dynamic> studentExit(String studentId,String name,admissionno,department,classname,contactno,gender) async {
    var client = http.Client();
    var apiurl = Uri.parse("http://192.168.1.35:3001/qrcode/storeStudentDetails");
    var response = await client.post(apiurl, headers: <String, String>
    {
      "Content-Type": "application/Json;charset=UTF-8 "
    }, body: jsonEncode(<String, String>
    {
      "studentId":studentId,
      "name": name,
      "admissionno": admissionno,
      "department":department,
      "class": classname,
      "contactno":contactno,
      "gender": gender,
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






}