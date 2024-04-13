import 'package:feems/pages/securityBottomNavigator.dart';
import 'package:feems/services/securityServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class securityAddVehicle extends StatefulWidget {
  final String vehicleNumber;
  const securityAddVehicle({Key? key,required this.vehicleNumber}) : super(key: key);


  @override
  State<securityAddVehicle> createState() => _securityAddVehicleState();
}

class _securityAddVehicleState extends State<securityAddVehicle> {
  late Future<void> _fetchDetailsFuture;
  String? vehicleType,typeofuser  ;
  String vehicle="yes",eventType="entry",securityId='';
  TextEditingController name = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  TextEditingController vehicleName = TextEditingController();
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
    String inputString= widget.vehicleNumber;
    String vno=inputString.replaceAll(RegExp(r'\s+'), '');

    if (description.text.isNotEmpty && name.text.isNotEmpty && phoneno.text.isNotEmpty && typeofuser != null && vehicleName.text.isNotEmpty && vehicleType != null && vno !='' ) {

      final response = await securityApiService().Senddata(securityId, description.text, name.text, phoneno.text, typeofuser.toString(), vehicle, vno.toString(), vehicleName.text, vehicleType.toString(), eventType);
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
        backgroundColor: Colors.blue[900],
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
          child: Container(
            padding: EdgeInsets.all(25),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    suffixIcon: Icon(Icons.drive_file_rename_outline, color: Colors.black87),
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
                    suffixIcon: Icon(Icons.clear_all_rounded, color: Colors.black87),
                  ),
                ),

                SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  value: vehicleType,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        vehicleType = newValue;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Type of vehicle",
                    labelText: "Select vehicle type",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  items: <String>['Car', 'Bike', 'Scooter','Heavy vehicle']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: vehicleName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Vehicle Name",
                    labelText: "Vehicle Name",
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: Icon(Icons.local_taxi_rounded, color: Colors.black87),
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
    );
  }
}


