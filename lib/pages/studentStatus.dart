import 'dart:async';
import 'package:feems/pages/securityBottomNavigator.dart';
import 'package:feems/services/studentServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentStatus extends StatefulWidget {


  const StudentStatus({Key? key}) : super(key: key);

  @override
  State<StudentStatus> createState() => _StudentStatusState();
}



class _StudentStatusState extends State<StudentStatus> {
  Map<String, dynamic> searchResult = {};
  late Future<void> _fetchHODsFuture;
  late String userId;

  @override
  void initState() {
    super.initState();
    _fetchHODsFuture=_fetchHODs();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final response = await studentApiService().studentStatus(userId);
      if (response != null && mounted) {
        setState(() {
          searchResult = Map<String, dynamic>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }


  Future<void> _fetchHODs() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userid") ?? "";

  }

  @override

  void exitStudent() async {
    try {

      print(userId);
      final response = await studentApiService().studentExit(
        userId, // Use searchResult to access studentId
        searchResult['name'], // Use searchResult to access name
        searchResult['admissionno'], // Use searchResult to access admissionno
        searchResult['department'], // Use searchResult to access department
        searchResult['class'], // Use searchResult to access class
        searchResult['contactno'], // Use searchResult to access contactno
        searchResult['gender'], // Use searchResult to access gender
      );

      if (response['status'] == 'success') {
        print("Successfully added");

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Exit granted"),
              content: Text(
                "Student details added to log",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavigationBarApp()),
                    ); // Go back to the previous screen
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        print("Error");
      }
    } catch (error) {
      print('Error storing student details: $error');
      // Handle any errors that occurred during the process
      // Show a snackbar or other notification to indicate the error
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 75.0), // Adjust this value as needed
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Card(
                  color: Colors.black87,
                  elevation: 9,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/img_1.png', // Adjust the path to your image
                        fit: BoxFit.cover,
                        width: double.infinity, // Cover the entire width of the card
                        height: 200, // Adjust the height of the image as needed
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ${searchResult['name']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Admission No: ${searchResult['admissionno']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,color: Colors.white
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Department: ${searchResult['department']}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,color: Colors.white
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Class: ${searchResult['class']}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,color: Colors.white
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Contact No: ${searchResult['contactno']}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,color: Colors.white
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Gender: ${searchResult['gender']}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,color: Colors.white
                              ),
                            ),
                            SizedBox(height: 23),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[800],
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationBarApp()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.arrow_back_rounded, // Adjust the icon as needed
                                        size: 22, // Adjust the size of the icon as needed
                                      ),
                                      SizedBox(width: 4), // Add space between icon and text
                                      Text(
                                        "Back",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[800],
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  onPressed: exitStudent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.exit_to_app, // Adjust the icon as needed
                                        size: 24, // Adjust the size of the icon as needed
                                      ),
                                      SizedBox(width: 4), // Add space between icon and text
                                      Text(
                                        "Exit",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
