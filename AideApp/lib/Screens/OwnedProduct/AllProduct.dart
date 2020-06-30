import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter/material.dart';

class AllProduct extends StatelessWidget {
  static const routeName = '/AllProduct';
  customProduct(context, text) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/Financial_Assistance'
        );
      },
      child: Container(
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
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image(
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
            Text(
              'RM 5/month',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Assistance'),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          customProduct(context, 'Financial Advisor'),
          customProduct(context, 'Themes'),
          customProduct(context, 'Gym assistance'),
        ],
      ),
    );
  }
}
