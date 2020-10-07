import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import 'package:nice_button/NiceButton.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool small = false;
  bool _toggleVisibility = true, rememberMe = false;
  final _formKey = new GlobalKey<FormState>();
  final scaffolKey = GlobalKey<ScaffoldState>();
  String email, password;

  bool isLoading = false;
  bool readTnC = false;
  String emailId = '',
      companyName = '',
      address = '',
      city = '',
      country = '',
      state = '',
      zip = '',
      contact = '',
      keyPerson = '',
      userId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolKey,
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //TextField for Email ID
              Padding(
                padding: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
                child: SizedBox(
                  child: TextFormField(
                    onChanged: (value) => emailId = value,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)
                        ? 'Please enter proper Email'
                        : null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        labelText: 'Email ID*',
                        labelStyle: TextStyle(
                          fontSize: (small) ? 14 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: 'Enter Your Email',
                        hintStyle: TextStyle(
                            fontSize: (small) ? 12 : 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[300])),
                  ),
                ),
              ),
              //Finish

              //TextField for Company Name
              Padding(
                padding: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
                child: SizedBox(
                  child: TextFormField(
                    onChanged: (value) => companyName = value,
                    validator: (value) =>
                        value.isEmpty ? 'Field cannot be empty' : null,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        labelText: 'Comapny Name*',
                        labelStyle: TextStyle(
                          fontSize: (small) ? 14 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: 'Enter Your Company Name',
                        hintStyle: TextStyle(
                            fontSize: (small) ? 12 : 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[300])),
                  ),
                ),
              ),
              //Finish

              //TextField for Address
              Padding(
                padding: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
                child: SizedBox(
                  child: TextFormField(
                    onChanged: (value) => address = value,
                    validator: (value) =>
                        value.isEmpty ? 'Field cannot be empty' : null,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        labelText: 'Address*',
                        labelStyle: TextStyle(
                          fontSize: (small) ? 14 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: 'Enter Your Address',
                        hintStyle: TextStyle(
                            fontSize: (small) ? 12 : 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[300])),
                  ),
                ),
              ),
              //Finish

              //TextField for Address
              Padding(
                padding: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
                child: SizedBox(
                  child: TextFormField(
                    onChanged: (value) => city = value,
                    validator: (value) =>
                        value.isEmpty ? 'Field cannot be empty' : null,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        labelText: 'Area, City',
                        labelStyle: TextStyle(
                          fontSize: (small) ? 14 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: 'Enter Your Area, City',
                        hintStyle: TextStyle(
                            fontSize: (small) ? 12 : 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[300])),
                  ),
                ),
              ),
              //Finish

              //TextField for Country
              Padding(
                padding: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
                child: SizedBox(
                  child: TextFormField(
                    onChanged: (value) => country = value,
                    validator: (value) =>
                        value.isEmpty ? 'Field cannot be empty' : null,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        labelText: 'Country',
                        labelStyle: TextStyle(
                          fontSize: (small) ? 14 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: 'Enter Your Country',
                        hintStyle: TextStyle(
                            fontSize: (small) ? 12 : 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[300])),
                  ),
                ),
              ),
              //Finish

              //TextField for State
              Padding(
                padding: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
                child: SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => state = value,
                    validator: (value) =>
                        value.isEmpty ? 'Field cannot be empty' : null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        labelText: 'State',
                        labelStyle: TextStyle(
                          fontSize: (small) ? 14 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: 'Enter Your State',
                        hintStyle: TextStyle(
                            fontSize: (small) ? 12 : 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[300])),
                  ),
                ),
              ),
              //Finish

              //TextField for Zip Code
              Padding(
                padding: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
                child: SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => zip = value,
                    validator: (value) =>
                        value.isEmpty ? 'Field cannot be empty' : null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        labelText: 'Zip Code',
                        labelStyle: TextStyle(
                          fontSize: (small) ? 14 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: 'Enter Your ZipCode',
                        hintStyle: TextStyle(
                            fontSize: (small) ? 12 : 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[300])),
                  ),
                ),
              ),
              //Finish

              //TextField for Contact
              Padding(
                padding: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
                child: SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => contact = value,
                    validator: (value) => (value.isEmpty ||
                            !RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
                                .hasMatch(value))
                        ? 'Input valid Contact number'
                        : null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        labelText: 'Contact No',
                        labelStyle: TextStyle(
                          fontSize: (small) ? 14 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: 'Enter Your Contact No',
                        hintStyle: TextStyle(
                            fontSize: (small) ? 12 : 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[300])),
                  ),
                ),
              ),
              //Finish

              //TextField for Key Person
              Padding(
                padding: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
                child: SizedBox(
                  child: TextFormField(
                    onChanged: (value) => keyPerson = value,
                    validator: (value) =>
                        value.isEmpty ? 'Field cannot be empty' : null,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        labelText: 'Key Person',
                        labelStyle: TextStyle(
                          fontSize: (small) ? 14 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: 'Enter Your First and Last Name',
                        hintStyle: TextStyle(
                            fontSize: (small) ? 12 : 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[300])),
                  ),
                ),
              ),
              //Finish

              //TextField for Login name
              Padding(
                padding: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
                child: SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => userId,
                    validator: (value) =>
                        value.isEmpty ? 'Field cannot be empty' : null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        labelText: 'Login Name/ User Id*',
                        labelStyle: TextStyle(
                          fontSize: (small) ? 14 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: 'Enter Your Login Name',
                        hintStyle: TextStyle(
                            fontSize: (small) ? 12 : 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[300])),
                  ),
                ),
              ),
              //Finish

              //Terms & Condition
              Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      Checkbox(
                          value: readTnC,
                          onChanged: (value) {
                            setState(() {
                              readTnC = value;
                            });
                          }),
                      Text(
                        "Please Read Terms & Condition And Agree",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                    ],
                  )),
              //Finish

              //Login Button
              Padding(
                padding: EdgeInsets.only(
                    top: 20.0, left: 40.0, right: 40.0, bottom: 40.0),
                child: SizedBox(
                  height: (small) ? 50 : 55,
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : NiceButton(
                          elevation: 5.0,
                          radius: 52.0,
                          fontSize: (small) ? 20 : 22,
                          onPressed: () async {
                            final form = _formKey.currentState;
                            log(readTnC.toString());
                            if (form.validate() && readTnC) {
                              log('valid');
                              setState(() {
                                isLoading = true;
                              });

                              Map paramMap = Map();
                              paramMap['LoginName'] = userId;
                              paramMap['emailid'] = emailId;
                              paramMap['CompName'] = companyName;
                              paramMap['Address'] = address;
                              paramMap['City'] = city;
                              paramMap['Country'] = country;
                              paramMap['State'] = state;
                              paramMap['ZipCode'] = zip;
                              paramMap['ContactNo'] = '';
                              paramMap['KeyPerson'] = keyPerson;
                              paramMap['MobileNo'] = contact;
                              Map<String, String> aheaders = {
                                'Content-Type':
                                    'application/json; charset=utf-8',
                              };
                              http.Response response = await http.post(
                                  'http://ozonediam.com//MobAppService.svc/Register',
                                  headers: aheaders,
                                  body: json.encode(paramMap));
                              var responseJson = json.decode(response.body);
                              log(response.body);
                              scaffolKey.currentState.showSnackBar(SnackBar(
                                  content:
                                      Text(responseJson['RegisterResult'])));
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              if (!readTnC) {
                                scaffolKey.currentState.showSnackBar(SnackBar(
                                    content: Text('Please agree to read TNC')));
                              }
                            }
                          },
                          text: 'Register',
                          background: Color(0XFF294EA3),
                        ),
                ),
              ),
              //Finish
            ],
          ),
        ),
      ),
    );
  }
}
