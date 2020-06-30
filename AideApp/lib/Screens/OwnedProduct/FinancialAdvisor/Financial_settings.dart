import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter/material.dart';

class FinancialSettings extends StatelessWidget {
  TextEditingController salaryRange = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController fromWhere = TextEditingController();
  TextEditingController usedFor = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Settings'),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Icon(//TODO:: Think of something to put here
                  Icons.settings,
                  size: 100,
                )),
            customTextField('Income Range', Icon(Icons.attach_money),
                salaryRange, 'Salary Range'),
              
            customTextField('Description optional', Icon(Icons.description),
                description, 'Description'),
            customTextField('How do you want to manage your budget?',
                Icon(Icons.check), fromWhere, 'Budget?'),
            customTextField(
                'Monthly bills', Icon(Icons.category), usedFor, 'Type'),
          ],
        ),
      ),
    );
  }
}
