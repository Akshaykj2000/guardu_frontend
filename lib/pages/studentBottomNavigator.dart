import 'package:feems/pages/qrcodePage.dart';
import 'package:feems/pages/studentHomePage.dart';
import 'package:flutter/material.dart';

class StudentNavigationBarApp extends StatelessWidget {
  const StudentNavigationBarApp({Key? key}) : super(key: key);

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
        backgroundColor: Colors.blue[800],
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue[200],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home,color: Colors.black,),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.message_rounded,color: Colors.black,)),
            label: 'Status',
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code_scanner,color: Colors.black,),
            label: 'QRcode',
          ),
        ],
      ),
      body: <Widget>[
        studentHomePage(),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications,color: Colors.black,),
                  title: Text('status 1'),
                  subtitle: Text('This is a status'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('status 2'),
                  subtitle: Text('This is a status'),
                ),
              ),
            ],
          ),
        ),


        QRCodeImageScreen(),
      ][currentPageIndex],
    );
  }
}
