
import 'package:feems/pages/scanningPage.dart';
import 'package:feems/pages/studentLogin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(home());
}
class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


