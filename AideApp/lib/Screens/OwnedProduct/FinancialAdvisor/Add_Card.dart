import 'dart:ui';

import 'package:AideApp/Model/income_card.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class AddCard extends StatefulWidget {
  static const routeName = '/Add_Card';

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController salaryRange = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController fromWhere = TextEditingController();
  TextEditingController usedFor = TextEditingController();

  customTextField(String text, sideIcon, controller, labelController) {
    return ListTile(
      // ListTile for input where was the photo was taken
      leading: sideIcon,
      title: Container(
        width: 250.0,
        child: TextField(
          style: TextStyle(color: Colors.black),
          controller: controller,
          decoration: InputDecoration(
            labelText: labelController,
            hintText: text,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  salaryCard() {
    return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Theme.of(context).accentColor,
                  Theme.of(context).primaryColor,
                ],
              )),
              height: MediaQuery.of(context).size.height * 0.25,
              child: Card(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ListTile(
                      title: Center(
                          child: Text(
                        'Salary Range',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      )),
                      subtitle: Center(
                          child: Text(
                        'Description',
                        style: TextStyle(
                          color: Colors.grey[300],
                        ),
                      )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'From where',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Type',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Add Card'),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 5,),
            salaryCard(),
             SizedBox(height: 50,),
            Container(
              child: Column(
                children: <Widget>[
                  customTextField('Salary Range', Icon(Icons.attach_money),
                      salaryRange, 'Salary Range'),
                  customTextField('Description optional',
                      Icon(Icons.description), description, 'Description'),
                  customTextField('Where did you get this money from?',
                      Icon(Icons.location_on), fromWhere, 'From Where'),
                  customTextField('Where do you want to use this money?',
                      Icon(Icons.category), usedFor, 'Type'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
