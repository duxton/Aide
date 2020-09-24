import 'dart:ui';

import 'package:AideApp/Model/ListItem.dart';
import 'package:AideApp/Screens/OwnedProduct/FinancialAdvisor/Financial_settings.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:table_calendar/table_calendar.dart';

salaryCard(total, totalMoney, bank, recentTransactions) {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.purple, Colors.deepPurple])),
    height: 500,
    child: Card(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                total,
                style: TextStyle(fontSize: 15, color: Colors.white),
              )),
            ),
            subtitle: Center(
                child: Text(
              totalMoney,
              style: TextStyle(
                fontSize: 30,
                color: Colors.grey[300],
              ),
            )),
          ),
          Text(
            bank,
            style: TextStyle(color: Colors.white),
          ),
          Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    recentTransactions,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )),
        ],
      ),
    ),
  );
}

final List<Widget> imgList = [
  // Total for what, Total Amount, IN/From Where, usedForCategories
  salaryCard('Total', 'RM 115,230', 'All Bank', 'ALL'),
  salaryCard('Cash on hands', 'RM 2000', 'Maybank', 'Cash'),
  salaryCard('Total balance', 'RM 5123', 'Maybank', 'Entertainment'),
  salaryCard('Total balance', 'RM 100,000', 'American Express', 'Mortage'),
  salaryCard('Total balance', 'RM 10,000', 'OCBC Bank', 'Food'),
];

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

  CalendarController _calendarController;

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

    _calendarController = CalendarController();
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  transactionsCard(name, where, price, colorStyle) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text(where),
        trailing: Text(
          price,
          style: TextStyle(color: colorStyle),
        ),
      ),
    );
  }

  buildTransactionsBody() {
    return Column(
      children: <Widget>[
        Container(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCalendar(
                calendarController: _calendarController,
                initialCalendarFormat: CalendarFormat.week,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                headerVisible: false,
              ),
            )),
        transactionsCard('Samsung', 'Sunway Pyramid', '-5000', Colors.red),
        transactionsCard('Salary', 'Apple', '+ 5000', Colors.green),
        transactionsCard('Apple', 'Sunway Pyramid', '-5000', Colors.red),
        transactionsCard('Salary', 'Apple', '+ 5000', Colors.green),
        transactionsCard('Apple', 'Sunway Pyramid', '-5000', Colors.red),
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
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return TransactionsDialog();
                });
          },
          label: 'Add Transactions',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
      ],
    );
  }

  salaryCardSlideShow() {
    //TODO:: Carousel slider
    return EnlargeStrategyDemo();
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
          Container(child: salaryCardSlideShow()),
          SizedBox(
            height: 10,
          ),
          buildTransactionsBody(),
        ],
      ),
      floatingActionButton: buildSpeedDial(),
    );
  }
}

class EnlargeStrategyDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
          items: imageSliders,
        ),
      ],
    ));
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: item,
                      width: 1000,
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class TransactionsDialog extends StatefulWidget {
  @override
  _TransactionsDialogState createState() => _TransactionsDialogState();
}

class _TransactionsDialogState extends State<TransactionsDialog> {
  List<ListItem> _dropdownItems = [
    ListItem(1, "+ Add"),
    ListItem(2, "- Minus"),
  ];

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;
  final _formKey = GlobalKey<FormState>();
  String productName;
  String storeName;
  int amount;

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  transactionsFormField(labelText, varName, keyboardType) {
    return TextFormField(
      autovalidate: true,
      validator: (val) {
        // if ( val.isEmpty) {
        //   return 'Display name too short';
        // } else if (val.trim().length > 8) {
        //   return "Display name too long";
        // } else {
        //   return null;
        // }
      },
      onSaved: (val) => varName = val,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 15),
        hintText: 'Must be at least 3 characters',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Add Transactions',
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: transactionsFormField(
                        'Product name', productName, TextInputType.name),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: transactionsFormField(
                        'Store name', storeName, TextInputType.name),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: transactionsFormField(
                        'Amount', amount, TextInputType.number),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: Colors.grey[700],
                        ),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 16),
                                value: _selectedItem,
                                items: _dropdownMenuItems,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedItem = value;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        child: Text('Submit', style: TextStyle(color: Colors.blue, fontSize: 15),),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                          }
                        },
                      ),
                      FlatButton(
                        child: Text('Cancel', style: TextStyle(color: Colors.blue, fontSize: 15),),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
