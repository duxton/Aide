import 'dart:ui';

import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllProduct extends StatefulWidget {
  static const routeName = '/AllProduct';

  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  final double itemHeight = 175;

  final double itemWidth = 150;

  customProduct(context, text, routeName) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          routeName,
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              height: 110,
              image: AssetImage('assets/images/milky-way.jpg'),
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController searchController = TextEditingController();

  Future<QuerySnapshot> searchResultsFuture;

  handleSearch(String query) {}

  clearSearch() {
    searchController.clear();
  }

  AppBar buildSearchField() {
    return AppBar(
      toolbarHeight: 75,
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
            hintText: "Search for product....",
            filled: true,
            prefixIcon: Icon(Icons.android),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: clearSearch,
            )),
        onFieldSubmitted: handleSearch,
      ),
    );
  }

  //bool get wantKeepAlive => true; // ** Keep state of this page if no changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
      body: GridView.count(
        childAspectRatio: (itemWidth / itemHeight),
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        crossAxisCount: 2,
        children: <Widget>[
          customProduct(context, 'Financial', '/Financial_Assistance'),
          customProduct(context, 'Todo Task', '/View_Task'),
          customProduct(context, 'Calender', '/Calender'),
          customProduct(context, 'Gym assistance', '/View_Task'),
          customProduct(context, 'Themes', '/View_Task'),
          customProduct(context, 'Gym assistance', '/View_Task'),
        ],
      ),
    );
  }
}
