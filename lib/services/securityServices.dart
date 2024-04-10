import 'dart:convert';
import 'dart:io';
import 'package:feems/models/entryModel.dart';
import 'package:feems/models/hodModel.dart';
import 'package:http/http.dart' as http;
import 'package:feems/models/securityModel.dart';

class securityApiService{


  Future<dynamic> loginApi(String email ,String password) async{
    var client =http.Client();
    var url = Uri.parse("http://192.168.1.35:3001/security/securitylogin");
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
      print("security success");
      return jsonDecode(response.body);
    }
    else{
      throw Exception("Fail to send data");
    }
  }



  Future<dynamic> addSecurityApi(String name,String contactno,String post,String emailid,String password) async
  {

  var client =http.Client();
  var apiUrl= Uri.parse("http://192.168.1.35:3001/admin/addsecurity");

  var response =await client.post(apiUrl,
  headers: <String,String>{
  "Content-Type" : "application/json; charset=UTF-8"
  },
  body: jsonEncode(<String,String>{
  "name": name,
  "contactno": contactno,
  "post": post,
  "emailid": emailid,
  "password": password,
  })
  );
  if(response.statusCode==200)
  {
  return json.decode(response.body);
  }
  else
  {
  throw Exception("failed to add");
  }
  }


  Future<List<EntryModel>> getEntryDetails() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://192.168.1.35:3001/security/viewNullEntry");

    var response = await client.get(apiUrl);
    if (response.statusCode == 200) {
      return entryModelFromJson(response.body);
    }
    else {
      return [];
    }
  }



}