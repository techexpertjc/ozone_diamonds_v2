import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:ozone_diamonds/DashBoard.dart';
import 'LoginPage.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    loadProfileDetails();
  }

  bool dataLoad = false;
  Map<dynamic, dynamic> profileDetails = Map();
  void loadProfileDetails() async {
    var saveMap = Map();
    saveMap['Token'] = token;
    Map<String, String> aheaders = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    http.Response response = await http.post(
        'http://ozonediam.com/MobAppService.svc/GetUserProfile',
        headers: aheaders,
        body: json.encode(saveMap));

    profileDetails =
        json.decode(response.body)['GetUserProfileResult']['Result'][0];
    profileDetails.forEach((key, value) {
      if (profileDetails[key] == null) profileDetails[key] = 'null';
    });
    log(profileDetails.toString());
    setState(() {
      dataLoad = true;
    });
  }

  TextStyle currStyle = TextStyle(fontSize: 15);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
      ),
      body: dataLoad
          ? Stack(overflow: Overflow.visible, children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // color: Colors.white,
                child: CustomPaint(
                  painter: CurvePainter(),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 7,
                top: MediaQuery.of(context).size.height / 7,
                child: Row(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          profileDetails['DISPLAY_NAME']
                              .toString()
                              .toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200, right: 40, left: 40),
                child: Card(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                // color: Colors.black,
                                child: Text(
                                  'Username',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0XFF294ea3),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Text(
                                    profileDetails['USER_NAME'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      // color: Color(0XFF294ea3),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      )),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                // color: Colors.black,
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0XFF294ea3),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Text(
                                    profileDetails['EMAIL_ID'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      // color: Color(0XFF294ea3),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      )),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                // color: Colors.black,
                                child: Text(
                                  'Phone',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0XFF294ea3),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Text(
                                    profileDetails['PHONE_NO'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      // color: Color(0XFF294ea3),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      )),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                // color: Colors.black,
                                child: Text(
                                  'Phone 2',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0XFF294ea3),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Text(
                                    profileDetails['PHONE_NO_1'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      // color: Color(0XFF294ea3),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      )),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                // color: Colors.black,
                                child: Text(
                                  'Phone 3',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0XFF294ea3),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Text(
                                    profileDetails['PHONE_NO_2'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      // color: Color(0XFF294ea3),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      )),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                // color: Colors.black,
                                child: Text(
                                  'Designation',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0XFF294ea3),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Text(
                                    profileDetails['DESIGNATION'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      // color: Color(0XFF294ea3),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      )),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                // color: Colors.black,
                                child: Text(
                                  'Company Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0XFF294ea3),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Text(
                                    profileDetails['COMP_NAME'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      // color: Color(0XFF294ea3),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      )),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                // color: Colors.black,
                                child: Text(
                                  'Pin Code',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0XFF294ea3),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Text(
                                    profileDetails['PIN_CODE'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      // color: Color(0XFF294ea3),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      )),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                // color: Colors.black,
                                child: Text(
                                  'Country',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0XFF294ea3),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Text(
                                    profileDetails['COUNTRY'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      // color: Color(0XFF294ea3),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      )),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                // color: Colors.black,
                                child: Text(
                                  'Website',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0XFF294ea3),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Text(
                                    profileDetails['WEBSITE'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      // color: Color(0XFF294ea3),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      )),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                // color: Colors.black,
                                child: Text(
                                  'Fax',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0XFF294ea3),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Text(
                                    profileDetails['FAX_NO'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      // color: Color(0XFF294ea3),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      )),
                    ],
                  )),
                ),
              ),
            ])
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
