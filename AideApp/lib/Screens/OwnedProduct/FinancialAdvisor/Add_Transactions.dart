import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter/material.dart';

class AddTransactions extends StatelessWidget {
  static const routeName = '/Add_Transactions';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Add Transactions'),
      body: Container(),
    );
  }
}
