import 'package:flutter/material.dart';

class SingleView extends StatefulWidget {
  @override
  SingleState createState() => SingleState();
}

class SingleState extends State<SingleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            img(),
            info(),
            buttons(),
          ],
        ),
      ),
    );
  }
}

Widget img() {
  return Image.asset(
    'assets/lake.jpg',
    height: 240.0,
    width: 600.0,
    fit: BoxFit.cover,
  );
}

Widget info() {
  return Row(
    children: <Widget>[
      Expanded(
        child: Column(
          children: <Widget>[
            Text("Oeschinen Lake Campground"),
            Text("Kandersteg, Switzerland"),
          ],
        ),
      ),
      Icon(Icons.star),
      Text("41")
    ],
  );
}

Widget buttons() {
  return Row(
    children: <Widget>[
      Column(
        children: <Widget>[
          Icon(Icons.call),
          Text("CALL"),
        ],
      ),
      Column(
        children: <Widget>[
          Icon(Icons.directions_run),
          Text("ROUTE"),
        ],
      ),
      Column(
        children: <Widget>[
          Icon(Icons.share),
          Text("SHARE"),
        ],
      ),
    ],
  );
}
