import 'package:flutter/material.dart';
import 'package:ozone_diamonds/DashBoard.dart';

import 'package:ozone_diamonds/LoginPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  var routes = <String, WidgetBuilder>{
    "/home": (BuildContext context) => DashBoard(),
    // "/searchPage": (BuildContext context) => StoneSearch(),
    // "/searchResults": (BuildContext context) => SearchResults(),
    // "/aboutUs": (BuildContext context) => AboutUs(),
    // "/gallery": (BuildContext context) => MyGallery(),
    // "/contact": (BuildContext context) => ContactUs()
  };

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
      routes: routes,
    );
  }
}
