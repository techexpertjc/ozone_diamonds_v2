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
      if (profileDetails[key] == null || profileDetails[key] == '')
        profileDetails[key] = 'NA';
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
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Container(
                      child: CircleAvatar(
                        minRadius: 50,
                        child: Icon(
                          Icons.person,
                          size: 70,
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: profileDetails['USER_NAME'],
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                              color: Color(0XFF294ea3), fontSize: 20)),
                      enabled: false,
                    ),
                    TextFormField(
                      initialValue: profileDetails['EMAIL_ID'],
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Color(0XFF294ea3), fontSize: 20)),
                      enabled: false,
                    ),
                    TextFormField(
                      initialValue: profileDetails['PHONE_NO'],
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Phone',
                          labelStyle: TextStyle(
                              color: Color(0XFF294ea3), fontSize: 20)),
                      enabled: false,
                    ),
                    TextFormField(
                      initialValue: profileDetails['PHONE_NO_1'],
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Phone 2',
                          labelStyle: TextStyle(
                              color: Color(0XFF294ea3), fontSize: 20)),
                      enabled: false,
                    ),
                    TextFormField(
                      initialValue: profileDetails['PHONE_NO_2'],
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Phone 3',
                          labelStyle: TextStyle(
                              color: Color(0XFF294ea3), fontSize: 20)),
                      enabled: false,
                    ),
                    TextFormField(
                      initialValue: profileDetails['DESIGNATION'],
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Designation',
                          labelStyle: TextStyle(
                              color: Color(0XFF294ea3), fontSize: 20)),
                      enabled: false,
                    ),
                    TextFormField(
                      initialValue: profileDetails['COMP_NAME'],
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Company Name',
                          labelStyle: TextStyle(
                              color: Color(0XFF294ea3), fontSize: 20)),
                      enabled: false,
                    ),
                    TextFormField(
                      initialValue: profileDetails['PIN_CODE'],
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Pin Code',
                          labelStyle: TextStyle(
                              color: Color(0XFF294ea3), fontSize: 20)),
                      enabled: false,
                    ),
                    TextFormField(
                      initialValue: profileDetails['COUNTRY'],
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Country',
                          labelStyle: TextStyle(
                              color: Color(0XFF294ea3), fontSize: 20)),
                      enabled: false,
                    ),
                    TextFormField(
                      initialValue: profileDetails['WEBSITE'],
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Website',
                          labelStyle: TextStyle(
                              color: Color(0XFF294ea3), fontSize: 20)),
                      enabled: false,
                    ),
                    TextFormField(
                      initialValue: profileDetails['FAX_NO'],
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Fax',
                          labelStyle: TextStyle(
                              color: Color(0XFF294ea3), fontSize: 20)),
                      enabled: false,
                    ),
                  ],
                )),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
