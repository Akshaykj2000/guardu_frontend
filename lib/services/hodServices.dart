import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class hodApiService{

  Future<dynamic> loginApi(String email ,String password) async{
    var client =http.Client();
    var url = Uri.parse("http://192.168.1.34:3001/hod/login");
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
    var apiurl = Uri.parse("http://192.168.1.34:3001/hod/signup");
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


}