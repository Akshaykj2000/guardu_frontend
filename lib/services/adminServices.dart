import 'dart:convert';
import 'package:feems/models/hodModel.dart';
import 'package:http/http.dart' as http;
import 'package:feems/models/securityModel.dart';

String localhost="192.168.1.36";
class adminApiService{

  Future<List<HodModel>> getHodApi() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://"+localhost+":3001/admin/pendingHODs");

    var response = await client.get(apiUrl);
    if (response.statusCode == 200) {
      return hodModelFromJson(response.body);
    }
    else {
      return [];
    }
  }

  Future<List<HodModel>> getAccptedHodApi() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://"+localhost+":3001/admin/acceptedHODs");

    var response = await client.get(apiUrl);
    if (response.statusCode == 200) {
      return hodModelFromJson(response.body);
    }
    else {
      return [];
    }
  }

  Future<List<SecurityModel>> getSecurityApi() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://"+localhost+":3001/admin/allsecurity");

    var response = await client.get(apiUrl);
    if (response.statusCode == 200) {
      return securityModelFromJson(response.body);
    }
    else {
      return [];
    }
  }

  Future<dynamic> acceptHOD(String hodId) async {

    var client = http.Client();
    var apiUri = Uri.parse("http://"+localhost+":3001/admin/accepthod");
    var response = await client.post(apiUri,
      headers: <String, String>
      {
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String, String>
      { '_id': hodId
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



  Future<dynamic> sendSecurityEmailApi(String emailid,String subject,String password,String name) async
  {

  var client =http.Client();
  var apiUrl= Uri.parse("http://"+localhost+":3001/admin/sendEmail");

  var response =await client.post(apiUrl,
  headers: <String,String>{
  "Content-Type" : "application/json; charset=UTF-8"
  },
  body: jsonEncode(<String,String>{
  'to': emailid,
  'subject': subject,
  'password': password,
  'name': name,
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


}