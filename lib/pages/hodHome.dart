import 'package:feems/pages/facultyHomePage.dart';
import 'package:feems/pages/hodViewStudent.dart';
import 'package:feems/pages/viewStudentExit.dart';
import 'package:flutter/material.dart';

class HodNavigationBarApp extends StatelessWidget {
  const HodNavigationBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({Key? key}) : super(key: key);

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },

        indicatorColor: Colors.black,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home,color: Colors.white,),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),

          NavigationDestination(
            selectedIcon: Icon(Icons.view_list_outlined,color: Colors.white,),
            icon: Icon(Icons.view_list_sharp,),
            label: 'Student Log',
          ),


        ],
      ),
      body: <Widget>[
     FacultyHomeScreen(),
        HodViewStudentExit()


      ][currentPageIndex],
    );
  }
}
