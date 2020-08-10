import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:ozone_diamonds/LoginPage.dart';
import 'package:ozone_diamonds/dna_page.dart';
import 'package:ozone_diamonds/ozone_diaicon_icons.dart';
import 'package:ozone_diamonds/search_with_tabs.dart';
import 'package:ozone_diamonds/search.dart';

import 'DashBoard.dart';

class MyCartList extends StatefulWidget {
  MyCartList({Key key, this.fil}) : super(key: key);
  final fil;
  @override
  _myCartlistState createState() => _myCartlistState();
}

class _myCartlistState extends State<MyCartList> {
  bool size = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> selectedList = List();
  @override
  Widget build(BuildContext context) {
    String query = "${widget.fil}";
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text(
                            'Deleting the item(s) from cart please wait...')));

                    await selectedList.forEach((element) async {
                      Map<String, String> aheaders = {
                        'Content-Type': 'application/json; charset=utf-8',
                      };
                      var saveMap = Map();
                      saveMap['Token'] = token;
                      saveMap['PacketNo'] = element;
                      saveMap['TransType'] = 'DELETE';
                      await http
                          .post(
                              'http://ozonediam.com/MobAppService.svc/ManageCart',
                              headers: aheaders,
                              body: json.encode(saveMap))
                          .catchError((e) {
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                'An Error Occured While Adding Some items to your cart, Please check Your Internet Connection.')));
                      });
                    });
                    scaffoldKey.currentState.showSnackBar(SnackBar(
                        content:
                            Text('The Item(s) have been Detelet From Cart')));
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    child: Center(
                        child: Column(
                      children: <Widget>[
                        Icon(Icons.delete),
                        Text('Delete From Cart')
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: (size) ? Size.fromHeight(45.0) : Size.fromHeight(45.0),
          child: AppBar(
            backgroundColor: Colors.indigo[800],
            leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  size: (size) ? 35 : 35,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            centerTitle: true,
            title: Text(
              'Stone Result',
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
                    Navigator.pop(context, true);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => DashBoard()));
                  })
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            new FutureBuilder<List<Stock>>(
              future: fetchPosts(query),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int numOfResult = snapshot.data.length;
                  List<Stock> posts = snapshot.data;
                  return Column(
                    children: <Widget>[
                      Card(
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: <Widget>[
                              Column(children: <Widget>[
                                Text("PCS"),
                                SizedBox(height: 3.0),
                                Text(
                                  numOfResult.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ]),
                              Expanded(
                                child: Column(children: <Widget>[
                                  Text("CTS"),
                                  SizedBox(height: 3.0),
                                  Text(" -")
                                ]),
                              ),
                              Expanded(
                                child: Column(children: <Widget>[
                                  Text("DISC%"),
                                  SizedBox(height: 3.0),
                                  Text("-")
                                ]),
                              ),
                              Expanded(
                                child: Column(children: <Widget>[
                                  Text("\$/CTS"),
                                  SizedBox(height: 3.0),
                                  Text("-")
                                ]),
                              ),
                              Expanded(
                                child: Column(children: <Widget>[
                                  Text("AMT \$"),
                                  SizedBox(height: 3.0),
                                  Text("-")
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Column(children: <Widget>[Text(numOfResult.toString())],),
                      new Column(
                          children: posts
                              .map((post) => new Column(
                                    children: <Widget>[
                                      Card(
                                        elevation: selectedList
                                                    .indexOf(post.stone_id) !=
                                                -1
                                            ? 5
                                            : 1,
                                        color: selectedList
                                                    .indexOf(post.stone_id) !=
                                                -1
                                            ? Colors.grey[300]
                                            : Colors.grey[200],
                                        child: InkWell(
                                          onTap: () {
                                            log('Inside on tap');
                                            setState(() {
                                              if (selectedList
                                                      .indexOf(post.stone_id) !=
                                                  -1) {
                                                selectedList
                                                    .remove(post.stone_id);
                                              } else {
                                                selectedList.add(post.stone_id);
                                              }
                                            });
                                            // print(selectedList.toString());
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (BuildContext
                                            //                 context) =>
                                            //             MyDNAPage(
                                            //               dnaData: post,
                                            //             )));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Column(
                                                      children: <Widget>[
                                                        Text(
                                                          post.stone_id,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: (size)
                                                                  ? 14
                                                                  : 14),
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(
                                                            post.carat,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                        .indigo[
                                                                    900],
                                                                fontSize: (size)
                                                                    ? 14
                                                                    : 14),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(post.colour,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      (size)
                                                                          ? 14
                                                                          : 14)),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(post.clarity,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      (size)
                                                                          ? 14
                                                                          : 14)),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(post.certy,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      (size)
                                                                          ? 14
                                                                          : 14)),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(post.location,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      (size)
                                                                          ? 14
                                                                          : 14)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Column(
                                                      children: <Widget>[
                                                        Icon(
                                                          OzoneDiaicon.round,
                                                          size: 40.0,
                                                          color: Colors.blue,
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(post.cut,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      (size)
                                                                          ? 14
                                                                          : 14)),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(post.symm,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      (size)
                                                                          ? 14
                                                                          : 14)),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(post.polish,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      (size)
                                                                          ? 14
                                                                          : 14)),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(post.flu,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      (size)
                                                                          ? 14
                                                                          : 14)),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(post.stage,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      (size)
                                                                          ? 14
                                                                          : 14,
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                //         new Divider(
                                                //   color: Colors.red,
                                                // ),
                                                Row(
                                                  children: <Widget>[
                                                    Column(
                                                      children: <Widget>[
                                                        Text(post.shape,
                                                            style: TextStyle(
                                                                fontSize: (size)
                                                                    ? 13
                                                                    : 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(
                                                            "DIS(%):${post.discount}",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: (size)
                                                                    ? 12
                                                                    : 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(
                                                              "\$/CTS: ${post.price_per_carat}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontSize:
                                                                      (size)
                                                                          ? 12
                                                                          : 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(
                                                              "\$ ${post.total_amt}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize:
                                                                      (size)
                                                                          ? 12
                                                                          : 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                new Divider(
                                                  color: Colors.grey[100],
                                                  thickness: 1.0,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(
                                                            "TABLE(%):${post.table_per}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[700],
                                                                fontSize: (size)
                                                                    ? 12
                                                                    : 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(
                                                              "DEPTH(%)${post.depth}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontSize:
                                                                      (size)
                                                                          ? 12
                                                                          : 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                new Divider(
                                                  color: Colors.grey[100],
                                                  thickness: 1.0,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(
                                                              'MEAS:${post.lenght} x ${post.width} x ${post.depth}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontSize:
                                                                      (size)
                                                                          ? 12
                                                                          : 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(
                                                            "RATIO(%):${post.ratio}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[700],
                                                                fontSize: (size)
                                                                    ? 12
                                                                    : 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(
                                                              'MEAS:${post.lenght} x ${post.width} x ${post.depth}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontSize:
                                                                      (size)
                                                                          ? 12
                                                                          : 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(
                                                            "RATIO(%):${post.ratio}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[700],
                                                                fontSize: (size)
                                                                    ? 12
                                                                    : 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                new Divider(
                                                  color: Colors.grey[100],
                                                  thickness: 1.0,
                                                ),
                                                Container(
                                                  child: InkWell(
                                                    onTap: () => Navigator.of(
                                                            context)
                                                        .push(MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                MyDNAPage(
                                                                  dnaData: post,
                                                                ))),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text('View details '),
                                                          IconButton(
                                                              icon: Icon(Icons
                                                                  .chevron_right),
                                                              onPressed: null),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      //Text(post.certy)
                                    ],
                                  ))
                              .toList()),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 4),
                    child: Center(
                      child: AlertDialog(
                        title: Text('Ozone Diamonds'),
                        content:
                            Text('0 Stone(s) found for your Search Criteria'),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                // Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text('Ok'))
                        ],
                      ),
                    ),
                  );
                  // return Center(child: Text('No Data'));
                }
                return new Center(
                  child: new Column(
                    children: <Widget>[
                      new Padding(padding: new EdgeInsets.all(50.0)),
                      new CircularProgressIndicator(),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Stock>> fetchPosts(String query) async {
    Map<String, String> aheaders = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    final msg = jsonEncode({
      "Token": token,
      "StockType": "CART",
      "WhereCondition": "",
      "SortBy": "",
      "Start": "1",
      "End": "10"
    });
    http.Response response = await http.post(
        'http://ozonediam.com/MobAppService.svc/GetStockapp',
        headers: aheaders,
        body: msg);
    var responseJson = json.decode(response.body);
    log(msg);
    return (responseJson['GetStockappResult']['Result'] as List)
        .map((p) => Stock.fromJson(p))
        .toList();
  }
}
