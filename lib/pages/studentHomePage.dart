import 'package:feems/pages/myProfile.dart';
import 'package:feems/pages/qrcodePage.dart';
import 'package:feems/pages/studentLogin.dart';
import 'package:feems/pages/studentRequest.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class studentHomePage extends StatefulWidget {

  const studentHomePage({Key? key}) : super(key: key);

  @override
  State<studentHomePage> createState() => _studentHomePageState();
}


class _studentHomePageState extends State<studentHomePage> {
  late String studentId;

  void initState() {
    super.initState();
    _fetchHODs();
  }

  Future<void> _fetchHODs() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
     studentId = preferences.getString("userid") ?? "";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [
          IconButton(
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));},
            icon: Icon(Icons.logout, color: Colors.black),
          ),
        ],
        shape: const Border(
          bottom: BorderSide(
            color: Colors.black26,
            width: 1.0, // Border width
          ),
        ),
      ),
      body: SingleChildScrollView( // Wrap your Column with SingleChildScrollView
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/img_2.png',
                    width: 250,
                    height: 250,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HomeCard(
                        onPress: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentRequest()));
                        },
                        icon: Icons.send,
                        title: 'Request ',
                        subtitle: 'Send exit request',
                      ),
                      HomeCard(
                        onPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile(studentId: studentId)));
                        },
                        icon: Icons.person,
                        title: 'My Profile',
                        subtitle: 'Your profile',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HomeCard(
                        onPress: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackPage()));
                        },
                        icon: Icons.notifications,
                        title: 'Notification',
                        subtitle: 'See your notification',
                      ),
                      HomeCard(
                        onPress: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCodeImageScreen()));
                        },
                        icon: Icons.qr_code_2,
                        title: 'QRcode',
                        subtitle: 'See your qrcode',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.onPress,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final VoidCallback onPress;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 5.3,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color:  Colors.black, size: 25),
            Text(title, style: TextStyle(fontSize: 20, color: Colors.black), textAlign: TextAlign.center),
            Text(subtitle, style: TextStyle(fontSize: 15, color: Colors.black), textAlign: TextAlign.center),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

