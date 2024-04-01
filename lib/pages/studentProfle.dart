import 'dart:async';
import 'package:feems/services/studentServices.dart';
import 'package:flutter/material.dart';

class StudentProfile extends StatefulWidget {
  final String studentId; // Add studentId parameter to the constructor

  const StudentProfile({Key? key, required this.studentId}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  Map<String, dynamic> searchResult = {};
  late String userId; // Declare userId variable

  @override
  void initState() {
    super.initState();
    userId = widget.studentId; // Initialize userId with studentId from widget
    loadData();
  }

  Future<void> loadData() async {
    print(userId);

    try {
      final response = await studentApiService().viewProfile(userId);
      if (response != null && mounted) {
        setState(() {
          searchResult = Map<String, dynamic>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
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
        shape: Border(
          bottom: BorderSide(
            color: Colors.black26,
            width: 1.0, // Border width
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            title: Text(
              "Name: ${searchResult['name']}",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              "Admission No: ${searchResult['admissionno']}" +
                  "\nDepartment: ${searchResult['department']}" +
                  "\nClass: ${searchResult['class']}" +
                  "\nContact No.: ${searchResult['contactno']}" +
                  "\nGender: ${searchResult['gender']}",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
