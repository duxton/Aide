import 'dart:ui';

import 'package:AideApp/Model/ListItem.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter/material.dart';

class AddCard extends StatefulWidget {
  static const routeName = '/Add_Card';

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController salaryRange = TextEditingController();
  TextEditingController recentTransactions = TextEditingController();
  TextEditingController fromWhere = TextEditingController();
  TextEditingController usedFor = TextEditingController();

  List<ListItem> _dropdownItems = [
    ListItem(1, "Mortage"),
    ListItem(2, "Car payment"),
    ListItem(3, "Food"),
    ListItem(4, "Entertainment"),
    ListItem(5, "Subscription"),
    ListItem(6, "Custom")
  ];

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

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

  customTextField(String text, sideIcon, controller, labelController) {
    return ListTile(
      // ListTile for input where was the photo was taken
      leading: sideIcon,
      title: Container(
        width: 250.0,
        child: TextField(
          style: TextStyle(color: Colors.black),
          controller: controller,
          decoration: InputDecoration(
            labelText: labelController,
            hintText: text,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  salaryCard() {
    //TODO:: Live edit
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
                'Salary Range',
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
      appBar: header(context, titleText: 'Add Card'),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            salaryCard(),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  customTextField('Total Amount', Icon(Icons.attach_money),
                      salaryRange, 'Total Amount'),
                  customTextField('What bank to store the money?',
                      Icon(Icons.location_on), fromWhere, 'Bank name'),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.announcement,
                          color: Colors.grey[700],
                        ),
                        //TODO:: Change this to others 
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        child: RaisedButton.icon(
                          label: Text(
                            "Add Card",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            //TODO:: Save it here 
                          },
                          icon: Icon(Icons.add_box, color: Colors.white),
                        ),
                      ),
                    ),
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
