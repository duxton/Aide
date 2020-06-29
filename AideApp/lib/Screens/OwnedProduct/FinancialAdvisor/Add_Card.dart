import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter/material.dart';

class AddCard extends StatelessWidget {
  static const routeName = '/Add_Card';
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: header(context, titleText: 'Add Card'),body: Container(),);
  }
}