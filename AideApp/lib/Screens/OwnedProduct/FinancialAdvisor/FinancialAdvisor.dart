import 'package:AideApp/Screens/OwnedProduct/FinancialAdvisor/Financial_settings.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:credit_card_slider/card_background.dart';
import 'package:credit_card_slider/card_company.dart';
import 'package:credit_card_slider/card_network_type.dart';
import 'package:credit_card_slider/credit_card_slider.dart';
import 'package:credit_card_slider/credit_card_widget.dart';
import 'package:credit_card_slider/validity.dart';
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

  int _currentIndex = 0;

  List<CreditCard> _creditCards = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  ScrollController scrollController;
  bool dialVisible = true;

  AnimationController _controller;

  static const List<IconData> icons = const [
    Icons.credit_card,
    Icons.attach_money
  ];

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

    _creditCards = [
      CreditCard(
        cardBackground: SolidColorCardBackground(Colors.purple),
        cardNetworkType: CardNetworkType.visaBasic,
        cardHolderName: 'The boring developer',
        cardNumber: '1234 **** **** ****',
        company: CardCompany.sbi,
        showChip: false,
        validity: Validity(
          validThruMonth: 1,
          validThruYear: 21,
          validFromMonth: 1,
          validFromYear: 16,
        ),
      ),
      CreditCard(
        cardBackground: SolidColorCardBackground(kRed.withOpacity(0.4)),
        cardNetworkType: CardNetworkType.mastercard,
        cardHolderName: 'Gursheesh Singh',
        cardNumber: '2434 2434 **** ****',
        company: CardCompany.kotak,
        validity: Validity(
          validThruMonth: 1,
          validThruYear: 21,
        ),
      ),
      CreditCard(
        cardBackground: GradientCardBackground(LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [kBlue, kPurple],
          stops: [0.3, 0.95],
        )),
        cardNetworkType: CardNetworkType.mastercard,
        cardHolderName: 'Very Very very boring devloper',
        cardNumber: '4567',
        company: CardCompany.sbiCard,
        validity: Validity(
          validThruMonth: 2,
          validThruYear: 2021,
        ),
      ),
      CreditCard(
        cardBackground: ImageCardBackground(
            AssetImage('assets/images/background_sample.jpg')),
        cardNetworkType: CardNetworkType.mastercard,
        cardHolderName: 'John Doe',
        cardNumber: '2434 2434 **** ****',
        company: CardCompany.virgin,
        validity: Validity(
          validThruMonth: 1,
          validThruYear: 20,
        ),
      ),
    ];
  }

  creditCardSlider() {
    return Column(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: _creditCards.map((card) {
            return Builder(builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width,
                child: card,
              );
            });
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(_creditCards, (index, url) {
            return Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
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
          Container(child: creditCardSlider()),
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
