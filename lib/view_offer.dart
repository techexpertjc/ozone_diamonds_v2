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
  TextStyle boldStyle = TextStyle(fontWeight: FontWeight.bold);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, IconData> shapeMap = {
    '1': OzoneDiaicon.round,
    '2': OzoneDiaicon.princess,
    '9': OzoneDiaicon.cushion,
    '7': OzoneDiaicon.oval,
    '4': OzoneDiaicon.emerald,
    '6': OzoneDiaicon.pear,
    '28': OzoneDiaicon.asscher,
    '15': OzoneDiaicon.heart,
    '13': OzoneDiaicon.radiant,
    '3': OzoneDiaicon.marquise
  };
  List<String> selectedList = List();
  List<Stock1> selectedListJson = List();
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
              new FutureBuilder<List<Stock1>>(
                future: fetchPosts(query),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int numOfResult = snapshot.data.length;
                    List<Stock1> posts = snapshot.data;

                    return Column(
                      children: <Widget>[
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
                        // Column(children: <Widget>[Text(numOfResult.toString())],),
                        new Column(
                            children: posts
                                .map((post) => Column(
                                      children: <Widget>[
                                        Card(
                                          elevation: selectedList.indexOf(
                                                      post.vpacket_no) !=
                                                  -1
                                              ? 5
                                              : 1,
                                          color: selectedList.indexOf(
                                                      post.vpacket_no) !=
                                                  -1
                                              ? Color(0XFFEBEFFA)
                                              : Colors.white,
                                          child: InkWell(
                                            onTap: () {
                                              log('Inside on tap');
                                              // setState(() {
                                              //   if (selectedList.indexOf(
                                              //           post.vpacket_no) !=
                                              //       -1) {
                                              //     log('inside if');
                                              //     selectedListJson.remove(post);
                                              //     selectedList
                                              //         .remove(post.vpacket_no);
                                              //   } else {
                                              //     log('inside else');
                                              //     selectedListJson.add(post);
                                              //     selectedList
                                              //         .add(post.vpacket_no);
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
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                                                      .vpacket_no) !=
                                                              -1,
                                                          onChanged: (value) {
                                                            log('Inside on tap');
                                                            setState(() {
                                                              if (selectedList
                                                                      .indexOf(post
                                                                          .vpacket_no) !=
                                                                  -1) {
                                                                log('inside if');
                                                                selectedListJson
                                                                    .remove(
                                                                        post);
                                                                selectedList
                                                                    .remove(post
                                                                        .vpacket_no);
                                                              } else {
                                                                log('inside else');
                                                                selectedListJson
                                                                    .add(post);
                                                                selectedList
                                                                    .add(post
                                                                        .vpacket_no);
                                                              }
                                                              print(selectedList
                                                                  .length);
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
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text(
                                                                post.vpacket_no,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
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
                                                              Text(
                                                                post.wgt,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
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
                                                              Text(post.color,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: (size)
                                                                          ? 14
                                                                          : 14)),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text(post.purity,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: (size)
                                                                          ? 14
                                                                          : 14)),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text(post.lab,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: (size)
                                                                          ? 14
                                                                          : 14)),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text(post.cut,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: (size)
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
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: (size)
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
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: (size)
                                                                          ? 14
                                                                          : 14)),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text(post.fls,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: (size)
                                                                          ? 14
                                                                          : 14)),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text(post.shape,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        (size)
                                                                            ? 14
                                                                            : 14,
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //         new Divider(
                                                  //   color: Colors.red,
                                                  // ),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Column(
                                                          children: <Widget>[
                                                            Text(
                                                              "Off Disc Per: ${post.offer_disc_per}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontSize:
                                                                      (size)
                                                                          ? 14
                                                                          : 14,
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
                                                                "Off Net Rate: ${post.offer_net_rate}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        700],
                                                                    fontSize:
                                                                        (size)
                                                                            ? 14
                                                                            : 14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                      // Expanded(
                                                      //   child: Column(
                                                      //     children: <Widget>[
                                                      //       Text(
                                                      //           "Off Net Val: ${post.offer_net_val} ",
                                                      //           style: TextStyle(
                                                      //               color: Color(
                                                      //                   0XFF294ea3),
                                                      //               fontSize:
                                                      //                   (size)
                                                      //                       ? 14
                                                      //                       : 14,
                                                      //               fontWeight:
                                                      //                   FontWeight
                                                      //                       .bold)),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                  new Divider(
                                                    color: Colors.grey[100],
                                                    thickness: 1.0,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: <Widget>[
                                                            Text(
                                                              "Off Net Val: ${post.offer_net_val}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontSize:
                                                                      (size)
                                                                          ? 13
                                                                          : 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Column(
                                                          children: <Widget>[
                                                            Text(
                                                                "Net Rate: ${post.net_rate}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        700],
                                                                    fontSize:
                                                                        (size)
                                                                            ? 13
                                                                            : 13,
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
                                                                "Net Val: ${post.net_val}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        700],
                                                                    fontSize:
                                                                        (size)
                                                                            ? 13
                                                                            : 13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // new Divider(
                                                  //   color: Colors.grey[100],
                                                  //   thickness: 1.0,
                                                  // ),
                                                  // Row(
                                                  //   children: <Widget>[
                                                  //     Expanded(
                                                  //       child: Column(
                                                  //         children: <Widget>[
                                                  //           Text('MEAS:',
                                                  //               style: TextStyle(
                                                  //                   color: Colors
                                                  //                           .grey[
                                                  //                       700],
                                                  //                   fontSize:
                                                  //                       (size)
                                                  //                           ? 12
                                                  //                           : 12,
                                                  //                   fontWeight:
                                                  //                       FontWeight
                                                  //                           .bold)),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //     Expanded(
                                                  //       child: Column(
                                                  //         children: <Widget>[
                                                  //           Text(
                                                  //             "RATIO(%):",
                                                  //             style: TextStyle(
                                                  //                 color: Colors
                                                  //                         .grey[
                                                  //                     700],
                                                  //                 fontSize:
                                                  //                     (size)
                                                  //                         ? 12
                                                  //                         : 12,
                                                  //                 fontWeight:
                                                  //                     FontWeight
                                                  //                         .bold),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  // Divider(
                                                  //   color: Colors.grey[100],
                                                  //   thickness: 1.0,
                                                  // ),
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

  Future<List<Stock1>> fetchPosts(String query) async {
    Map<String, String> aheaders = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    final msg = jsonEncode({"Token": token, "PartyCode": partyCode});
    http.Response response = await http.post(
        'http://ozonediam.com/MobAppService.svc/GetViewOffer',
        headers: aheaders,
        body: msg);
    var responseJson = json.decode(response.body);
    log('inside result ' +
        responseJson['GetViewOfferResult']['Result'][0].toString());
    return (responseJson['GetViewOfferResult']['Result'] as List)
        .map((p) => Stock1.fromJson(p))
        .toList();
  }
}

class Stock1 {
  final String color,
      color_no,
      cut,
      cut_no,
      disc_per,
      fls,
      fls_no,
      lab,
      net_rate,
      net_val,
      offer_disc_per,
      offer_net_rate,
      offer_net_val,
      party_name,
      party_seq,
      polish,
      polish_no,
      prop_no,
      purity,
      purity_no,
      rate,
      seller_name,
      seq_no,
      shape,
      shape_no,
      symm,
      symm_no,
      trans_date,
      vpacket_no,
      wgt;

  Stock1(
      {this.color,
      this.color_no,
      this.cut,
      this.cut_no,
      this.disc_per,
      this.fls,
      this.fls_no,
      this.lab,
      this.net_rate,
      this.net_val,
      this.offer_disc_per,
      this.offer_net_rate,
      this.offer_net_val,
      this.party_name,
      this.party_seq,
      this.polish,
      this.polish_no,
      this.prop_no,
      this.purity,
      this.purity_no,
      this.rate,
      this.seller_name,
      this.seq_no,
      this.shape,
      this.shape_no,
      this.symm,
      this.symm_no,
      this.trans_date,
      this.vpacket_no,
      this.wgt});

  factory Stock1.fromJson(Map<String, dynamic> json) {
    return new Stock1(
        color: json['COLOR'].toString(),
        color_no: json['COLOR_NO'].toString(),
        cut: json['CUT'].toString(),
        cut_no: json['CUT_NO'].toString(),
        disc_per: json['DISC_PER'].toString(),
        fls: json['FLS'].toString(),
        fls_no: json['FLS_NO'].toString(),
        lab: json['LAB'].toString(),
        net_rate: json['NET_RATE'].toString(),
        net_val: json['NET_VALUE'].toString(),
        offer_disc_per: json['OFFER_DISC_PER'].toString(),
        offer_net_rate: json['OFFER_NET_RATE'].toString(),
        offer_net_val: json['OFFER_NET_VALUE'].toString(),
        party_name: json['PARTY_NAME'].toString(),
        party_seq: json['PARTY_SEQ'].toString(),
        polish: json['POLISH'].toString(),
        polish_no: json['POLISH_NO'].toString(),
        prop_no: json['PROP_NO'].toString(),
        purity: json['PURITY'].toString(),
        purity_no: json['PURITY_NO'].toString(),
        rate: json['RATE'].toString(),
        seller_name: json['SELLER_NAME'].toString(),
        seq_no: json['SEQ_NO'].toString(),
        shape: json['SHAPE'].toString(),
        shape_no: json['SHAPE_NO'].toString(),
        symm: json['SYMM'].toString(),
        symm_no: json['SYMM_NO'].toString(),
        trans_date: json['TRANS_DATE'].toString(),
        vpacket_no: json['VPACKET_NO'].toString(),
        wgt: json['WGT'].toString());
  }
}
