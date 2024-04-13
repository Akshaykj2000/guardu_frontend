import 'package:feems/pages/securityBottomNavigator.dart';
import 'package:feems/services/securityServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class securityAddGuest extends StatefulWidget {

  const securityAddGuest({Key? key}) : super(key: key);


  @override
  State<securityAddGuest> createState() => _securityAddGuestState();
}

class _securityAddGuestState extends State<securityAddGuest> {
  late Future<void> _fetchDetailsFuture;
  String? typeofuser  ;
  String vehicle="no",eventType="entry",securityId='';
  TextEditingController name = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  TextEditingController description = TextEditingController();


  void initState() {
    super.initState();
    _fetchDetailsFuture=_fetchDetails();
  }

  Future<void> _fetchDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    securityId = preferences.getString("securityid") ?? "";
  }

  void saveDetails() async {

    if (description.text.isNotEmpty && name.text.isNotEmpty && phoneno.text.isNotEmpty && typeofuser != null  ) {
      print("All fields are filled.");
     final response = await securityApiService().SendGuestData(securityId, description.text, name.text, phoneno.text, typeofuser.toString(), vehicle, eventType);
      if (response['status'] == 'success') {
        print("Successfully added");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("Added successfully",style: TextStyle(fontWeight: FontWeight.bold),),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationBarApp())) ;
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Fill all the fields"),
            content: Text("All fields are required...",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text("OK",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87)),
              ),
            ],
          );
        },
      );
    }

  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset('assets/LOGO3.png', width: 143, height: 35,
            fit: BoxFit.contain,
          ),
          shape: Border(
            bottom: BorderSide(
              color: Colors.black26,
              width: 1.0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(25),
              color: Colors.white,
              child: Column(

                children: [
                  SizedBox(height: 20),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your name",
                      labelText: "Name",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: phoneno,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your contact No.",
                      labelText: "Contact No.",
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: Icon(Icons.contact_phone, color: Colors.black87),
                    ),
                  ),

                  SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    value: typeofuser,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setState(() {
                          typeofuser = newValue;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Type of person",
                      labelText: "Select person type",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    items: <String>['Parent', 'Guest', 'Worker','Other']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  TextField(
                    controller: description,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter entry reason",
                      labelText: "Enter entry reason",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),



                  SizedBox(height: 40),
                  SizedBox(
                    width: 400,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed:saveDetails,
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: 400,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue[900],
                        side: BorderSide(color: Colors.blue[900]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationBarApp()));},
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


