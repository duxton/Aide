import 'package:AideApp/Screens/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterShare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(138, 48, 127,1),
        accentColor: Color.fromRGBO(121, 167, 211,1)
      ),
      home: Home(),
    );
  }
}

