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
        child: Column(
          children: <Widget>[
            img(),
            info(),
            buttons(),
            textSection,
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
  return Padding(
    padding: const EdgeInsets.all(32.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  "Oeschinen Lake Campground",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Kandersteg, Switzerland",
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.star,
          color: Colors.red,
        ),
        Text("41")
      ],
    ),
  );
}

Widget buttons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

Widget textSection = Container(
  padding: const EdgeInsets.all(32.0),
  child: Text(
    '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
    softWrap: true,
  ),
);
