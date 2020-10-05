import 'package:flutter/material.dart';

import 'package:nice_button/NiceButton.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool small = false;
  bool _toggleVisibility = true, rememberMe = false;
  String email, password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        leading: GestureDetector(
          onTap: () {/*on click logic*/},
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Form(
        child: ListView(
          children: <Widget>[
            //TextField for Email ID
            Padding(
              padding: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
              child: SizedBox(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
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
              padding: EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
              // child: ListView(
              //   children: <Widget>[
              //     Row(
              //       children: <Widget>[
              //         Text(
              //           "Please Read Terms & Condition And Agree",
              //           textAlign: TextAlign.left,
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, fontSize: 17.0),
              //         ),
              //         Column(
                        
              //         )
              //       ],
              //     )
              //   ],
              // ),
              child:  Text(
                        "Please Read Terms & Condition And Agree",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
            ),
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
                        onPressed: () {},
                        text: 'Register',
                        background: Color(0XFF294EA3),
                      ),
              ),
            ),
            //Finish
          ],
        ),
      ),
    );
  }
}
