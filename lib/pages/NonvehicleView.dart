import 'package:feems/models/entryModel.dart';
import 'package:feems/pages/scanningPage.dart';
import 'package:feems/services/securityServices.dart';
import 'package:flutter/material.dart';


class NonVehicleView extends StatefulWidget {
  const NonVehicleView({Key? key}) : super(key: key);

  @override
  State<NonVehicleView> createState() => _NonVehicleViewState();
}

class _NonVehicleViewState extends State<NonVehicleView> {
  Future<List<EntryModel>>? data;

  @override
  void initState() {
    super.initState();
    data = securityApiService().nonVehicleDetails();
  }




  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                              Text(snapshot.data![index].phoneno ,

                                style: TextStyle(fontSize: 16, color: Colors.white,),
                              ),
                              Text(snapshot.data![index].typeofuser ,

                                style: TextStyle(fontSize: 16, color: Colors.white,),
                              ),
                              Text("Reason : "+snapshot.data![index].description ,

                                style: TextStyle(fontSize: 16, color: Colors.white,),
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Entry time :" ,
                                    style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w400),
                                  ),
                                  Text(snapshot.data![index].entryTime.substring(10),

                                    style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),

                              if(snapshot.data![index].exitTime =='nill')
                                Row(
                                  children: [
                                    Text(
                                      "Exit time :" ,
                                      style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w400),
                                    ),
                                    Text("Waiting for exit" ,
                                      style: TextStyle(fontSize: 16, color: Colors.green,fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              if(snapshot.data![index].exitTime !='nill')
                                Row(
                                  children: [
                                    Text(
                                      "Exit time :" ,
                                      style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w400),
                                    ),
                                    Text(snapshot.data![index].exitTime,
                                      style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(snapshot.data![index].entryTime.substring(0, 10) ,

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
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.red,
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
