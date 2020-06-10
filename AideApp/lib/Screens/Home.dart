import 'package:AideApp/Screens/Alarm/Alarm.dart';
import 'package:AideApp/Screens/Calendar/month_view.dart';
import 'package:AideApp/Screens/InAppPayment/In_App_purchase.dart';
import 'package:AideApp/Screens/Registration/View_profile.dart';
import 'package:AideApp/Screens/TodoList/view-task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int pageIndex = 0;
  PageController pageController;

  @override
  void initState() { 
    super.initState();
    pageController = PageController();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      key: _scaffoldKey,
      body: PageView(
        children: <Widget>[
          ViewTask(),
          MonthCalendar(),
          InAppPurchase(),
          Alarm(),
          ViewProfile(),
         
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
              icon: Icon(Icons.work),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.alarm),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
            ),
          ]),
    );
    // return RaisedButton(
    //   child: Text('Logout'),
    //   onPressed: logout,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return buildAuthScreen();
  }
}
