import 'package:AideApp/Model/ListItem.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter/material.dart';

// ShowDialog what this is about and how is it useful for user and adjust to what they have.
// If possible make this encrypted so that we as developer has no ways to access these sensitive information.
class UserFinancialDetailed extends StatefulWidget {
  @override
  _UserFinancialDetailedState createState() => _UserFinancialDetailedState();
}

class _UserFinancialDetailedState extends State<UserFinancialDetailed> {
  customTextField(
      String text, sideIcon, controller, labelController, trailingWidget) {
    return ListTile(
      // ListTile for input where was the photo was taken
      leading: sideIcon,
      title: Container(
        width: 150.0,
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
      trailing: trailingWidget,
    );
  }

  customTitle(String text, sideIcon, trailingWidget) {
    return ListTile(
      // ListTile for input where was the photo was taken
      leading: sideIcon,
      title: Container(
          width: 150.0,
          child: Center(
            child: Text(text),
          )),
      trailing: trailingWidget,
    );
  }

  List<ListItem> _dropdownMonthlyPayment = [
    ListItem(1, "House"),
    ListItem(2, "Car "),
    ListItem(3, "Investment "),
    ListItem(4, "Watch"),
    ListItem(4, "Custom"),
  ];

  List<ListItem> _dropdownAssets = [
    ListItem(1, "House"),
    ListItem(2, "Property "),
    ListItem(3, "Shoplots "),
    ListItem(4, "Watch"),
    ListItem(4, "Custom"),
  ];
  @override
  void initState() {
    super.initState();
    _dropdownMonthlyPaymentItems =
        buildDropDownMenuItems(_dropdownMonthlyPayment);
    _selectedMonthlyPayment = _dropdownMonthlyPaymentItems[0].value;

    _dropdownAssetsItems = buildDropDownMenuItems(_dropdownAssets);
    _selectedAssets = _dropdownAssetsItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> _dropdownMonthlyPaymentItems;
  ListItem _selectedMonthlyPayment;

  List<DropdownMenuItem<ListItem>> _dropdownAssetsItems;
  ListItem _selectedAssets;

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

  List<Widget> _children = [];
  int _count = 0;

  addFormWidget(functions) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Ink(
        color: Colors.blue,
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          title: Center(
              child: Text(
            "Add form",
            style: TextStyle(color: Colors.white),
          )),
          trailing: Icon(Icons.help),
          onTap: functions,
        ),
      ),
    );
  }

  TextEditingController income = TextEditingController();
  TextEditingController worth = TextEditingController();
  void _addIncome() {
    _children = List.from(_children)
      ..add(
        customTextField(
          'Allowance / Salary / Income',
          Icon(Icons.attach_money),
          income,
          "Income",
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
      );
    setState(() => ++_count);
  }

  List<Widget> _assetChildren = [];
  int _assetcount = 0;

  void _addAssets() {
    _assetChildren = List.from(_assetChildren)
      ..add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  value: _selectedAssets,
                  items: _dropdownAssetsItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedAssets = value;
                      if (value == 1) {}
                    });
                  }),
            ),
            Container(
              width: 100.0,
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: worth,
                decoration: InputDecoration(
                  labelText: 'Worth',
                  hintText: 'Worth',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
            ),
          ],
        ),
      );
    setState(() => ++_assetcount);
  }

  List<Widget> _monthlyChildren = [];
  int _monthlycount = 0;

  void _addMonthly() {
    _monthlyChildren = List.from(_monthlyChildren)
      ..add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  value: _selectedMonthlyPayment,
                  items: _dropdownMonthlyPaymentItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedMonthlyPayment = value;
                      if (value == 1) {}
                    });
                  }),
            ),
            Container(
              width: 100.0,
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: income,
                decoration: InputDecoration(
                  labelText: 'Income',
                  hintText: 'Income',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
            ),
          ],
        ),
      );
    setState(() => ++_monthlycount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Financial / Assets'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 3,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.55,
              child: Text(
                'Net Worth RM 300,000',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
          customTitle(
              'Allowance / Salary / Income',
              Icon(Icons.attach_money),
              IconButton(
                icon: Icon(Icons.help, color: Colors.black),
                onPressed: () {},
              )),
          addFormWidget(() {
            showDialog(
              context: context,
              builder: (_) => StatefulBuilder(
                builder: (context, setState) {
                  return new AlertDialog(
                    title: new Text("Material Dialog"),
                    content: Container(
                        width: 300,
                        height: 300,
                        child: ListView(children: _children)),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Close me!'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text('Add form!'),
                        onPressed: () {
                          setState(() {
                            _addIncome();
                          });
                        },
                      )
                    ],
                  );
                },
              ),
            );
          }),
          customTitle(
              'Monthly Payment',
              Icon(Icons.attach_money),
              IconButton(
                icon: Icon(Icons.help, color: Colors.black),
                onPressed: () {},
              )),
          addFormWidget(() {
            showDialog(
              context: context,
              builder: (_) => StatefulBuilder(
                builder: (context, setState) {
                  return new AlertDialog(
                    title: new Text("Material Dialog"),
                    content: Container(
                        width: 300,
                        height: 300,
                        child: ListView(children: _monthlyChildren)),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Close me!'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text('Add form!'),
                        onPressed: () {
                          setState(() {
                            _addMonthly();
                          });
                        },
                      )
                    ],
                  );
                },
              ),
            );
          }),
          customTitle(
              'Assets',
              Icon(Icons.attach_money),
              IconButton(
                icon: Icon(Icons.help, color: Colors.black),
                onPressed: () {},
              )),
          addFormWidget(() {
            showDialog(
              context: context,
              builder: (_) => StatefulBuilder(
                builder: (context, setState) {
                  return new AlertDialog(
                    title: new Text("Material Dialog"),
                    content: Container(
                        width: 300,
                        height: 300,
                        child: ListView(children: _assetChildren)),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Close me!'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text('Add form!'),
                        onPressed: () {
                          setState(() {
                            _addAssets();
                          });
                        },
                      )
                    ],
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
