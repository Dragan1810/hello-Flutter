import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector (
                  onTap: () {
                    print("onTap called.");
                  },
                  child: Container(
                  decoration: new BoxDecoration(
                      border: new Border.all(color: Colors.blueAccent)
                  ),
                    child: Text("Single KLIK"),
                    width: 100.00,
                    height: 100.00,
                ),
                ),
                Container(
                  decoration: new BoxDecoration(
                      border: new Border.all(color: Colors.blueAccent)
                  ),
                  child: Text("RoW"),
                  width: 100.00,
                  height: 100.00,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.blueAccent)
                  ),
                  child: Text("RoW"),
                  width: 100.00,
                  height: 100.00,
                ),
                Container(
                  decoration: new BoxDecoration(
                      border: new Border.all(color: Colors.blueAccent)
                  ),
                  child: Text("RoW"),
                  width: 100.00,
                  height: 100.00,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}