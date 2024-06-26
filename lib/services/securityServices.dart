import 'dart:convert';
import 'dart:io';
import 'package:feems/models/entryModel.dart';
import 'package:feems/models/studentExitModel.dart';
import 'package:http/http.dart' as http;

String localhost="192.168.1.36";
class securityApiService{


  Future<dynamic> loginApi(String email ,String password) async{
    var client =http.Client();
    var url = Uri.parse("http://"+localhost+":3001/security/securitylogin");
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
  var apiUrl= Uri.parse("http://"+localhost+":3001/admin/addsecurity");

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
    var apiUrl = Uri.parse("http://"+localhost+":3001/security/viewNullEntry");

    var response = await client.get(apiUrl);
    if (response.statusCode == 200) {
      return entryModelFromJson(response.body);
    }
    else {
      return [];
    }
  }


  Future<dynamic> Senddata(String securityId,description,name,phoneno,typeofuser,vehicle,vehicleNumber,vehicleName,vehicleType,eventType) async {
    var client = http.Client();
    var apiurl = Uri.parse("http://"+localhost+":3001/security/entrylog");
    var response = await client.post(apiurl, headers: <String, String>
    {
      "Content-Type": "application/Json;charset=UTF-8 "
    }, body: jsonEncode(<String, String>
    {
      "securityId": securityId,
      "description": description,
      "name": name,
      "phoneno": phoneno,
      "typeofuser": typeofuser,
      "vehicle": vehicle,
      "vehicleNumber":vehicleNumber,
      "vehicleName":vehicleName,
      "vehicleType": vehicleType,
      "eventType":eventType
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

  Future<dynamic> SendGuestData(String securityId,description,name,phoneno,typeofuser,vehicle,eventType) async {
    var client = http.Client();
    var apiurl = Uri.parse("http://"+localhost+":3001/security/entrylog");
    var response = await client.post(apiurl, headers: <String, String>
    {
      "Content-Type": "application/Json;charset=UTF-8 "
    }, body: jsonEncode(<String, String>
    {
      "securityId": securityId,
      "description": description,
      "name": name,
      "phoneno": phoneno,
      "typeofuser": typeofuser,
      "vehicle": vehicle,
      "eventType":eventType
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


  Future<dynamic> exitVehicles(String entryId) async {

    var client = http.Client();
    var apiUri = Uri.parse("http://"+localhost+":3001/security/updateExit");
    var response = await client.post(apiUri,
      headers: <String, String>
      {
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String, String>
      { '_id': entryId
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

  Future<List<EntryModel>> getGuestDetails() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://"+localhost+":3001/security/viewEntry");

    var response = await client.get(apiUrl);
    if (response.statusCode == 200) {
      return entryModelFromJson(response.body);
    }
    else {
      return [];
    }
  }


  Future<List<EntryModel>> vehicleDetails() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://"+localhost+":3001/security/viewvehicleentry");

    var response = await client.get(apiUrl);
    if (response.statusCode == 200) {
      return entryModelFromJson(response.body);
    }
    else {
      return [];
    }
  }

  Future<List<EntryModel>> nonVehicleDetails() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://"+localhost+":3001/security/viewgustentry");

    var response = await client.get(apiUrl);
    if (response.statusCode == 200) {
      return entryModelFromJson(response.body);
    }
    else {
      return [];
    }
  }

  Future<List<StudentExitModel>> studentExitDetails() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://"+localhost+":3001/security/viewStudentExit");

    var response = await client.get(apiUrl);
    if (response.statusCode == 200) {
      return studentExitModelFromJson(response.body);
    }
    else {
      return [];
    }
  }

}