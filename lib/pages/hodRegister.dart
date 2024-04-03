import 'package:feems/pages/hodLoginPage.dart';
import 'package:feems/pages/studentLogin.dart';
import 'package:feems/services/hodServices.dart';
import 'package:feems/services/studentServices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class hodRegister extends StatefulWidget {
  const hodRegister({Key? key}) : super(key: key);

  @override
  State<hodRegister> createState() => _hodRegisterState();
}

class _hodRegisterState extends State<hodRegister> {
  String? gender , department ;
  String status = "pending";
  TextEditingController name = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController contactno = TextEditingController();
  TextEditingController emailid = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dob.text = DateFormat('yyyy-MM-dd').format(picked); // Using DateFormat here
        _calculateAge(picked);
      });
    }
  }

  void _calculateAge(DateTime selectedDate) {
    DateTime currentDate = DateTime.now();
    int userAge = currentDate.year - selectedDate.year;
    if (currentDate.month < selectedDate.month ||
        (currentDate.month == selectedDate.month &&
            currentDate.day < selectedDate.day)) {
      userAge--;
    }

    setState(() {
      age.text = userAge.toString();
    });
  }

  void regUser() async {


    final response =await hodApiService().Sentdata(name.text, department, gender, dob.text, age.text, contactno.text, status,
        emailid.text, password.text);

    if (response['status'] == 'success') {
      print("Successfully added");

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Signup successfull",style: TextStyle(fontWeight: FontWeight.bold),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>hodLogin())) ;
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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset('assets/LOGO4.png', width: 143, height: 35,
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
                  ),
                ),
                SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  value: department,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        department = newValue;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Department",
                    labelText: "Select Department",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  items: <String>['MCA', 'MBA', 'BTECH','Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  value: gender,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        gender = newValue;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Gender",
                    labelText: "Select Gender",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  items: <String>['Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),


                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: dob,
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "DoB",
                          labelText: "Date of Birth",
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Add some spacing between the text fields
                    Expanded(
                      child: TextField(
                        controller: age,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter your age",
                          labelText: "Age",
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),



                SizedBox(height: 20),

                TextField(
                  controller: contactno,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your contact No.",
                    labelText: "Contact No.",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),

                SizedBox(height: 50),
                TextField(
                  controller: emailid,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your email ID",
                    labelText: "Email ID",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                    labelText: "Password",
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: Icon(Icons.key_outlined, color: Colors.black87),
                  ),
                ),

                SizedBox(height: 40),
                SizedBox(
                  width: 400,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: regUser,
                    child: Text(
                      "Register",
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


