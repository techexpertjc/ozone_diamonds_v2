import 'dart:async';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ozone_diamonds/cart_page.dart';
import 'package:ozone_diamonds/change_password.dart';
import 'package:ozone_diamonds/my_order.dart';
import 'package:ozone_diamonds/my_profile.dart';
import 'package:ozone_diamonds/new_arrival.dart';
import 'package:ozone_diamonds/pair_search_result.dart';
import 'package:ozone_diamonds/search.dart';
import 'package:ozone_diamonds/search_with_tabs.dart';
import 'package:ozone_diamonds/view_offer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Drawer/AboutUs.dart';
import 'Drawer/ContactUs.dart';
import 'Login_API.dart';

import 'StoneSearch.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key, this.email, this.id, this.name = 'User'})
      : super(key: key);
  final String email, id, name;

  @override
  _DashBoardState createState() => _DashBoardState();
}

double h = 0, w = 0;

class _DashBoardState extends State<DashBoard> {
  final String number = "9722273818";
  final String email = "Sales@ozonediam.com";
  bool size = false;
  bool small = false;
  LoginUser user = LoginUser.fromJson(LoginValue);
  // @override

  // void whatsAppOpen() async {
  //   bool whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");

  //   if (whatsapp) {
  //     await FlutterLaunch.launchWathsApp(phone: "5534992016100", message: "Hello, flutter_launch");
  //   } else {
  //     print("Whatsapp não instalado");
  //   }
  // }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // var menu_one_url = new AssetImage('asets/Serch.jpg');
    // var menu_one_image = new Image(image: menu_one_url, height: 100);
    Widget image_carousel = new Container(
      height: 250.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage('asets/Jewel1.jpg'),
            AssetImage('asets/Jewel2.jpg'),
          ],
          autoplay: false,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
          dotSize: 4.0,
          dotColor: Colors.blue,
          indicatorBgPadding: 4.0,
        ),
      ),
    );
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Container(
            child: Image.asset('asets/Ozon-logo.png'),
            padding: EdgeInsets.only(left: 5),
          ),
          backgroundColor: Colors.grey[200],
          // centerTitle: true,
          actions: [
            Container(
              padding: EdgeInsets.only(right: 5),
              child: InkWell(
                onTap: () {
                  scaffoldKey.currentState.openEndDrawer();
                },
                child: Icon(
                  Icons.menu,
                  color: Color(0XFF264796),
                ),
              ),
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                //bottomRight: Radius.circular(25),
                ),
          ),
          // backgroundColor: Colors.blueAccent,
          elevation: 20.0,
          iconTheme:
              IconThemeData(color: Colors.white, size: (small) ? 30 : 32),
        ),
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.black87,
                    image: DecorationImage(
                        image: AssetImage('asets/Jewel1.jpg'),
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                            Colors.black54, BlendMode.srcATop)),
                    backgroundBlendMode: BlendMode.dstATop),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  accountName: Text(user.name,
                      style: TextStyle(
                          fontSize: (small) ? 16 : 18,
                          fontWeight: FontWeight.w400)),
                  accountEmail: Text(
                    user.emailID,
                    style: TextStyle(
                        fontSize: (small) ? 14 : 16,
                        fontWeight: FontWeight.w300),
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MySearchPage()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Color(0XFF294ea3),
                  ),
                  title: Text("Search"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => NewArrivalList()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.new_releases,
                    color: Color(0XFF294ea3),
                  ),
                  title: Text("New Arrival"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PairSearchlist(
                            fil: '',
                          )));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Color(0XFF294ea3),
                  ),
                  title: Text("Pair Search"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyOrder()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.card_travel,
                    color: Color(0XFF294ea3),
                  ),
                  title: Text("My Order & Invoice"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyCartList()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.shopping_basket,
                    color: Color(0XFF294ea3),
                  ),
                  title: Text("My Cart"),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    Icons.save_alt,
                    color: Color(0XFF294ea3),
                  ),
                  title: Text(
                    "Save Your Demand",
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => OfferList()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.local_offer,
                    color: Color(0XFF294ea3),
                  ),
                  title: Text("View Offer"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyProfile()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Color(0XFF294ea3),
                  ),
                  title: Text("My Profile"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyChangePassword()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.vpn_key,
                    color: Color(0XFF294ea3),
                  ),
                  title: Text("Change Password"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AboutUS()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Color(0XFF294ea3),
                  ),
                  title: Text("About Us"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => contactus()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.contact_phone,
                    color: Color(0XFF294ea3),
                  ),
                  title: Text("Contact Us"),
                ),
              ),
            ],
          ),
        ),
        body: Stack(overflow: Overflow.visible, children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // color: Colors.white,
            child: CustomPaint(
              painter: CurvePainter(),
            ),
          ),
          ListView(
            children: <Widget>[
              //SearchField
              Padding(
                  padding: EdgeInsets.only(
                      top: 15.0, bottom: 5.0, left: 10.0, right: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7)),
                    height: (size) ? 40 : 40,
                    // color: Colors.white,
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        print(
                            'AND (REPORT_NO IN (\"${value}\") or VPACKET_NO IN(\"${value}\"))');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => searchlist(
                                  fil:
                                      'AND (REPORT_NO IN (\"${value}\") or VPACKET_NO IN(\"${value}\"))',
                                )));
                      },
                      autofocus: false,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                          // border: InputBorder.none,
                          hintText: 'Stone ID / Cert No.',
                          prefixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Color(0XFF294EA3),
                              ),
                              onPressed: () {}),
                          hintStyle: TextStyle(
                              fontSize: (size) ? 14 : 14,
                              fontWeight: FontWeight.w500)),
                    ),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: Image(image: AssetImage('asets/dashboard_img.png')),
              ),

              new Container(
                  child: new Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MySearchPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                                color: Color(0XFF294EA3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0XFFB8C6FF),
                                    offset: Offset(0, 4), //(x,y)
                                    blurRadius: 0.0,
                                  ),
                                ],
                                // border: Border.all(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Image.asset('asets/specific_search.png'),
                                  SizedBox(height: 5.0),
                                  Expanded(
                                    child: Container(
                                      // color: Colors.black,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text("Specific Search",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                            textAlign: TextAlign.left),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //   Expanded(
                    //     flex: 1,
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (BuildContext context) =>
                    //                     StoneSearch()));
                    //       },
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Container(
                    //           height: 100,
                    //           decoration: BoxDecoration(
                    //               border: Border.all(color: Colors.grey),
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(5))),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Column(
                    //               children: <Widget>[
                    //                 Icon(
                    //                   Icons.search,
                    //                   size: 40.0,
                    //                   color: Colors.grey[800],
                    //                 ),
                    //                 SizedBox(height: 5.0),
                    //                 Text("PAIR SEARCH",
                    //                     style: TextStyle(
                    //                         fontWeight: FontWeight.bold,
                    //                         fontSize: 12.0),
                    //                     textAlign: TextAlign.center)
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    //   Expanded(
                    //     flex: 1,
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         Navigator.of(context).push(MaterialPageRoute(
                    //             builder: (BuildContext context) =>
                    //                 NewArrivalList()));
                    //       },
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Container(
                    //           height: 100,
                    //           decoration: BoxDecoration(
                    //               border: Border.all(color: Colors.grey),
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(5))),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Column(
                    //               children: <Widget>[
                    //                 Icon(
                    //                   Icons.new_releases,
                    //                   size: 40.0,
                    //                   color: Colors.grey[800],
                    //                 ),
                    //                 SizedBox(height: 5.0),
                    //                 Text("NEW ARRIVAL",
                    //                     style: TextStyle(
                    //                         fontWeight: FontWeight.bold,
                    //                         fontSize: 12.0),
                    //                     textAlign: TextAlign.center)
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ],
                  ]),
                  Row(
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PairSearchlist(fil: '')));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Color(0XFF294EA3),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                  // border: Border.all(color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Image.asset('asets/pair_search.png'),
                                    SizedBox(height: 5.0),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text("Pair Search",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                            textAlign: TextAlign.left),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        // height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15.0),
                              bottom: Radius.circular(15.0)),
                          color: Color(0XFF294EA3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Image.asset('asets/ORM.png'),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "Rahul Vaghasiya",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              IconButton(
                                                onPressed: () =>
                                                    launch("tel:$number"),
                                                icon: CircleAvatar(
                                                  backgroundColor:
                                                      Color(0XFFEBEFFA),
                                                  child: Icon(
                                                    Icons.call,
                                                    color: Color(0XFF294EA3),
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              IconButton(
                                                onPressed: () =>
                                                    launch("mailto:$email"),
                                                icon: CircleAvatar(
                                                  backgroundColor:
                                                      Color(0XFFEBEFFA),
                                                  child: Icon(
                                                      Icons.mail_outline,
                                                      color: Color(0XFF294EA3),
                                                      size: 20),
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              IconButton(
                                                  icon: CircleAvatar(
                                                    backgroundColor:
                                                        Color(0XFFEBEFFA),
                                                    child: FaIcon(
                                                        FontAwesomeIcons
                                                            .whatsapp,
                                                        color:
                                                            Color(0XFF294EA3),
                                                        size: 20),
                                                  ),
                                                  onPressed: () async {
                                                    const url =
                                                        'https://wa.me/9722273818';
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  }),
                                            ],
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
        ]),
        // bottomNavigationBar: Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        //     color: Colors.white,
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey,
        //         offset: Offset(0.0, 1.0), //(x,y)
        //         blurRadius: 5.0,
        //       ),
        //     ],
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 8.0),
        //     child: Row(
        //       children: <Widget>[
        //         Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             Text(
        //               "Rahulbhai",
        //               style:
        //                   TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //             ),
        //           ],
        //         ),
        //         Expanded(
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: <Widget>[
        //               IconButton(
        //                 onPressed: () => launch("tel:$number"),
        //                 icon: Icon(
        //                   Icons.call,
        //                   color: Colors.green,
        //                   size: 30,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         Expanded(
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: <Widget>[
        //               IconButton(
        //                 onPressed: () => launch("mailto:$email"),
        //                 icon: Icon(Icons.mail_outline,
        //                     color: Colors.red, size: 30),
        //               ),
        //             ],
        //           ),
        //         ),
        //         Expanded(
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: <Widget>[
        //               IconButton(
        //                   icon: FaIcon(FontAwesomeIcons.whatsappSquare,
        //                       color: Colors.green, size: 30),
        //                   onPressed: () async {
        //                     const url = 'https://wa.me/9722273818';
        //                     if (await canLaunch(url)) {
        //                       await launch(url);
        //                     } else {
        //                       throw 'Could not launch $url';
        //                     }
        //                   }),
        //             ],
        //           ),
        //         ),
        //         Expanded(
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: <Widget>[
        //               IconButton(
        //                   icon: FaIcon(FontAwesomeIcons.skype,
        //                       color: Colors.blue, size: 30),
        //                   onPressed: () {}),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }

  //internet Connection Checking
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result.toString();
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        setState(() {});
      } else {
        InternetError();
      }
    });
    myInitFunc();
  }

  void myInitFunc() async {
    await FlutterDownloader.initialize();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void InternetError() {
    showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
              content: SingleChildScrollView(
                child: Center(
                    child: Text(
                  "Internet Connection Lose!!",
                  style: TextStyle(
                      fontSize: (small) ? 18 : 20, fontWeight: FontWeight.w400),
                )),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "Yes",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
                  ),
                  onPressed: () {
                    exit(0);
                  },
                ),
              ]);
        });
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0XFF294EA3);
    paint.style = PaintingStyle.fill;

    // TODO: implement paint
    var path = Path();
    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
    // throw UnimplementedError();
  }
}
