import 'package:flutter/material.dart';
import 'package:ozone_diamonds/StoneSearch.dart';
import 'package:ozone_diamonds/DashBoard.dart';

class MySearchPage extends StatefulWidget {
  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Container(
              height: 50,
              child: Center(
                child: Text('SEARCH'),
              ),
            ),
            Container(
              height: 50,
              child: Center(
                child: Text('SAVED'),
              ),
            ),
            Container(
              height: 50,
              child: Center(
                child: Text('DEMAND'),
              ),
            )
          ]),
          backgroundColor: Colors.indigo[800],
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => DashBoard()));
              }),
          centerTitle: true,
          title: Text(
            'Stone Search',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.home,
                  size: 32,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => DashBoard()));
                })
          ],
        ),
        body: TabBarView(children: [StoneSearch(), Container(), Container()]),
      ),
    ));
  }
}
