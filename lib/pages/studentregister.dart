import 'package:feems/pages/studentLogin.dart';
import 'package:feems/services/studentServices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudentRegister extends StatefulWidget {
  const StudentRegister({Key? key}) : super(key: key);

  @override
  State<StudentRegister> createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> {
  String? gender , department ,classname;
  String requestStatus = "nill";
  TextEditingController name = TextEditingController();
  TextEditingController admissionNo = TextEditingController();
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
    final response = await studentApiService().Sentdata(
      name.text, admissionNo.text, dob.text, age.text, contactno.text, gender,
        classname,department,emailid.text,password.text,requestStatus
    );

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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage())) ;// Go back to the previous screen
                },
                child: Text("OK"),
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
          backgroundColor: Color(0xFF752FFF),
          title: Text(
            "FitFusion",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
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
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: admissionNo,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your admission No.",
                    labelText: "Admission No.",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),

                TextField(
                  controller: contactno,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your contact No.",
                    labelText: "Contact No.",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: dob,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "DoB",
                    labelText: "Date of Birth",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: age,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your age",
                    labelText: "Age",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
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
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
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
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                  items: <String>['MCA', 'MBA', 'BTECH']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  value: classname,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        classname = newValue;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "class",
                    labelText: "Select class",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                  items: <String>['A', 'B', 'C']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                SizedBox(height: 20),
                TextField(
                  controller: emailid,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your email ID",
                    labelText: "Email ID",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
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
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                    suffixIcon: Icon(Icons.key_outlined, color: Color(0xFF752FFF)),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
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


