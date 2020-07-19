import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

import 'LoginPage.dart';
class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Gradient gradient = LinearGradient(
      colors: [Colors.blue, Colors.lightBlueAccent, Colors.blue]);
  bool small = false;
  @override
  void initState() {
      super.initState();
      new Future.delayed(
        const Duration(seconds: 3),
          () =>
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              //MaterialPageRoute(builder: (context) => StoneSearch()),
            )
      );
  }
      // addStringToSF(String e) async {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('email',e);
      // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 140.0,),
              child: SizedBox(
                // height: MediaQuery.of(context).size.height*0.4,
                // width: MediaQuery.of(context).size.width*0.3,
                child: Image.asset('asets/Ozonlogo.png',fit: BoxFit.contain,height:(small)? 180:200,)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:170.0,),
              child: SizedBox(
                child: Text(
                  'By',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: (small)? 10:12,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey[600]
                  ),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top:10.0),
              child: SizedBox(
                child: GradientText(
                  'OZONE DIAM',
                  textAlign: TextAlign.center,
                  gradient: gradient,
                  style: TextStyle(
                    fontSize: (small) ? 16 : 22,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            )
          ],
        )
      )
    );
  }
}