import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:ozone_diamonds/search_with_tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DashBoard.dart';
import 'Login_API.dart';
import 'StoneSearch.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

String token, partyCode, allowBuy;
LoginUser currentUser;

class _LoginPageState extends State<LoginPage> {
  bool small = false;
  bool _toggleVisibility = true, rememberMe = false;
  String email, password;

  SharedPreferences pref;

  //Validation method
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;
  bool isLoading = false;
  TextEditingController pswdController, emailController;
  bool validateAndSave() {
    setState(() {
      isLoading = true;
    });
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      setState(() {
        // isLoading = true;
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
                  controller: emailController,
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
                  controller: pswdController,
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

            //Finish

            //Remember Me
            Padding(
                padding: EdgeInsets.only(top: 10, right: 40.0, left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Checkbox(
                            activeColor: Color(0XFF294EA3),
                            value: rememberMe,
                            onChanged: (val) {
                              setState(() {
                                rememberMe = val;
                              });
                            }),
                        Text('Remember Me'),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: InkWell(
                        onTap: () async {
                          scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Processing your request')));
                        },
                        child: Text(
                          'Forgot Password',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Color(0XFF294EA3),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),

            //Login Button
            Padding(
              padding: EdgeInsets.only(top: 10.0, left: 40.0, right: 40.0),
              child: SizedBox(
                  height: (small) ? 50 : 55,
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : NiceButton(
                          elevation: 12.0,
                          radius: 52.0,
                          fontSize: (small) ? 20 : 22,
                          onPressed: () {
                            submit();
                          },
                          text: 'Login',
                          background: Color(0XFF294EA3),
                        )),
            ),
            //Finish

            //New User
          ],
        ),
      ),
    ));
  }

  //submit method
  void submit() async {
    if (rememberMe) {
      pref.setString('userMail', email.trim());
      pref.setString('userPswd', password.trim());
    } else {
      pref.setString('userMail', null);
      pref.setString('userPswd', null);
    }
    // initState();
    if (validateAndSave()) {
      await loginAPI(email.trim(), password.trim());
      LoginUser user = LoginUser.fromJson(LoginValue);
      //value come from loginAPI return value
      if (user.msgs != null) {
        currentUser = user;
        if (user.token != null) {
          token = user.token;
          partyCode = user.partycode;
          allowBuy = user.buy;
        }
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
                      },
                    ),
                  ]);
            });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  //internet Connection Checking
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    emailController = TextEditingController();
    pswdController = TextEditingController();

    SharedPreferences.getInstance().then((value) {
      pref = value;
      if (pref.getString('userMail') != null) {
        setState(() {
          emailController.text = pref.getString('userMail');
          pswdController.text = pref.getString('userPswd');
          email = emailController.text;
          password = pswdController.text;

          rememberMe = true;
        });
      }
      savedSearch = pref.getStringList('savedSearch');
    });
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
