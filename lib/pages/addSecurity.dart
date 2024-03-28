import 'package:feems/pages/adminHomePage.dart';
import 'package:feems/pages/menu.dart';
import 'package:feems/services/securityServices.dart';
import 'package:flutter/material.dart';
class Add_Security extends StatefulWidget {
  const Add_Security({super.key});
  @override
  State<Add_Security> createState() => _Add_SecurityState();
}
class _Add_SecurityState extends State<Add_Security> {
  TextEditingController name=new TextEditingController();
  TextEditingController conatcctno=new TextEditingController();
  TextEditingController post=new TextEditingController();
  TextEditingController emailid=new TextEditingController();
  TextEditingController passwrd=new TextEditingController();


  void SendValuesToApiAddSecurity() async {

    final response = await securityApiService().addSecurityApi(
        name.text,
        conatcctno.text,
        post.text,
        emailid.text,
        passwrd.text
    );

    if(response["status"]=="success")
    {
      print("successfully added");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Security added successfully."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>menu())) ;// Go back to the previous screen
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
    else
    {
      print("Error");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white
          ),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 60,),
              TextField(
                controller: name,
                decoration: InputDecoration(
                    labelText: "Name",
                    hintText: " Package name",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: conatcctno,
                keyboardType:TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Contact No.",
                    hintText: "Enter Contact Number",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 25,),
              TextField(
                controller: post,
                decoration: InputDecoration(
                    labelText: "post",
                    hintText: "Enter security post",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 25,),
              TextField(
                controller: emailid,
                decoration: InputDecoration(
                    labelText: "emailID",
                    hintText: "Enter EmailID ",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 25,),
              TextField(
                controller: passwrd,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter password ",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),SizedBox(height: 20,),
              SizedBox(
                height: 45,
                width: 150,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )),
                    onPressed:SendValuesToApiAddSecurity, child:Text("ADD",style: TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),)),),
            ],
          ),
        ),
      ),);
  }
}