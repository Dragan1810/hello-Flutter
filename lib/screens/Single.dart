import 'package:flutter/material.dart';

class SingleView extends StatefulWidget {

  @override
  SingleState createState() => SingleState();
}

class SingleState extends State<SingleView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text("Hello"),
          Row(
            children: <Widget>[
              Expanded(
                child: Text("Hello :P"),
              ),
              Icon(Icons.ac_unit),
              Text("41")
            ],
          )
        ],
      ),
        );
  }
}