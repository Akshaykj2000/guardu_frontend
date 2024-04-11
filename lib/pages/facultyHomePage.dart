import 'package:feems/models/messageModel.dart';
import 'package:feems/pages/studentLogin.dart';
import 'package:feems/services/hodServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FacultyHomeScreen extends StatefulWidget {
  const FacultyHomeScreen({Key? key}) : super(key: key);

  @override
  State<FacultyHomeScreen> createState() => _FacultyHomeScreenState();
}

class _FacultyHomeScreenState extends State<FacultyHomeScreen> {
  late Future<List<MessageModel>> _data;
  String _hodId = '';

  @override
  void initState() {
    super.initState();
    _fetchHODs();
  }

  Future<void> _fetchHODs() async {
    final preferences = await SharedPreferences.getInstance();
    _hodId = preferences.getString('hodid') ?? '';
    print('HOD ID: $_hodId');

    setState(() {
      _data = hodApiService().getMessagesForHOD(_hodId);
    });
  }

  void acceptStudent(String requestId,String studentId,String admissionno,String studentName) async {

    try {

    final response2=  await hodApiService().acceptStudentMessage(requestId, studentId, admissionno, studentName);
      // Optionally, update the UI after accepting the HOD
      setState(() {
        _data = hodApiService().getMessagesForHOD(_hodId);
      });
      if(response2["status"]=="success")
      {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Accpted",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
              content: Text("Permission granded to "+studentName),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text("OK",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print("Error accepting HOD: $error");
    }
  }

  void rejectMessage(String requestId) async{
    try{
    final response=  await hodApiService().rejectMessage(requestId);
      setState(() {
        _data = hodApiService().getMessagesForHOD(_hodId);
      });

      if(response["status"]=="rejected")
      {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Rejected"),
              content: Text("Permission rejected"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text("OK",style: TextStyle(color: Colors.black),),
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
    catch(error){
      print("Error on rejecting $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
        shape: const Border(
          bottom: BorderSide(
            color: Colors.black26,
            width: 1.0,
          ),
        ),
      ),
      body: FutureBuilder<List<MessageModel>>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final message = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: 340,height: 400, // Set your desired width here
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${message.sendTime}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              'From: ${message.studentId.name}',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),

                            SizedBox(height: 10,),
                            Text("Department : "+
                                '${message.department}\n'+"Batch : "+'${message.studentId.studentIdClass}',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              '${message.subject}',
                              style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              '${message.description}',
                              style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w600),
                            ),

                            SizedBox(height: 20,),
                            Text("Admission No. : "+
                                '${message.studentId.admissionno}\n'"Contact No. : "+
                                '${message.studentId.contactno}\n'+"EmailID : "+'${message.studentId.emailid}',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 47,width: 120,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.blue[800],
                                      side: BorderSide(color: Colors.black),
                                    ),

                                    onPressed: () {
                                  acceptStudent(snapshot.data![index].id,snapshot.data![index].studentId.id,snapshot.data![index].studentId.admissionno,snapshot.data![index].studentId.name);
                                    },
                                    child: Text('Accept', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.blue[800]),),
                                  ),
                                ),
                                SizedBox(
                                  height: 47,width: 120,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        side: BorderSide(color: Colors.blue),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50)
                                        )
                                    ),

                                    onPressed:(){
                                      rejectMessage(snapshot.data![index].id);
                                    },
                                    child: Text('Reject', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),



                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/img.png', width: 400, height: 400),
                Text(
                  'No Request from students',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black54),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
