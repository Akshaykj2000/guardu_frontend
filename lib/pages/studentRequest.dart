import 'package:feems/pages/messagePage.dart';
import 'package:flutter/material.dart';
import 'package:feems/models/hodModel.dart';
import 'package:feems/services/adminServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentRequest extends StatefulWidget {
  const StudentRequest({Key? key}) : super(key: key);

  @override
  State<StudentRequest> createState() => _ViewHodsState();
}

class _ViewHodsState extends State<StudentRequest> {
  Future<List<HodModel>>? data;
  String  dept = '';

  @override
  void initState() {
    super.initState();
    data = adminApiService().getAccptedHodApi();
    _fetchHODs();
  }
  @override
  Future<void> _fetchHODs() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    dept = preferences.getString("dept") ?? "";
    print("successfull uid : " + dept);
  }

  @override
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
        shape: const Border(
          bottom: BorderSide(
            color: Colors.black26,
            width: 1.0, // Border width
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'SELECT FACULTY', // Your text here
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ),
          Expanded(
            child: Container(

              color: Colors.white,
              padding: EdgeInsets.all(8),
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
                        if (hod.department != dept) {
                          return SizedBox.shrink(); // Skip rendering the card
                        }
                        return Card(
                          color: Colors.blue[800],
                          elevation: 5,
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
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    hod.hodname[0],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 21,
                                    ),
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
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        snapshot.data![index].department,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        ' ${hod.email}',
                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,
                                          color: Colors.blue[100],),
                                      ),
                                      Text(
                                        ' ${hod.phone}',
                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,
                                          color: Colors.blue[100],),
                                      ),

                                    ],
                                  ),
                                ),


                                ElevatedButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MessagePage(
                                    hodName: snapshot.data![index].hodname,
                                    hodId: snapshot.data![index].id)));
                                }, child: Text("Send",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black87),))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  else {
                    return Center(
                      child: Text("No data available"),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
