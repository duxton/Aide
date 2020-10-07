import 'dart:ui';

import 'package:AideApp/Model/ListItem.dart';
import 'package:AideApp/Screens/OwnedProduct/FinancialAdvisor/AddUserInfo.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter/material.dart';

class FinancialSettings extends StatefulWidget {
  @override
  _FinancialSettingsState createState() => _FinancialSettingsState();
}

class _FinancialSettingsState extends State<FinancialSettings> {
  TextEditingController salaryRange = TextEditingController();

  TextEditingController income = TextEditingController();

  TextEditingController fromWhere = TextEditingController();

  TextEditingController usedFor = TextEditingController();

  List<ListItem> _dropdownItems = [
    ListItem(1, "50% of Total Income"),
    ListItem(2, "25% of Total Income"),
    ListItem(3, "10% of Total Income"),
  ];

  List<ListItem> _dropdownOccupations = [
    ListItem(1, "Student"),
    ListItem(2, "Employer "),
    ListItem(3, "Small Business "),
    ListItem(4, "Cooperation business"),
    ListItem(4, "Custom"),
  ];

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _dropdownOccupationsItems =
        buildDropDownMenuItems(_dropdownOccupations);
    _selectedItem = _dropdownMenuItems[0].value;
    _selectedOccupations = _dropdownOccupationsItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  List<DropdownMenuItem<ListItem>> _dropdownOccupationsItems;
  ListItem _selectedOccupations;

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



  customSalaryRange(String text, controller, labelController) {
    return Container(
      width: 100.0,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Settings'),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Icon(
                    //TODO:: Think of something to put here
                    Icons.settings,
                    size: 100,
                  )),
              Center(
                child: Text('Salary'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: customSalaryRange(
                        'Income Range lowest', salaryRange, 'Salary Range'),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(' ---- '),
                  ),
                  Flexible(
                    flex: 2,
                    child: customSalaryRange(
                      'Income Range highest',
                      salaryRange,
                      'Salary Range',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.announcement,
                      color: Colors.grey[700],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 16),
                            value: _selectedOccupations,
                            items: _dropdownOccupationsItems,
                            onChanged: (value) {
                              setState(() {
                                _selectedOccupations = value;
                                if (value == 1) {}
                              });
                            }),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.help),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('What is this?'),
                              content: Container(
                                child: Text(
                                    'This is automatically set options for you to choose from either to save from Total Income'),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.announcement,
                      color: Colors.grey[700],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                    IconButton(
                      icon: Icon(Icons.help),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('What is this?'),
                              content: Container(
                                child: Text(
                                    'This is automatically set options for you to choose from either to save from Total Income'),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Ink(
                  color: Colors.blue,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    title: Center(
                        child: Text(
                      'Go to More Detailed',
                      style: TextStyle(color: Colors.white),
                    )),
                    trailing: Icon(Icons.help),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserFinancialDetailed()));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Ink(
                  color: Colors.blue,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    title: Center(
                        child: Text(
                      'Tap for advice',
                      style: TextStyle(color: Colors.white),
                    )),
                    trailing: Icon(Icons.help),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Advice'),
                            content: Container(
                              child: Text(
                                  'This is automatically set options for you to choose from either to save from Total Income'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
