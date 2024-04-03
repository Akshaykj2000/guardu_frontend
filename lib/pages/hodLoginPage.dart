import 'package:animate_do/animate_do.dart';
import 'package:feems/pages/hodRegister.dart';
import 'package:feems/pages/securityBottomNavigator.dart';
import 'package:feems/pages/studentLogin.dart';
import 'package:feems/services/hodServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class hodLogin extends StatefulWidget {
  @override
  _hodLoginState createState() => _hodLoginState();
}

class _hodLoginState extends State<hodLogin> {

  String email="",password="",message="";
  TextEditingController n1 =new TextEditingController();
  TextEditingController n2 =new TextEditingController();

  void loginCheck() async {
    final response = await hodApiService().loginApi(n1.text, n2.text);

  if (response["status"] == "success") {
      String userId = response["userdata"]["_id"].toString();

      SharedPreferences.setMockInitialValues({});
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("hodid", userId);

      print("successfull hodid" + userId);
      String statusOfHod = response["userdata"]["status"].toString();
      if(statusOfHod =="pending" )
      {
        setState(() {
          message = "Waiting for admin's approval";
        });
      }
      else if(statusOfHod =="rejected"){
        setState(() {
          message = "Rejected request";
        });
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationBarApp()));
      }
    } else if (response["status"] == "Invalid user") {
      setState(() {
        message = "Invalid emailID";
      });
    } else if (response["status"] == "Incorrect password") {
      setState(() {
        message = "Invalid Password";
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 400,
                    width: width,
                    child: FadeInUp(duration: Duration(seconds: 1), child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/background-2.png"),
                              fit: BoxFit.fill
                          )
                      ),
                    )),
                  ),
                  Positioned(
                    height: 400,
                    width: width+20,
                    child: FadeInUp(duration: Duration(milliseconds: 1000), child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/background-2.png'),
                              fit: BoxFit.fill
                          )
                      ),
                    )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(duration: Duration(milliseconds: 1500), child: Text("Faculty Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
                  SizedBox(height: 16,),
                  FadeInUp(duration: Duration(milliseconds: 1700), child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: Color.fromRGBO(196, 135, 198, .3)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )
                        ]
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color: Color.fromRGBO(196, 135, 198, .3)
                              ))
                          ),
                          child: TextField(
                            controller: n1,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "EmailID",
                                hintStyle: TextStyle(color: Colors.grey.shade700)
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: n2,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey.shade700)
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                  SizedBox(height: 20,),
                  Text(message,style: TextStyle(fontSize: 15,color:Colors.red )),

                  SizedBox(height: 13,),
                  FadeInUp(duration: Duration(milliseconds: 1900), child: MaterialButton(
                    onPressed: loginCheck,
                    color: Color.fromRGBO(49, 39, 79, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 50,
                    child: Center(
                      child: Text("Login", style: TextStyle(color: Colors.white),),
                    ),
                  )),
                  SizedBox(height: 16,),
                  FadeInUp(duration: Duration(milliseconds: 1900), child: MaterialButton(
                    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));},
                    color: Color.fromRGBO(49, 39, 79, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 50,
                    child: Center(
                      child: Text("Back", style: TextStyle(color: Colors.white),),
                    ),
                  )),

                  SizedBox(height: 15,),
                  FadeInUp(duration: Duration(milliseconds: 2000), child: Center(child: TextButton(onPressed:(){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>hodRegister()));
                  }, child: Text("Create Account", style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),)))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
