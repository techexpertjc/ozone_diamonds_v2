import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:ozone_diamonds/LoginPage.dart';
import 'package:video_player/video_player.dart';
import "package:http/http.dart" as http;

import 'search.dart';

class MyDNAPage extends StatefulWidget {
  final dnaData;
  MyDNAPage({Key key, this.dnaData}) : super(key: key);
  @override
  _MyDNAPageState createState() => _MyDNAPageState();
}

class _MyDNAPageState extends State<MyDNAPage> with TickerProviderStateMixin {
  Stock currStockObj;
  TabController imageTabController, contentTabController;
  VideoPlayerController myVideoController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PDFDocument certiPdf;
  TextStyle tabTextStyle = TextStyle(color: Colors.black, fontSize: 15);
  bool pdfLoaded = false;
  @override
  void initState() {
    imageTabController = TabController(length: 3, vsync: this);
    contentTabController = TabController(length: 3, vsync: this);
    currStockObj = widget.dnaData;
    log(currStockObj.toString());
    myInitFunc();
    // TODO: implement initState
    super.initState();
  }

  double videoHeight = 100, videoWidth = 100;

  bool videoLoaded = true, videoError = false;
  Widget pdfPage;
  void myInitFunc() async {
    try {
      log(currStockObj.videoLink + ' ' + currStockObj.pdfLink);
      myVideoController = VideoPlayerController.network(currStockObj.videoLink);
      myVideoController.addListener(() {
        if (myVideoController.value.hasError) {
          videoLoaded = false;
          videoError = true;
        }

        setState(() {});
        // myVideoController.setLooping(true);
      });
      myVideoController.initialize().then((value) {
        videoHeight = myVideoController.value.size.height / 2;
        videoWidth = myVideoController.value.size.width / 2;
        setState(() {});
      });

      myVideoController.setLooping(true);
      myVideoController.play();

      PDFDocument.fromURL(currStockObj.pdfLink).then((value) {
        setState(() {
          certiPdf = value;

          certiPdf.get().then((val) {
            pdfPage = val;
            pdfLoaded = true;
          });
        });
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: Container(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              child: Text(
                                'RAP',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              child: Text('\$' + currStockObj.rap_price),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(color: Colors.grey),
                              right: BorderSide(color: Colors.grey))),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              child: Text('\$/CTS',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Center(
                            child: Container(
                              child: Text('\$' + currStockObj.price_per_carat),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              child: Text('AMT',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Center(
                            child: Container(
                              child: Text('\$' + currStockObj.total_amt),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        final scaffoldKeyTemp = GlobalKey<ScaffoldState>();
                        String offerDisc, offerRate;
                        if (token != "" &&
                            token != null &&
                            partyCode != "" &&
                            partyCode != null) {
                          showDialog(
                              context: context,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Center(
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: Scaffold(
                                      resizeToAvoidBottomPadding: false,
                                      key: scaffoldKeyTemp,
                                      appBar: AppBar(
                                        title: Text('Make an Offer'),
                                      ),
                                      body: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(),
                                            Container(
                                              child: TextFormField(
                                                onChanged: (value) =>
                                                    offerDisc = value,
                                                decoration: InputDecoration(
                                                    hintText: 'DISC%'),
                                              ),
                                            ),
                                            Container(
                                              child: TextFormField(
                                                onChanged: (value) =>
                                                    offerRate = value,
                                                decoration: InputDecoration(
                                                    hintText: '\$\CTS'),
                                              ),
                                            ),
                                            Container(
                                              child: Text('Selected Items: 1'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 30)),
                                            Container(
                                              child: RaisedButton(
                                                onPressed: () async {
                                                  if (offerDisc == "" ||
                                                      offerRate == "") {
                                                    scaffoldKeyTemp.currentState
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                'Please enter all details.')));
                                                  } else {
                                                    scaffoldKeyTemp.currentState
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                'Submitting Details Please wait')));

                                                    Map tempMap = Map();
                                                    tempMap['OfferPara'] =
                                                        Map();
                                                    tempMap['OfferPara']
                                                        ['Token'] = token;
                                                    tempMap['OfferPara']
                                                            ['PartyCode'] =
                                                        partyCode;
                                                    Map offerMap = Map();
                                                    offerMap['PacketNo'] =
                                                        currStockObj.stone_id;
                                                    offerMap['Lab'] =
                                                        currStockObj.lab;
                                                    offerMap['Rate'] =
                                                        offerRate;
                                                    offerMap['DiscPer'] =
                                                        offerDisc;
                                                    tempMap['OfferPara']
                                                        ['Offer'] = [offerMap];
                                                    Map<String, String>
                                                        aheaders = {
                                                      'Content-Type':
                                                          'application/json; charset=utf-8',
                                                    };
                                                    await http
                                                        .post(
                                                            'http://ozonediam.com/MobAppService.svc/ManageOffer',
                                                            headers: aheaders,
                                                            body: json.encode(
                                                                tempMap))
                                                        .then((value) {
                                                      log(value.body);
                                                      if (value.body.contains(
                                                          'SUCCESS')) {
                                                        scaffoldKeyTemp
                                                            .currentState
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    'Offer Submitted Successfully')));
                                                      } else {
                                                        scaffoldKeyTemp
                                                            .currentState
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    'Submiting Offer failed please try again')));
                                                      }
                                                    }).catchError((error) {
                                                      scaffoldKeyTemp
                                                          .currentState
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  'Network issue please try again.')));
                                                    });
                                                  }
                                                },
                                                child: Text('Submit Offer'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        } else {
                          scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                  'You are not allowed to make an offer.')));
                        }
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Center(
                              child: Container(child: Icon(Icons.local_offer)),
                            ),
                            Center(
                              child: Container(
                                child: Text('Make Offer'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Column(
                        children: [
                          Center(
                              child:
                                  Container(child: Icon(Icons.remove_red_eye))),
                          Center(
                            child: Container(
                              child: Text('Request for View'),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                'Adding the items to cart please wait...')));

                        Map<String, String> aheaders = {
                          'Content-Type': 'application/json; charset=utf-8',
                        };
                        var saveMap = Map();
                        saveMap['Token'] = token;
                        saveMap['PacketNo'] = currStockObj.stone_id;
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
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                            content:
                                Text('The Items have been added to Cart')));
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Center(
                                child: Container(
                                    child: Icon(Icons.add_shopping_cart))),
                            Center(
                              child: Container(
                                child: Text('Add to Cart'),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
          backgroundColor: Colors.indigo[800],
          title: Text('Diamond Details - ' + currStockObj.stone_id)),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            color: Colors.grey[100],
            child: TabBarView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: pdfLoaded
                      ? pdfPage
                      : Center(child: CircularProgressIndicator()),
                  //Certificate
                ),
                videoLoaded
                    ? Container(
                        child: AspectRatio(
                            aspectRatio: myVideoController.value.aspectRatio,
                            child: Container(
                                padding: EdgeInsets.only(left: 50, right: 50),
                                width:
                                    (MediaQuery.of(context).size.width) - 200,
                                child: VideoPlayer(myVideoController))),
                        //Certificate
                      )
                    : videoError
                        ? Center(
                            child: Text('Video not Available'),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                Container(
                  child: FadeInImage(
                    imageErrorBuilder: (context, Obj, stackTrc) {
                      return Center(
                        child: Text('Cant load imaage'),
                      );
                    },
                    image: NetworkImage(currStockObj.imageLink),
                    placeholder: AssetImage('asets/loading1.gif'),
                  ),
                  //Certificate
                )
              ],
              controller: imageTabController,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 40,
                    child: IconButton(
                        icon: Icon(Icons.receipt),
                        onPressed: () {
                          imageTabController.animateTo(0);
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 40,
                    child: IconButton(
                        icon: Icon(Icons.ondemand_video),
                        onPressed: () {
                          imageTabController.animateTo(1);
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 40,
                    child: IconButton(
                        icon: Icon(Icons.photo),
                        onPressed: () {
                          imageTabController.animateTo(2);
                        }),
                  )
                ]),
          ),
          Container(
            height: 40,
            child: TabBar(
              tabs: <Widget>[
                Container(
                  height: 40,
                  child: Text(
                    'Diamond Details',
                    style: tabTextStyle,
                  ),
                ),
                Container(
                  height: 40,
                  child: Text(
                    'Measurements',
                    style: tabTextStyle,
                  ),
                ),
                Container(
                  height: 40,
                  child: Text(
                    'Additional Info',
                    style: tabTextStyle,
                  ),
                )
              ],
              controller: contentTabController,
            ),
          ),
          Container(
            height: double.parse((7 * 40).toString()),
            width: MediaQuery.of(context).size.width,
            child:
                TabBarView(controller: contentTabController, children: <Widget>[
              Container(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Shape:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.shape,
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Pkt No.:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.stone_id,
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blue[50],
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Size:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.carat,
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Cut:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.cut,
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Color:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.colour,
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Polish:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.polish,
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blue[50],
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Clarity:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.clarity,
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Symm:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.symm,
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Lab:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.lab,
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Fls:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.flu,
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blue[50],
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Location:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.location,
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Report:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.report_no,
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //Tab 2
              Container(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Table:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.table_per,
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Depth:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.depth,
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blue[50],
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Cr Angle:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.crown_angle,
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Cr Height:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.crown_height == 'null'
                                  ? '-'
                                  : currStockObj.crown_height,
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Pav Angle:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.pavilion_angle == 'null'
                                  ? '-'
                                  : currStockObj.pavilion_angle,
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Pav Height:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.pavilion_height == 'null'
                                  ? '-'
                                  : currStockObj.pavilion_height,
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blue[50],
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Girdle:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              '-',
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Ratio:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.ratio == 'null'
                                  ? '-'
                                  : currStockObj.ratio,
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Length:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.lenght == 'null'
                                  ? '-'
                                  : currStockObj.lenght,
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Width:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.width == 'null'
                                  ? '-'
                                  : currStockObj.width,
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blue[50],
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Depth:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.depth == 'null'
                                  ? '-'
                                  : currStockObj.depth,
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Culet:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              '-',
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //Tab 3
              Container(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('CB:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.cb == 'null' ? '-' : currStockObj.cb,
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('CW:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.cw == 'null' ? '-' : currStockObj.cw,
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blue[50],
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('SB:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.sb == 'null' ? '-' : currStockObj.sb,
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('SW:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.sw == 'null' ? '-' : currStockObj.sw,
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Eye Clean:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.eyeclean == 'null'
                                  ? '-'
                                  : currStockObj.eyeclean,
                              style: tabTextStyle,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            width: 1,
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text('Milky:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.milky == 'null'
                                  ? '-'
                                  : currStockObj.milky,
                              style: tabTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blue[50],
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child:
                                Text('Key To \nSymbols:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              currStockObj.ktos == 'null'
                                  ? '-'
                                  : currStockObj.ktos,
                              style: tabTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child:
                                Text('Report \nComment:', style: tabTextStyle),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: (MediaQuery.of(context).size.width - 2) / 4,
                            child: Text(
                              currStockObj.comments == 'null' ||
                                      currStockObj.comments == ''
                                  ? '-'
                                  : currStockObj.comments,
                              style: tabTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ]),
      ),
    ));
  }
}
