import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:ozone_diamonds/LoginPage.dart';

class MyChangePassword extends StatefulWidget {
  @override
  _MyChangePasswordState createState() => _MyChangePasswordState();
}

class _MyChangePasswordState extends State<MyChangePassword> {
  String currPass = "", newPass = "", confirmNewPass = "";
  bool _toggleVisibilityCurr = true,
      _toggleVisibilityNew = true,
      _toggleVisibilityNewConf = true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Change Password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          labelText: 'Current Password',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          suffixIcon: Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 0),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _toggleVisibilityCurr =
                                      !_toggleVisibilityCurr;
                                });
                              },
                              icon: _toggleVisibilityCurr
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                          ),
                        ),
                        obscureText: _toggleVisibilityCurr,
                        onChanged: (value) {
                          currPass = value.toString();
                        },
                        validator: (value) =>
                            value.isEmpty ? "Password can't be empty" : null,
                      ),
                    ),
                    flex: 3,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          labelText: 'New Password',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          suffixIcon: Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 0),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _toggleVisibilityNew = !_toggleVisibilityNew;
                                });
                              },
                              icon: _toggleVisibilityNew
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                          ),
                        ),
                        obscureText: _toggleVisibilityNew,
                        onChanged: (value) {
                          newPass = value.toString();
                        },
                        validator: (value) => value.isEmpty
                            ? "New Password can't be empty"
                            : null,
                      ),
                    ),
                    flex: 3,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          labelText: 'Confirm New Password',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          suffixIcon: Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 0),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _toggleVisibilityNewConf =
                                      !_toggleVisibilityNewConf;
                                });
                              },
                              icon: _toggleVisibilityNewConf
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                          ),
                        ),
                        obscureText: _toggleVisibilityNewConf,
                        onChanged: (value) {
                          confirmNewPass = value.toString();
                        },
                        validator: (value) =>
                            value.isEmpty ? "Password can't be empty" : null,
                      ),
                    ),
                    flex: 3,
                  )
                ],
              ),
            ),
            Container(
              child: RaisedButton(
                onPressed: () async {
                  if (newPass != "" && currPass != "" && confirmNewPass != "") {
                    if (newPass == confirmNewPass) {
                      Map<String, String> aheaders = {
                        'Content-Type': 'application/json; charset=utf-8',
                      };
                      Map<String, String> saveMap = new Map();
                      saveMap['Token'] = token;
                      saveMap['OldPassword'] = currPass;
                      saveMap['NewPassword'] = newPass;
                      http.Response response = await http.post(
                          'http://ozonediam.com/MobAppService.svc/ChanagePassword',
                          headers: aheaders,
                          body: json.encode(saveMap));
                      print(response.body);
                      Map responseJson = json.decode(response.body);
                      if (responseJson['ChanagePasswordResult'] == 'SUCCESS') {
                        scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text('Password change Success')));
                      } else {
                        scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text('Password change Fail')));
                      }
                    } else {
                      scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                              'New Password and Confirm Password dont Match')));
                    }
                  } else {
                    scaffoldKey.currentState.showSnackBar(
                        SnackBar(content: Text('Please Input all fields')));
                  }
                },
                child: Text('Change Password'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
