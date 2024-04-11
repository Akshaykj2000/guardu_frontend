import 'package:feems/pages/studentHomePage.dart';
import 'package:feems/services/hodServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagePage extends StatefulWidget {
  final String hodName;
  final String hodId;

  MessagePage({Key? key, required this.hodName, required this.hodId}) : super(key: key);


  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late Future<void> _fetchHODsFuture;

  String  userId = '',name='',dept='',subject="Permission for exit";
TextEditingController description =new TextEditingController();
  @override
  void initState() {
    super.initState();
    _fetchHODsFuture=_fetchHODs();
  }

  Future<void> _fetchHODs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userid") ?? "";

setState(() {
  name = preferences.getString("name") ?? "";
});
    dept = preferences.getString("dept") ?? "";
    print("successfull uid : " + userId);
    print("Name is "+name);
    print("ID of HOD is "+widget.hodId);

  }


  void message() async {



    final response =await hodApiService().SendRequest(widget.hodId, userId, subject, description.text, dept);
    if (response['status'] == 'success') {
      print("Successfully added");

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Message send successfull",style: TextStyle(fontWeight: FontWeight.bold),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>studentHomePage())) ;
                },
                child: Text("OK",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87)),
              ),
            ],
          );
        },
      );


    } else {
      print("Error");
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        backgroundColor: Colors.white,
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
              color: Colors.blue,
              width: 2.0, // Border width
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column( crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("From  "+ name +",", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18,color: Colors.black87)),
                      SizedBox(height: 18,),
                      Text("To  "+ widget.hodName +",", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18,color: Colors.black87)),
                      SizedBox(height: 14,),

                    ],
                  ),
                ],
              ),
              SizedBox(height: 25,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16), // Add padding to the container
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue, // Set border color to blue
                      width: 3, // Increase border width
                    ),
                    borderRadius: BorderRadius.circular(20), // Set border radius
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Set background color to white
                      borderRadius: BorderRadius.circular(20), // Set border radius for inner container
                    ),
                    child: TextField(
                      controller: description,
                      keyboardType: TextInputType.multiline,
                      maxLines: null, // Set maxLines to null for unlimited lines
                      decoration: InputDecoration(
                        hintText: 'Compose your request here...',
                        border: InputBorder.none, // Hide border of TextField
                      ),
                    ),
                  ),
                ),
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
                        side: BorderSide(color: Colors.blueAccent),
                      ),

                      onPressed: () {  Navigator.pop(context);
                      },
                      child: Text('Back', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.blue[800]),),
                    ),
                  ),
                  SizedBox(
                    height: 47,width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800],
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          )
                      ),

                      onPressed:message,
                      child: Text('Send', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
