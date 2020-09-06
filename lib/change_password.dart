import 'package:flutter/material.dart';

class MyChangePassword extends StatefulWidget {
  @override
  _MyChangePasswordState createState() => _MyChangePasswordState();
}

class _MyChangePasswordState extends State<MyChangePassword> {
  String currPass = "", newPass = "", confirmNewPass = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: Text('Current Password'),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                        child: TextFormField(
                      decoration: InputDecoration(hintText: 'Current Password'),
                      onChanged: (val) => currPass = val,
                    )),
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
                      child: Text('New Password'),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                        child: TextFormField(
                      decoration: InputDecoration(hintText: 'New Password'),
                      onChanged: (val) => newPass = val,
                    )),
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
                      child: Text('Confirm New Password'),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                        child: TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Confirm New Password'),
                      onChanged: (val) => confirmNewPass = val,
                    )),
                    flex: 3,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
