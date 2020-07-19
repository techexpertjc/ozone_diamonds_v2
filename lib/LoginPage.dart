import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';

import 'DashBoard.dart';
import 'Login_API.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool small = false;
  bool _toggleVisibility = true;
  String email, password;

  //Validation method
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;
  bool isLoading = true;
  bool validateAndSave() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      setState(() {
        isLoading = true;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            //It is Image
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: SizedBox(
                child: Image.asset(
                  'asets/Ozonlogo.png',
                  fit: BoxFit.contain,
                  height: (small) ? 150 : 160,
                ),
              ),
            ),
            //Finish

            //TextField for Email
            Padding(
              padding: EdgeInsets.only(top: 40, left: 40.0, right: 40.0),
              child: SizedBox(
                //height: (small)?50:55,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontSize: (small) ? 14 : 16,
                        fontWeight: FontWeight.w500,
                      ),
                      hintText: 'Enter Email',
                      hintStyle: TextStyle(
                          fontSize: (small) ? 12 : 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[300])),
                  onChanged: (value) {
                    email = value.toString();
                  },
                  validator: (value) =>
                      value.isEmpty ? "Email can't be empty" : null,
                ),
              ),
            ),
            //Finish

            //TextField for Password
            Padding(
              padding: EdgeInsets.only(top: 30, left: 40.0, right: 40.0),
              child: SizedBox(
                //height: (small)?50:55,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: (small) ? 14 : 16,
                      fontWeight: FontWeight.w500,
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _toggleVisibility = !_toggleVisibility;
                          });
                        },
                        icon: _toggleVisibility
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                  ),
                  obscureText: _toggleVisibility,
                  onChanged: (value) {
                    password = value.toString();
                  },
                  validator: (value) =>
                      value.isEmpty ? "Password can't be empty" : null,
                ),
              ),
            ),
            //Finish

            //Forgot Password
            Padding(
              padding: EdgeInsets.only(top: 10, right: 40.0),
              child: InkWell(
                child: Text(
                  'Forgot Password',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
            //Finish

            //Login Button
            Padding(
              padding: EdgeInsets.only(top: 10.0, left: 40.0, right: 40.0),
              child: SizedBox(
                  height: (small) ? 50 : 55,
                  child: NiceButton(
                      elevation: 12.0,
                      radius: 52.0,
                      fontSize: (small) ? 20 : 22,
                      onPressed: () {
                        submit();
                      },
                      text: 'Login',
                      background: Colors.blue)),
            ),
            //Finish

            //New User
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 100.0),
              child: SizedBox(
                  height: (small) ? 50 : 55,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'New User? ',
                            style: TextStyle(
                                fontSize: (small) ? 16 : 18,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          InkWell(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: (small) ? 18 : 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.redAccent),
                            ),
                            onTap: () {},
                          )
                        ],
                      )
                    ],
                  )),
            ),
            //Finish
          ],
        ),
      ),
    ));
  }

  //submit method
  void submit() async {
    // initState();
    if (validateAndSave()) {
      await loginAPI(email, password);
      LoginUser user = LoginUser.fromJson(
          LoginValue); //value come from loginAPI return value
      if (user.msgs != null) {
        Navigator.pop(context, true);
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => DashBoard(
                      email: 'email',
                    )));
      } else {
        showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                  content: SingleChildScrollView(
                    child: Center(
                        child: Text(
                      "Your Password or Email Is Wrong?",
                      style: TextStyle(
                          fontSize: (small) ? 14 : 16,
                          fontWeight: FontWeight.w400),
                    )),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        "Ok",
                        style: TextStyle(
                            fontSize: (small) ? 18 : 20,
                            fontWeight: FontWeight.w300),
                      ),
                      onPressed: () {
                        Navigator.pop(context, true);
                        Navigator.pop(context, true);
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginPage()));
                      },
                    ),
                  ]);
            });
      }
    }
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
