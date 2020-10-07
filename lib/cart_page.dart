import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:ozone_diamonds/LoginPage.dart';
import 'package:ozone_diamonds/dna_page.dart';
import 'package:ozone_diamonds/media_fullscreen.dart';
import 'package:ozone_diamonds/ozone_diaicon_icons.dart';

import 'package:ozone_diamonds/search.dart';

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
            'My Cart',
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
                  Navigator.popUntil(context, ModalRoute.withName('/home'));
                })
          ],
        ),
        body: ListView(
          children: <Widget>[
            new FutureBuilder<List<Stock>>(
              future: fetchPosts(query),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  TextStyle boldStyle = TextStyle(fontWeight: FontWeight.bold);

                  List<Stock> posts = snapshot.data;
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
                                            // setState(() {
                                            //   if (selectedList.indexOf(
                                            //           post.stone_id) !=
                                            //       -1) {
                                            //     log('inside if');
                                            //     selectedListJson.remove(post);
                                            //     selectedList
                                            //         .remove(post.stone_id);
                                            //   } else {
                                            //     log('inside else');
                                            //     selectedListJson.add(post);
                                            //     selectedList
                                            //         .add(post.stone_id);
                                            //   }
                                            //   print(selectedList.length);
                                            //   var discTotal = 0.00,
                                            //       caratTotal = 0.00,
                                            //       amountTotal = 0.00;
                                            //   selectedListJson
                                            //       .forEach((element) {
                                            //     discTotal = discTotal +
                                            //         double.parse(
                                            //             element.discount);
                                            //     caratTotal = caratTotal +
                                            //         double.parse(
                                            //             element.carat);
                                            //     amountTotal = amountTotal +
                                            //         double.parse(
                                            //             element.total_amt);
                                            //   });

                                            //   if (selectedList.length > 0) {
                                            //     discount = (discTotal /
                                            //             selectedList.length)
                                            //         .toStringAsFixed(2);
                                            //     carat = caratTotal
                                            //         .toStringAsFixed(2);
                                            //     amtCts =
                                            //         (amountTotal / caratTotal)
                                            //             .toStringAsFixed(2);
                                            //     total = amountTotal
                                            //         .toStringAsFixed(0);
                                            //     log(discTotal.toString());
                                            //   } else {
                                            //     discTotal = 0.00;
                                            //     caratTotal = 0.00;
                                            //     amountTotal = 0.00;
                                            //     discount = '0';
                                            //     carat = '0';
                                            //     amtCts = '0';
                                            //     total = '0';
                                            //     log(discTotal.toString());
                                            //   }
                                            // });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    Container(
                                                      child: Checkbox(
                                                        activeColor:
                                                            Color(0XFF294ea3),
                                                        value: selectedList
                                                                .indexOf(post
                                                                    .stone_id) !=
                                                            -1,
                                                        onChanged: (value) {
                                                          log('Inside on tap');
                                                          setState(() {
                                                            if (selectedList
                                                                    .indexOf(post
                                                                        .stone_id) !=
                                                                -1) {
                                                              log('inside if');
                                                              selectedListJson
                                                                  .remove(post);
                                                              selectedList
                                                                  .remove(post
                                                                      .stone_id);
                                                            } else {
                                                              log('inside else');
                                                              selectedListJson
                                                                  .add(post);
                                                              selectedList.add(
                                                                  post.stone_id);
                                                            }
                                                            print(selectedList
                                                                .length);
                                                            var discTotal =
                                                                    0.00,
                                                                caratTotal =
                                                                    0.00,
                                                                amountTotal =
                                                                    0.00;
                                                            selectedListJson
                                                                .forEach(
                                                                    (element) {
                                                              discTotal = discTotal +
                                                                  double.parse(
                                                                      element
                                                                          .discount);
                                                              caratTotal = caratTotal +
                                                                  double.parse(
                                                                      element
                                                                          .carat);
                                                              amountTotal =
                                                                  amountTotal +
                                                                      double.parse(
                                                                          element
                                                                              .total_amt);
                                                            });

                                                            if (selectedList
                                                                    .length >
                                                                0) {
                                                              discount = (discTotal /
                                                                      selectedList
                                                                          .length)
                                                                  .toStringAsFixed(
                                                                      2);
                                                              carat = caratTotal
                                                                  .toStringAsFixed(
                                                                      2);
                                                              amtCts = (amountTotal /
                                                                      caratTotal)
                                                                  .toStringAsFixed(
                                                                      2);
                                                              total = amountTotal
                                                                  .toStringAsFixed(
                                                                      0);
                                                              log(discTotal
                                                                  .toString());
                                                            } else {
                                                              discTotal = 0.00;
                                                              caratTotal = 0.00;
                                                              amountTotal =
                                                                  0.00;
                                                              discount = '0';
                                                              carat = '0';
                                                              amtCts = '0';
                                                              total = '0';
                                                              log(discTotal
                                                                  .toString());
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
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                                          shapeMap[post.shape],
                                                          size: 40.0,
                                                          color:
                                                              Color(0XFF294ea3),
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
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Column(
                                                        children: <Widget>[
                                                          Text(post.shade,
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
                                                              post.luster,
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
                                                            Text(post.tb,
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
                                                            Text(post.sb,
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
                                                Divider(
                                                  color: Colors.grey[100],
                                                  thickness: 1.0,
                                                ),
                                                Container(
                                                  // height: 30,
                                                  width: MediaQuery.of(context)
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
                                                          Text('View Details',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Divider(),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        child: IconButton(
                                                            icon: Icon(
                                                              Icons.receipt,
                                                              color: Color(
                                                                  0XFF294ea3),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          MyMediaViewer(
                                                                            mediaType:
                                                                                'pdf',
                                                                            mediaUrl:
                                                                                post.pdfLink,
                                                                          )));
                                                            }),
                                                      ),
                                                      Container(
                                                        child: IconButton(
                                                            icon: Icon(
                                                              Icons.videocam,
                                                              color: Color(
                                                                  0XFF294ea3),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          MyMediaViewer(
                                                                            mediaType:
                                                                                'mp4',
                                                                            mediaUrl:
                                                                                post.videoLink,
                                                                          )));
                                                            }),
                                                      ),
                                                      Container(
                                                        child: IconButton(
                                                            icon: Icon(
                                                              Icons.image,
                                                              color: Color(
                                                                  0XFF294ea3),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      MyMediaViewer(
                                                                          mediaType:
                                                                              'image',
                                                                          mediaUrl:
                                                                              post.imageLink)));
                                                            }),
                                                      )
                                                    ],
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
                        content: Text('Your Cart is Empty'),
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

    return (responseJson['GetStockappResult']['Result'] as List)
        .map((p) => Stock.fromJson(p))
        .toList();
  }
}
