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
        appBar: AppBar(
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.pin_drop,
                        size: 35,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Text(
                        '202, 2nd Floor, Sumukh Building,\nSuper Compound, \nVastadevdi Road, Katargam,\nSurat -395004.(Gujarat) India.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  launch("tel:+919722273818");
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.call,
                          size: 35,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        child: Text(
                          '(M) +91 9722273818',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => launch("tel:+91 02612533533"),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.contact_phone,
                          size: 35,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        child: Text(
                          ' Tel: +91 0261 2533533',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => launch("mailto:sales@ozonediam.com"),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.mail,
                          size: 35,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        child: Text(
                          ' Email: sales@ozonediam.com',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
