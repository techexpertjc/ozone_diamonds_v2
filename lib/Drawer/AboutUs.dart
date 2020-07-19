import 'package:flutter/material.dart';

import '../DashBoard.dart';

class AboutUS extends StatefulWidget {
  @override
  _AboutUSState createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
  bool size = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              'About Us',
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
                  child: new Container(
                    child: Center(
                      child: new Text(
                        '''        We are the diamond manufacturers and have been in business since 2001 and can proudly say that we have always been focused on our customer. Over the years we have become well-known in the industry as the preferred diamond manufacturer and diamond trader.
    ''',
                        style: TextStyle(fontSize: 13.0, color: Colors.black),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
                  child: new Container(
                    child: Center(
                      child: new Text(
                        '''We only do business by the philosophy that
    ''',
                        style: TextStyle(fontSize: 13.0, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: new Container(
                    child: Center(
                      child: Text(
                        '''“When you do business with us, you do business with family."
    ''',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: new Container(
                    child: Center(
                      child: Text(
                        '''Our Mission
    ''',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: new Container(
                    child: Center(
                      child: new Text(
                        '''        We have enjoyed years of relationships with our customers and are extremely proud that we have been able to be a part of so many special occasions as well as seeing the happiness and joy when our clients have collected their diamond from us.

        We have always kept to and stayed firm on our policy to keep our diamond pricing the best in the industry and therefore we know that through us you will get your diamonds at the best pricing.Your diamond is waiting.

        We look forward to being part of your Journey! “When you come to us, we treat you just like family. We give you the best diamonds at the best prices, and it's "our mission to be your trusted friend - for life.”

        We also have a dedicated team of global buyers, actively procuring stocks from the worldwide markets. So we are always ready to deliver against the precise needs of every customer, anywhere in the world
    ''',
                        style: TextStyle(fontSize: 13.0, color: Colors.black87),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
