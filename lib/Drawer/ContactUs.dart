import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../DashBoard.dart';

class contactus extends StatefulWidget {
  @override
  _contactusState createState() => _contactusState();
}

class _contactusState extends State<contactus> {
  bool size = false;

  final String number = "9687290890";
  final String email = "jigarparmar848@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: (size) ? Size.fromHeight(45.0) : Size.fromHeight(45.0),
        child: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: (size) ? 35 : 35,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              }),
          centerTitle: true,
          title: Text(
            'Contact Us',
            style: TextStyle(
                fontSize: (size) ? 22 : 22, fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.home,
                  size: (size) ? 32 : 32,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => DashBoard()));
                })
          ],
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              RaisedButton.icon(
                onPressed: () => launch("tel:$number"),
                icon: Icon(Icons.call),
                label: Text(
                  "$number",
                ),
              ),
              SizedBox(height: 10),
              RaisedButton.icon(
                onPressed: () => launch("sms:$number"),
                icon: Icon(Icons.sms),
                label: Text(
                  "$number",
                ),
              ),
              SizedBox(height: 10),
              RaisedButton.icon(
                onPressed: () => launch("mailto:$email"),
                icon: Icon(Icons.mail),
                label: Text(
                  "$email",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
