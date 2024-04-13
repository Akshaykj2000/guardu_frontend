import 'package:feems/pages/qrscanner.dart';
import 'package:feems/pages/securityHomePage.dart';
import 'package:flutter/material.dart';

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({Key? key}) : super(key: key);

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
        backgroundColor: Colors.blue[900],
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.white,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home,color: Colors.black,),
            icon: Icon(Icons.home_outlined),
            label: 'Home',

          ),

          NavigationDestination(
            icon: Badge(child: Icon(Icons.smart_display,color: Colors.black,)),
            label: 'Log',
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code_scanner,color: Colors.black,),
            label: 'Scanner',
          ),
        ],
      ),
      body: <Widget>[
        SecurityHomeScreen(),

        /// Notifications page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications,color: Colors.black,),
                  title: Text('Display 1'),
                  subtitle: Text('This is a Display'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Display 2'),
                  subtitle: Text('This is a Display'),
                ),
              ),
            ],
          ),
        ),

        QRScannerPage(),
      ][currentPageIndex],
    );
  }
}
