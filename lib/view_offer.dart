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

class OfferList extends StatefulWidget {
  OfferList({Key key, this.fil}) : super(key: key);
  final fil;
  @override
  _offerListState createState() => _offerListState();
}

class _offerListState extends State<OfferList> {
  bool size = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> selectedList = List();
  List<Stock> selectedListJson = List();
  String carat = "-", discount = "-", amtCts = "-", total = "-";
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
                        content:
                            Text('Adding the items to cart please wait...')));

                    await selectedList.forEach((element) async {
                      Map<String, String> aheaders = {
                        'Content-Type': 'application/json; charset=utf-8',
                      };
                      var saveMap = Map();
                      saveMap['Token'] = token;
                      saveMap['PacketNo'] = element;
                      saveMap['TranType'] = 'INSERT';
                      log(saveMap.toString());
                      await http
                          .post(
                              'http://ozonediam.com/MobAppService.svc/ManageCart',
                              headers: aheaders,
                              body: json.encode(saveMap))
                          .then((value) => log(value.body))
                          .catchError((e) {
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                'An Error Occured While Adding Some items to your cart, Please check Your Internet Connection.')));
                      });
                    });
                    scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text('The Items have been added to Cart')));
                  },
                  child: Container(
                    height: 40,
                    child: Center(
                        child: Column(
                      children: <Widget>[
                        Icon(Icons.shopping_cart),
                        Text('Add to Cart')
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
              'Your Offers',
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
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
                                    selectedList.length.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ]),
                                Expanded(
                                  child: Column(children: <Widget>[
                                    Text("CTS"),
                                    SizedBox(height: 3.0),
                                    Text(carat)
                                  ]),
                                ),
                                Expanded(
                                  child: Column(children: <Widget>[
                                    Text("DISC%"),
                                    SizedBox(height: 3.0),
                                    Text(discount)
                                  ]),
                                ),
                                Expanded(
                                  child: Column(children: <Widget>[
                                    Text("\$/CTS"),
                                    SizedBox(height: 3.0),
                                    Text(amtCts)
                                  ]),
                                ),
                                Expanded(
                                  child: Column(children: <Widget>[
                                    Text("AMT \$"),
                                    SizedBox(height: 3.0),
                                    Text(total)
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
                                                if (selectedList.indexOf(
                                                        post.stone_id) !=
                                                    -1) {
                                                  selectedListJson.add(post);
                                                  selectedList
                                                      .remove(post.stone_id);
                                                } else {
                                                  selectedListJson.add(post);
                                                  selectedList
                                                      .add(post.stone_id);
                                                }
                                                var discTotal = 0.00,
                                                    caratTotal = 0.00,
                                                    amountTotal = 0.00;
                                                selectedListJson
                                                    .forEach((element) {
                                                  discTotal = discTotal +
                                                      double.parse(
                                                          element.discount);
                                                  caratTotal = caratTotal +
                                                      double.parse(
                                                          element.carat);
                                                  amountTotal = amountTotal +
                                                      double.parse(
                                                          element.total_amt);
                                                });
                                                discount = (discTotal /
                                                        selectedList.length)
                                                    .toStringAsFixed(2);
                                                carat = caratTotal
                                                    .toStringAsFixed(2);
                                                amtCts =
                                                    (amountTotal / caratTotal)
                                                        .toStringAsFixed(2);
                                                total = amountTotal
                                                    .toStringAsFixed(0);
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
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                                                  fontSize:
                                                                      (size)
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
                                                                  fontSize:
                                                                      (size)
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
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize:
                                                                      (size)
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
                                                                          .grey[
                                                                      700],
                                                                  fontSize:
                                                                      (size)
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
                                                                          .grey[
                                                                      700],
                                                                  fontSize:
                                                                      (size)
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
                                                  Container(
                                                    child: InkWell(
                                                      onTap: () => Navigator.of(
                                                              context)
                                                          .push(
                                                              MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      MyDNAPage(
                                                                        dnaData:
                                                                            post,
                                                                      ))),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                'View details '),
                                                            IconButton(
                                                                icon: Icon(Icons
                                                                    .chevron_right),
                                                                onPressed:
                                                                    null),
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
                    // showDialog(
                    //     context: context,
                    //     child: AlertDialog(
                    //       title: Text('Ozone Diamonds'),
                    //       content:
                    //           Text('0 Stone(s) found for your Search Criteria'),
                    //       actions: <Widget>[
                    //         FlatButton(
                    //             onPressed: () {
                    //               Navigator.pop(context);
                    //               Navigator.pop(context);
                    //             },
                    //             child: Text('Ok'))
                    //       ],
                    //     ),
                    //     barrierDismissible: false);
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
      ),
    );
  }

  Future<List<Stock>> fetchPosts(String query) async {
    Map<String, String> aheaders = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    final msg = jsonEncode({"Token": token, "PartyCode": partyCode});
    http.Response response = await http.post(
        'http://ozonediam.com/MobAppService.svc/GetViewOffer',
        headers: aheaders,
        body: msg);
    var responseJson = json.decode(response.body);
    print('inside result ' + msg);
    return (responseJson['GetViewOfferResult']['Result'] as List)
        .map((p) => Stock.fromJson(p))
        .toList();
  }
}
