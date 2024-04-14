import 'package:feems/pages/addSecurity.dart';
import 'package:feems/pages/adminHomePage.dart';
import 'package:feems/pages/securityDisplayAll.dart';
import 'package:feems/pages/studentLogin.dart';
import 'package:feems/pages/viewHods.dart';
import 'package:feems/pages/viewSecurity.dart';
import 'package:flutter/material.dart';
import 'package:feems/models/hodModel.dart';
import 'package:feems/services/adminServices.dart';

class menu extends StatefulWidget {
  const menu({Key? key}) : super(key: key);

  @override
  State<menu> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<menu> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    adminHomeScreen(),
    Add_Security(),
    ViewHods(),
    ViewSecurity(),
   // DisplayAll(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List<HodModel>>? data;

  @override
  void initState() {
    super.initState();
    data = adminApiService().getHodApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align widgets to the left
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0), // Add left padding
              child: Image.asset('assets/LOGO3.png', width: 143, height: 35),
            ),
          ],
        ),
      ),


      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text('ADMIN',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 45),),
            ),
            ListTile(
              leading: Icon(Icons.home,color: Colors.black26,),
              title: const Text('Home',style:TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline,color: Colors.black26,),
              title: const Text('Add Security',style:TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.people_rounded,color: Colors.black26,),
              title: const Text('View faculty',style:TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box_rounded,color: Colors.black26,),
              title: const Text('View security',style:TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.view_list_outlined,color: Colors.black26,),
            //   title: const Text('Log Details',style:TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
            //   onTap: () {
            //     // Update the state of the app
            //     _onItemTapped(4);
            //     // Then close the drawer
            //     Navigator.pop(context);
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.logout_outlined,color: Colors.black26,),
              title: const Text('Logout',style:TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFF000000),
        child: Center(
          child: _widgetOptions[_selectedIndex],
        ),
      ),
    );
  }
}
