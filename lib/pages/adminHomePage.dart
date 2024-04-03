import 'package:flutter/material.dart';
import 'package:feems/models/hodModel.dart';
import 'package:feems/services/adminServices.dart';


class adminHomeScreen extends StatefulWidget {
  const adminHomeScreen({Key? key}) : super(key: key);

  @override
  State<adminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<adminHomeScreen> {
  Future<List<HodModel>>? data;

  @override
  void initState() {
    super.initState();
  // Future<void> acceptHOD(String hodId) async {
  //   try {
  //     var response = await http.post(
  data = adminApiService().getHodApi();
}



  void acceptHOD(String hodId) async {
    try {
      await adminApiService().acceptHOD(hodId); // Call the acceptHOD function
      // Optionally, update the UI after accepting the HOD
      setState(() {
        data = adminApiService().getHodApi();
      });
      print("HOD accepted: $hodId");
    } catch (error) {
      print("Error accepting HOD: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white54,
        child: FutureBuilder(
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
                      children: [
                        SizedBox(height: 10,),
                        ListTile(
                          title: Text(
                            snapshot.data![index].hodname,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[500],
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data![index].phone +
                                "\n" +
                                snapshot.data![index].email,
                            style: TextStyle(fontSize: 16, color: Colors.black,),
                          ),
                          trailing: Text(
                            snapshot.data![index].department,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPressed: () {
                                acceptHOD(snapshot.data![index].id);
                              },
                              child: Text(
                                "Accept",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Reject",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  );
                },
              );
            } else {
              return
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Image.asset('assets/img.png', width: 400, height: 400),

              Text("No Request from faculty ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black54),)
                ],
            );
            }
          },
        ),
      ),
    );
  }
}
