import 'package:feems/models/entryModel.dart';
import 'package:feems/pages/scanningPage.dart';
import 'package:feems/services/securityServices.dart';
import 'package:flutter/material.dart';


class GuestEntryScreen extends StatefulWidget {
  const GuestEntryScreen({Key? key}) : super(key: key);

  @override
  State<GuestEntryScreen> createState() => __GuestEntryScreenState();
}

class __GuestEntryScreenState extends State<GuestEntryScreen> {
  Future<List<EntryModel>>? data;

  @override
  void initState() {
    super.initState();
    data = securityApiService().getGuestDetails();
  }

  // void exitVehicle(String entryId) async{
  //   try{
  //     final response=  await securityApiService().exitVehicles(entryId);
  //
  //     if(response["status"]=="updated")
  //     {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text("Exit",style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.bold,)),
  //             content: Text("Exit details added successfully",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context); // Close the dialog
  //                 },
  //                 child: Text("OK",style: TextStyle(color: Colors.black),),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //     else
  //     {
  //       print("Error");
  //     }
  //     setState(() {
  //       data = securityApiService().getGuestDetails();
  //     });
  //
  //   }
  //   catch(error){
  //     print("Error on rejecting $error");
  //   }
  // }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Image.asset('assets/LOGO4.png', width: 143, height: 35),
            ),
          ],
        ),
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
                    color: Colors.white,
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
                              color: Colors.blue[900],
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data![index].phoneno +
                                  "\n" +
                                  snapshot.data![index].typeofuser,
                                style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                              ),
                              Text(snapshot.data![index].description ,

                                style: TextStyle(fontSize: 16, color: Colors.black,),
                              ),
                              Text(snapshot.data![index].entryTime ,

                                style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),


                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[900],
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPressed: () {
                                //exitVehicle(snapshot.data![index].id);
                              },
                              child: Text(
                                "Exit",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),

                          ],
                        ),
                        SizedBox(height: 10,),
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
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.redAccent,
        backgroundColor:Colors.black,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()),);
        },
        child: Icon(Icons.add),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }
}
