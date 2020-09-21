import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:ozone_diamonds/LoginPage.dart';
import 'package:ozone_diamonds/dna_page.dart';
import 'package:ozone_diamonds/ozone_diaicon_icons.dart';
import 'package:ozone_diamonds/search_with_tabs.dart';

import 'DashBoard.dart';

class PairSearchlist extends StatefulWidget {
  PairSearchlist({Key key, this.fil}) : super(key: key);
  final fil;
  @override
  _PairsearchlistState createState() => _PairsearchlistState();
}

class _PairsearchlistState extends State<PairSearchlist> {
  bool size = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> selectedList = List();
  List<Stock> selectedListJson = List();
  String carat = "0", discount = "0", amtCts = "0", total = "0";

  Map<String, IconData> shapeMap = {
    'ROUND': OzoneDiaicon.round,
    'PRINCESS': OzoneDiaicon.princess,
    'CUSHION': OzoneDiaicon.cushion,
    'OVAL': OzoneDiaicon.oval,
    'EMERALD': OzoneDiaicon.emerald,
    'PEAR': OzoneDiaicon.pear,
    'ASSCHER': OzoneDiaicon.asscher,
    'HEART': OzoneDiaicon.heart,
    'RADIANT': OzoneDiaicon.radiant,
    'MARQUISE': OzoneDiaicon.marquise
  };

  @override
  Widget build(BuildContext context) {
    String query = "${widget.fil}";
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[100],
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
                      // log(saveMap.toString());
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
                    height: 50,
                    child: Center(
                        child: Column(
                      children: <Widget>[
                        Icon(Icons.shopping_cart, color: Color(0XFF294EA3)),
                        Text(
                          'Add to Cart',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    )),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var naration, instructedBy;
                    final dialogKey = GlobalKey<ScaffoldState>();
                    if (token != null &&
                        token != '' &&
                        partyCode != null &&
                        partyCode != '') {
                      showDialog(
                          context: context,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Center(
                              child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  child: Scaffold(
                                      resizeToAvoidBottomPadding: false,
                                      key: dialogKey,
                                      body: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Text('Confirm Stone',
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ),
                                              TextFormField(
                                                onChanged: (val) =>
                                                    naration = val,
                                                decoration: InputDecoration(
                                                    hintText: 'Naration'),
                                              ),
                                              TextFormField(
                                                onChanged: (val) =>
                                                    instructedBy = val,
                                                decoration: InputDecoration(
                                                    hintText: 'Instruction By'),
                                              ),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20)),
                                              RaisedButton(
                                                onPressed: () async {
                                                  dialogKey.currentState
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'Confirming stone please wait...')));
                                                  var saveMap = Map();
                                                  saveMap['Token'] = token;
                                                  saveMap['PartyCode'] =
                                                      partyCode;
                                                  saveMap['ReportNoList'] =
                                                      selectedList.join(',');
                                                  saveMap['Narration'] =
                                                      naration;
                                                  saveMap['Instructionby'] =
                                                      instructedBy;
                                                  Map<String, String> aheaders =
                                                      {
                                                    'Content-Type':
                                                        'application/json; charset=utf-8',
                                                  };
                                                  http.Response response =
                                                      await http.post(
                                                          'http://ozonediam.com/MobAppService.svc/ConfirmStone',
                                                          headers: aheaders,
                                                          body: json
                                                              .encode(saveMap));
                                                  var responseJson = json
                                                      .decode(response.body);
                                                  print(
                                                      responseJson.toString());
                                                  if (responseJson[
                                                          'SaveSearchResult']
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains('success')) {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                    scaffoldKey.currentState
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                'Stone Confirmed Successfully')));
                                                  } else {
                                                    dialogKey.currentState
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                'Failed to confirm stone')));
                                                  }
                                                },
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            100,
                                                    child: Text(
                                                      'Confirm',
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))),
                            ),
                          ));
                    } else {
                      scaffoldKey.currentState.showSnackBar(SnackBar(
                          content:
                              Text('You are not allowed to Confirm stone')));
                    }
                  },
                  child: Container(
                    height: 50,
                    child: Center(
                        child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.attach_money,
                          color: Color(0XFF294EA3),
                        ),
                        Text(
                          'Confirm Stone',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0XFF294EA3),
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              new FutureBuilder<List<Stock>>(
                future: fetchPosts(query),
                builder: (context, snapshot) {
                  // log('inside builder' + json.encode(snapshot.data));
                  if (snapshot.hasData) {
                    int numOfResult = snapshot.data.length;
                    List<Stock> posts = snapshot.data;
                    TextStyle boldStyle =
                        TextStyle(fontWeight: FontWeight.bold);
                    return Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, bottom: 8, top: 8),
                            child: Row(
                              children: <Widget>[
                                Column(children: <Widget>[
                                  Text("PCS", style: boldStyle),
                                  SizedBox(height: 10.0),
                                  Text(
                                    selectedList.length.toString(),
                                  )
                                ]),
                                Expanded(
                                  child: Column(children: <Widget>[
                                    Text("CTS", style: boldStyle),
                                    SizedBox(height: 10.0),
                                    Text(carat)
                                  ]),
                                ),
                                Expanded(
                                  child: Column(children: <Widget>[
                                    Text("DISC%", style: boldStyle),
                                    SizedBox(height: 10.0),
                                    Text(discount)
                                  ]),
                                ),
                                Expanded(
                                  child: Column(children: <Widget>[
                                    Text("\$/CTS", style: boldStyle),
                                    SizedBox(height: 10.0),
                                    Text(amtCts)
                                  ]),
                                ),
                                Expanded(
                                  child: Column(children: <Widget>[
                                    Text("AMT \$", style: boldStyle),
                                    SizedBox(height: 10.0),
                                    Text(total)
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
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
                                              ? Color(0XFFEBEFFA)
                                              : Colors.white,
                                          child: InkWell(
                                            onTap: () {
                                              log('Inside on tap');
                                              setState(() {
                                                if (selectedList.indexOf(
                                                        post.stone_id) !=
                                                    -1) {
                                                  log('inside if');
                                                  selectedListJson.remove(post);
                                                  selectedList
                                                      .remove(post.stone_id);
                                                } else {
                                                  log('inside else');
                                                  selectedListJson.add(post);
                                                  selectedList
                                                      .add(post.stone_id);
                                                }
                                                print(selectedList.length);
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

                                                if (selectedList.length > 0) {
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
                                                  log(discTotal.toString());
                                                } else {
                                                  discTotal = 0.00;
                                                  caratTotal = 0.00;
                                                  amountTotal = 0.00;
                                                  discount = '0';
                                                  carat = '0';
                                                  amtCts = '0';
                                                  total = '0';
                                                  log(discTotal.toString());
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
                                                            shapeMap[
                                                                post.shape],
                                                            size: 40.0,
                                                            color: Color(
                                                                0XFF294ea3),
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
                                                                    color: Color(
                                                                        0XFF294ea3),
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
                                                  new Divider(
                                                    color: Colors.grey[100],
                                                    thickness: 1.0,
                                                  ),
                                                  Container(
                                                    // height: 30,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    child: RaisedButton(
                                                      color: Color(0XFF294ea3),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      onPressed: () => Navigator
                                                              .of(context)
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
                                                            Text('View Details',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
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
                    //           Text('0 Stone(s) found for your search criteria'),
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
                              Text('0 Stone(s) found for your search criteria'),
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
                        Padding(padding: new EdgeInsets.all(50.0)),
                        CircularProgressIndicator(),
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
    final msg = jsonEncode({
      "Token": token,
      "StockType": "PAIR",
      "SortBy": "",
      "Start": "1",
      "End": "",
      "WhereCondition": query
    });
    http.Response response = await http.post(
        'http://ozonediam.com/MobAppService.svc/GetStockapp',
        headers: aheaders,
        body: msg);
    var responseJson = json.decode(response.body);
    print('inside result ');
    log(response.body);
    return (responseJson['GetStockappResult']['Result'] as List)
        .map((p) => Stock.fromJson(p))
        .toList();
  }
}

class Stock {
  final String clarity,
      colour,
      cut,
      symm,
      flu,
      certy,
      polish,
      shade,
      carat,
      ha,
      discount,
      cb,
      cw,
      color_description,
      comments,
      crown_angle,
      crown_height,
      depth,
      depth_per,
      eyeclean,
      ktos,
      lab,
      lenght,
      location,
      milky,
      pavilion_angle,
      pavilion_height,
      price_per_carat,
      rap_price,
      ratio,
      report_date,
      report_no,
      sb,
      sw,
      shape,
      stage,
      stone_id,
      table_per,
      total_amt,
      video,
      weight,
      pdfLink,
      videoLink,
      imageLink,
      width;

  Stock({
    this.clarity,
    this.colour,
    this.cut,
    this.polish,
    this.symm,
    this.flu,
    this.certy,
    this.shade,
    this.carat,
    this.ha,
    this.discount,
    this.cb,
    this.cw,
    this.color_description,
    this.comments,
    this.crown_angle,
    this.crown_height,
    this.depth,
    this.depth_per,
    this.eyeclean,
    this.ktos,
    this.lab,
    this.lenght,
    this.location,
    this.milky,
    this.pavilion_angle,
    this.pavilion_height,
    this.price_per_carat,
    this.rap_price,
    this.ratio,
    this.report_date,
    this.report_no,
    this.sw,
    this.sb,
    this.shape,
    this.stage,
    this.stone_id,
    this.table_per,
    this.total_amt,
    this.video,
    this.pdfLink,
    this.imageLink,
    this.videoLink,
    this.weight,
    this.width,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return new Stock(
        clarity: json['Clarity'].toString(),
        colour: json['Colour'].toString(),
        cut: json['Cut'].toString(),
        polish: json['Polish'].toString(),
        symm: json['Symmetry'].toString(),
        flu: json['Fluorescence'].toString(),
        certy: json['Lab'].toString(),
        shade: json['Shade'].toString(),
        carat: json['Weight'].toString(),
        ha: json['HA'].toString(),
        discount: json['Discount'].toString(),
        cb: json['CB'].toString(),
        cw: json['CW'].toString(),
        color_description: json['ColorDescription'].toString(),
        crown_angle: json['CrownAngle'].toString(),
        crown_height: json['CrownHeight'].toString(),
        depth: json['Depth'].toString(),
        eyeclean: json['EyeClean'].toString(),
        ktos: json['KeyToSymbols'].toString(),
        lab: json['Lab'].toString(),
        lenght: json['Lenght'].toString(),
        location: json['Location'].toString(),
        milky: json['Milky'].toString(),
        pavilion_angle: json['PavilionAngle'].toString(),
        pavilion_height: json['PavilionHeight'].toString(),
        price_per_carat: json['PricePerCarat'].toString(),
        rap_price: json['RapPrice'].toString(),
        ratio: json['Ratio'].toString(),
        report_date: json['ReportDate'].toString(),
        report_no: json['ReportNo'].toString(),
        sw: json['SW'].toString(),
        sb: json['SB'].toString(),
        shape: json['Shape'].toString(),
        stage: json['Stage'].toString(),
        stone_id: json['StoneId'].toString(),
        table_per: json['TablePer'].toString(),
        total_amt: json['TotalAmount'].toString(),
        video: json['Video'].toString(),
        pdfLink: json['Cert'].toString(),
        videoLink: json['Mp4Video'].toString(),
        imageLink: json['Image'].toString(),
        comments: json['Comments'].toString(),
        weight: json['Weight'].toString(),
        width: json['Width'].toString());
  }
}
