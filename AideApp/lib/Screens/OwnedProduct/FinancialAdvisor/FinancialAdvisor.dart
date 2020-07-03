import 'package:AideApp/Screens/OwnedProduct/FinancialAdvisor/Financial_settings.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'dart:math' as math;

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FinancialAssistance extends StatefulWidget {
  static const routeName = '/Financial_Assistance';

  @override
  _FinancialAssistanceState createState() => _FinancialAssistanceState();
}

class _FinancialAssistanceState extends State<FinancialAssistance>
    with TickerProviderStateMixin {
  Color kPink = Color(0xFFEE4CBF);
  Color kRed = Color(0xFFFA3754);
  Color kBlue = Color(0xFF4AA3F2);
  Color kPurple = Color(0xFFAF92FB);

  ScrollController scrollController;
  bool dialVisible = true;

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });

    }

    transactionCard() {
      return Column(
        children: <Widget>[
          Container(
              color: Colors.grey[300],
              width: MediaQuery.of(context).size.width * 1,
              height: 40,
              child: Center(
                child: Text(
                  'Today',
                ),
              )),
          Card(
            child: ListTile(
              title: Text('Nike Balance Grey Series'),
              subtitle: Text('Sunway Pyramid'),
              trailing: Text(
                '- RM200',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Nike Balance Grey Series'),
              subtitle: Text('Sunway Pyramid'),
              trailing: Text(
                '+ RM200',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Nike Balance Grey Series'),
              subtitle: Text('Sunway Pyramid'),
              trailing: Text(
                '- RM200',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Nike Balance Grey Series'),
              subtitle: Text('Sunway Pyramid'),
              trailing: Text(
                '+ RM200',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        ],
      );
    }

    SpeedDial buildSpeedDial() {
      return SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // child: Icon(Icons.add),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        visible: dialVisible,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: Icon(Icons.payment, color: Colors.white),
            backgroundColor: Colors.deepOrange,
            onTap: () {
              Navigator.of(context).pushNamed('/Add_Card');
            },
            label: 'Add Card',
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            labelBackgroundColor: Colors.deepOrangeAccent,
          ),
          SpeedDialChild(
            child: Icon(Icons.attach_money, color: Colors.white),
            backgroundColor: Colors.green,
            onTap: () {
              Navigator.of(context).pushNamed('/Add_Transactions');
            },
            label: 'Add Transactions',
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            labelBackgroundColor: Colors.green,
          ),
        ],
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
                  'RM 5000',
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
        appBar: header(context,
            titleText: 'Financial Assistance',
            icons: IconButton(
              icon: Icon(Icons.settings), // to settings
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinancialSettings(),
                    ));
              },
            )),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(child: salaryCard()),
            SizedBox(
              height: 10,
            ),
            transactionCard(),
          ],
        ),
        floatingActionButton: buildSpeedDial(),
      );
    }
  }

