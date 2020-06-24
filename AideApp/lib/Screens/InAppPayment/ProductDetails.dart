import 'dart:ui';

import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

productHeader() {
  return Row(
    children: <Widget>[
      Expanded(
          child: Container(
        child: ListTile(
          title: Text(
            'Product Name',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('Personal'),
        ),
      )),
      Expanded(
        child: Container(
          height: 100,
          child: Center(
              child: Text('RM 5/Month',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
        ),
      ),
    ],
  );
}

productBody(context) {
  return Expanded(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(
        "May musical arrival beloved luckily adapted him. Shyness mention married son she his started now. Rose if as past near were. To graceful he elegance oh moderate attended entrance pleasure. Vulgar saw fat sudden edward way played either. Thoughts smallest at or peculiar relation breeding produced an. At depart spirit on stairs. She the either are wisdom praise things she before. Be mother itself vanity favour do me of. Begin sex was power joy after had walls miles. ",
        style: TextStyle(letterSpacing: 2.5),
      ),
    ),
  );
}


Widget purchase() {
  return Container(
    padding: EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          child: Text(
            "ADD TO BAG +",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F2F3E)),
          ),
          color: Colors.transparent,
          onPressed: () {},
        ),
        Text(
          r"$95",
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w100,
              color: Color(0xFF2F2F3E)),
        )
      ],
    ),
  );
}

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Product'),
      body: Container(
        child: Column(
          children: <Widget>[
            EnlargeStrategyDemo(),
            productHeader(),
            productBody(context),
            purchase(),
          ],
        ),
      ),
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
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${imgList.indexOf(item)} image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();
