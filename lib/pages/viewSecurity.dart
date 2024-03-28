import 'package:flutter/material.dart';
import 'package:feems/services/adminServices.dart';
import 'package:feems/models/securityModel.dart';

class ViewSecurity extends StatefulWidget {
  const ViewSecurity({Key? key}) : super(key: key);

  @override
  State<ViewSecurity> createState() => _ViewSecurityState();
}

class _ViewSecurityState extends State<ViewSecurity> {
  Future<List<SecurityModel>>? data;

  @override
  void initState() {
    super.initState();
    data = adminApiService().getSecurityApi();
  }

  void sendMail(String email,String password,String name) async{
  String subject="GuardU login credentials for "+name;

    final response =await adminApiService().sendSecurityEmailApi(email, subject, password, name);

    if(response["status"]=="Email sent successfully")
    {
      print("successfully added");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Email send successfully to "+name),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewSecurity())) ;// Go back to the previous screen
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
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final security = snapshot.data![index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.blue[200],
                            child: Text(
                              security.name[0].toUpperCase(),
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  security.name,
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Email: ${security.emailid}',
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  'Contact: ${security.contactno}',
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Post: ${security.post}',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                         child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shadowColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)
                                )
                              ),
                              onPressed: (){
                                sendMail(snapshot.data![index].emailid,snapshot.data![index].password,snapshot.data![index].name);
                              }, child: Text("Send Mail",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
                          )
                        ],
                      ),

                    ),
                  );
                },
              );
            } else {
              return Center(child: Text("No data available"));
            }
          },
        ),
      ),
    );
  }
}
