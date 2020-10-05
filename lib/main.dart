import 'package:flutter/material.dart';

import 'package:ozone_diamonds/LoginPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Color(0XFF294EA3),
        primaryColor: Color(0XFF294ea3),
      ),
      // home: LoginPage(),
      home: LoginPage(),
      color: Colors.white,
      debugShowCheckedModeBanner: false,
    );
  }
}
