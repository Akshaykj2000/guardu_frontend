import 'package:feems/models/studentExitModel.dart';
import 'package:feems/pages/securityLogin.dart';
import 'package:feems/services/securityServices.dart';
import 'package:flutter/material.dart';


class HodViewStudentExit extends StatefulWidget {
  const HodViewStudentExit({Key? key}) : super(key: key);

  @override
  State<HodViewStudentExit> createState() => _ViewStudentExitState();
}

class _ViewStudentExitState extends State<HodViewStudentExit> {
  Future<List<StudentExitModel>>? data;

  @override
  void initState() {
    super.initState();
    data = securityApiService().studentExitDetails();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Image.asset('assets/LOGO3.png', width: 143, height: 35),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SecurityLogin()));
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
        shape: Border(
          bottom: BorderSide(
            color: Colors.black26,
            width: 1.0, // Border width
          ),
        ),
      ),
      body: Container(
        child:
        FutureBuilder(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFF28282B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        ListTile(
                          title: Text(
                            snapshot.data![index].name,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row( mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(snapshot.data![index].department ,
                                    style: TextStyle(fontSize: 18, color: Colors.redAccent,fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(snapshot.data![index].studentExitModelClass ,

                                    style: TextStyle(fontSize: 18, color: Colors.red,fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Text("Admission No :"+
                                  snapshot.data![index].admissionno,
                                style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w900),
                              ),


                              Text("Contact No :"+snapshot.data![index].contactno ,

                                style: TextStyle(fontSize: 16, color: Colors.white,),
                              ),

                              Text(snapshot.data![index].gender ,

                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),


                              Row(
                                children: [
                                  Text(
                                    "Exit time :" ,
                                    style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w400),
                                  ),
                                  Text(snapshot.data![index].exitTime.substring(10),
                                    style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(snapshot.data![index].exitTime.substring(0, 10) ,

                                    style: TextStyle(fontSize: 16, color: Colors.blueAccent,fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                            ],
                          ),





                        ),

                      ],
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),

      ),


    );
  }
}
