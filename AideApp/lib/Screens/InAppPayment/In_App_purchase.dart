import 'package:AideApp/Screens/InAppPayment/ProductDetails.dart';
import 'package:flutter/material.dart';

class InAppPurchase extends StatefulWidget {
  @override
  _InAppPurchaseState createState() => _InAppPurchaseState();
}

customProduct(context, text) {
  return GestureDetector(
    onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetails(),
        )),
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
          SizedBox(
            height: 25,
          ),
          Container(
            // Button for current location
            alignment: Alignment.center,
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * 0.6,
              height: 45,
              child: RaisedButton.icon(
                label: Text(
                  'Purchase',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {},
                icon: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _InAppPurchaseState extends State<InAppPurchase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: header(context,
        //     titleText: 'Shopping',
        //     backgroundColor: Colors.white,
        //      removeBackButton: true,
        //     icons: IconButton(
        //       icon: Icon(Icons.shopping_cart),
        //       color: Colors.black,
        //       onPressed: () {},
        //     )),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 1,
          children: <Widget>[
            customProduct(context, 'Financial Advisor'),
            customProduct(context, 'Themes'),
            customProduct(context, 'Gym assistance'),
          ],
        ));
  }
}
