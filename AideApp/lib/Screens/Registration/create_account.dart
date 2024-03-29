import 'dart:async';

import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username;
  String displayName;

  submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      SnackBar snackbar = SnackBar(
          content: Text(
        "Welcome $username",
      ));
      _scaffoldKey.currentState.showSnackBar(snackbar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, username);
      });
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: header(context,
            titleText: "Set up your profile", removeBackButton: true),
        body: ListView(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Center(
                      child: Text(
                        'Create a username',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              autovalidate: true,
                              validator: (val) {
                                if (val.trim().length < 3 || val.isEmpty) {
                                  return 'Username too short';
                                } else if (val.trim().length > 12) {
                                  return "Username too long";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (val) => username = val,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Username",
                                labelStyle: TextStyle(fontSize: 15),
                                hintText: 'Must be at least 3 characters',
                              ),
                            ),
                            SizedBox(height: 25,),
                            TextFormField(
                              autovalidate: true,
                              validator: (val) {
                                if (val.trim().length < 3 || val.isEmpty) {
                                  return 'Display name too short';
                                } else if (val.trim().length > 12) {
                                  return "Display name too long";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (val) => displayName = val,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Display Name",
                                labelStyle: TextStyle(fontSize: 15),
                                hintText: 'Must be at least 3 characters',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: submit,
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
