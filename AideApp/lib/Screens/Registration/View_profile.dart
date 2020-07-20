import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter/material.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: header(context, titleText:'Profile'),);
  }
}
