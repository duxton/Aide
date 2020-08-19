import 'dart:ui';

import 'package:AideApp/Model/email_authentication.dart';
import 'package:flutter/material.dart';

import 'package:AideApp/Screens/OwnedProduct/AllProduct.dart';
import 'package:AideApp/Screens/InAppPayment/In_App_purchase.dart';
import 'package:AideApp/Screens/Registration/View_profile.dart';
import 'package:flutter/cupertino.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  bool isAuth = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int pageIndex = 0; //TODO:: Figure out how to set default tab as pageIndex = 1 
  PageController pageController;

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: PageView(
        children: <Widget>[
          AllProduct(),
          InAppPurchase(),
          ViewProfile(auth: widget.auth, onSignedOut: widget.onSignedOut,),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(), // Make sure user cant scroll
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onTap,
          activeColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              title: Text('Functions')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Purchases')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile')
            ),
          ]),
    );
  }
}
