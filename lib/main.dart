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
      home: LoginPage(),
      color: Colors.white,
      debugShowCheckedModeBanner: false,
    );
  }
}
