import 'package:flutter/material.dart';
import 'package:feems/models/hodModel.dart';
import 'package:feems/services/adminServices.dart';

class ViewHods extends StatefulWidget {
  const ViewHods({Key? key}) : super(key: key);

  @override
  State<ViewHods> createState() => _ViewHodsState();
}

class _ViewHodsState extends State<ViewHods> {
  Future<List<HodModel>>? data;

  @override
  void initState() {
    super.initState();
    data = adminApiService().getAccptedHodApi();
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
                  final hod = snapshot.data![index];
                  return Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 21,
                            backgroundColor: Colors.black,
                            child: Text(
                              hod.hodname[0],
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 21),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hod.hodname,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  ' ${hod.email}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  ' ${hod.phone}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Age: ${hod.age}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Date of Birth: ${hod.dateofbirth}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                         Text(snapshot.data![index].department,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("No data available"),
              );
            }
          },
        ),
      ),
    );
  }
}
