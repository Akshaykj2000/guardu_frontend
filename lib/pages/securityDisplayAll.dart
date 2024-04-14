import 'package:feems/pages/NonvehicleView.dart';
import 'package:feems/pages/VehicleView.dart';
import 'package:feems/pages/viewStudentExit.dart';
import 'package:flutter/material.dart';

class DisplayAll extends StatefulWidget {
  @override
  _DisplayAllState createState() => _DisplayAllState();
}

class _DisplayAllState extends State<DisplayAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Image.asset('assets/LOGO3.png', width: 143, height: 35),
            ),
          ],
        ),

      ),
      body: DefaultTabController(

        length: 3,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: 'Vehicle',
                ),
                Tab(
                  text: 'Non-vehicle',
                ),
                Tab(
                  text: 'Students',
                ),
              ],
              labelColor: Colors.blueAccent,
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.blueAccent,


            ),
            Expanded(
              child: TabBarView(
                children: [
                 VehicleView(),
                  NonVehicleView(),
                  ViewStudentExit()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


