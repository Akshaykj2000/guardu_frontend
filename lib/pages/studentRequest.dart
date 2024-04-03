import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class studentRequest extends StatefulWidget {
  @override
  _studentRequestState createState() => _studentRequestState();
}

class _studentRequestState extends State<studentRequest> {
  List<dynamic> _hodList = [];
  String _selectedHod = '';
  String dept = '',department='',userId=''; // Department fetched from SharedPreferences or other storage

  @override
  void initState() {

    super.initState();
    // Fetch HODs corresponding to the department
    _fetchHODs();
  }

  Future<void> _fetchHODs() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
       userId = preferences.getString("userid") ?? "";
      department= preferences.getString("dept") ?? "";

      final response = await http.post(
        Uri.parse('http://192.168.1.34:3001/hod/getHODsByDepartment'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'department': department}),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _hodList = responseData['hodList'];
        });
      } else {
        throw Exception('Failed to load HODs');
      }
    } catch (e) {
      print('Error: $e');
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedHod,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedHod = newValue!;
                });
              },
              items: _hodList.map<DropdownMenuItem<String>>((dynamic hod) {
                return DropdownMenuItem<String>(
                  value: hod['_id'],
                  child: Text(hod['name']),
                );
              }).toList(),
              hint: Text('Select HOD'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedHod.isNotEmpty) {
                  print('Selected HOD ID: $_selectedHod');
                  // Perform further actions here
                } else {
                  print('Please select a HOD');
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
