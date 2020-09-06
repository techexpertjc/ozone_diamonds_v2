import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';

import 'package:ozone_diamonds/StoneSearch.dart';
import 'package:ozone_diamonds/DashBoard.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';

class MySearchPage extends StatefulWidget {
  @override
  MySearchPageState createState() => MySearchPageState();
}

class MySearchPageState extends State<MySearchPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  SharedPreferences pref;
  Map currSavedObj;
  int _tabIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((value) {
      pref = value;
      if (pref.getStringList('savedSearch') != null)
        savedSearch = pref.getStringList('savedSearch');
      setState(() {});
    });
    loadSavedSearchList();
    myTabController = TabController(length: 2, vsync: this);
    myTabController.addListener(() {
      Timer(Duration(milliseconds: 500), () {
        setState(() {});
      });
    });
    super.initState();
  }

  static final scaffoldKey = GlobalKey<ScaffoldState>();
  static Future<void> loadSavedSearchList() async {
    Map<String, String> aheaders = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    Map saveMap = Map();
    saveMap['Token'] = token;
    http.Response response = await http.post(
        'http://ozonediam.com/MObAppService.SVC/GetSaveSearchList',
        headers: aheaders,
        body: json.encode(saveMap));
    var responseJson = json.decode(response.body);
    List serviceResultList = responseJson['GetSaveSearchListResult']['Result'];
    List<String> tempList = List(), tempSeqList = List();

    serviceResultList.forEach((element) {
      tempList.add(element['CRITERIA'].toString());
      tempSeqList.add(element['SEQ_NO'].toString());
    });
    savedSearch = tempList;
    savedSearchSeqNo = tempSeqList;
    log('saveList :' + responseJson.toString());
    scaffoldKey.currentState.setState(() {});
  }

  Future<void> loadSavedSearchListCopy() async {
    Map<String, String> aheaders = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    Map saveMap = Map();
    saveMap['Token'] = token;
    http.Response response = await http.post(
        'http://ozonediam.com/MObAppService.SVC/GetSaveSearchList',
        headers: aheaders,
        body: json.encode(saveMap));
    print(response.body);
    var responseJson = json.decode(response.body);
    List serviceResultList = responseJson['GetSaveSearchListResult']['Result'];
    List<String> tempList = List(), tempSeqList = List();

    serviceResultList.forEach((element) {
      tempList.add(element['CRITERIA'].toString());
      tempSeqList.add(element['SEQ_NO'].toString());
    });
    savedSearch = tempList;
    savedSearchSeqNo = tempSeqList;
    log('saveList :' + responseJson.toString());
    setState(() {});
  }

  TabController myTabController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          bottom: TabBar(
              controller: myTabController,
              onTap: (i) {
                setState(() {});
              },
              tabs: [
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
              ]),
          backgroundColor: Color(0XFF294EA3),
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: 35,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          centerTitle: true,
          title: Text(
            'Specific Search',
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
        body: TabBarView(controller: myTabController, children: [
          StoneSearch(
            currSavedObj: currSavedObj,
          ),
          Container(
            child: (savedSearch != null && savedSearch.length > 0)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: _getSavedChildren(context),
                    ),
                  )
                : Center(
                    child: Container(
                      child: Text(
                        'No data Saved Yet',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
          ),
        ]),
      ),
    );
  }

  List<Widget> _getSavedChildren(BuildContext cont) {
    List<Widget> tempWidgetList = List();
    Map<dynamic, dynamic> tempMapList =
        Map.fromIterable(json.decode(savedSearch.toString()));
    // print(savedSearch);
    int i = 0;
    tempMapList.forEach((key, value) {
      Map temp = key;
      tempWidgetList.add(Card(
        elevation: 5,
        child: ListTile(
          trailing: FlatButton.icon(
              onPressed: () {
                var tep = json.encode(key);
                printWrapped('before remove ' + tempMapList.toString());
                // var ind = savedSearch.removeAt(savedSearch.indexOf(tep));

                removeSavedSearch(tep);
                setState(() {});
                // pref.setStringList('savedSearch', savedSearch);
              },
              icon: Icon(
                Icons.delete,
                color: Color(0XFF294ea3),
              ),
              label: Text('')),
          onTap: () {
            setState(() {
              currSavedObj = temp[temp.keys.elementAt(0)];
            });

            print(currSavedObj);
            myTabController.animateTo(0);
            isFromSaved = true;
            setState(() {});
          },
          title: Text(
            temp.keys.elementAt(0),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ));
      // tempWidgetList.add(Divider());
      i++;
    });
    return tempWidgetList;
  }

  Future<void> removeSavedSearch(String savedJson) async {
    Map tempJson = json.decode(savedJson);
    var saveMap = Map();
    saveMap['Token'] = token;
    saveMap['SaveName'] = tempJson.keys.elementAt(0);
    saveMap['SearchCriteria'] = savedJson;
    saveMap['TransType'] = 'DELETE';
    saveMap['SeqNo'] = savedSearchSeqNo[savedSearch.indexOf(savedJson)];
    log('inside remove' + json.encode(saveMap));
    Map<String, String> aheaders = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    http.Response response = await http.post(
        'http://ozonediam.com/MObAppService.SVC/SaveSearch',
        headers: aheaders,
        body: json.encode(saveMap));
    var responseJson = json.decode(response.body);

    log('Inside remove ' + saveMap.toString());
    loadSavedSearchListCopy();
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
