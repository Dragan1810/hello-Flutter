import 'package:flutter/material.dart';
import 'package:hello_flutter/screens/Single.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        bottomNavItem(),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text("Home"),
        )
      ]),
      body: Container(
        padding: EdgeInsets.all(0.0),
        child: Stack(
          children: <Widget>[
            Image.asset('./assets/lake.jpg',height: 320.0,fit: BoxFit.fill),
            Column(
              children: <Widget>[
              Text("Velik Naslov Preko Cele Sike, A ispod je Grid Meni"),
              Expanded(
                child: GridView.count(
                    primary: true,
                    padding: EdgeInsets.all(20.0),
                    crossAxisCount: 2,
                    children: <Widget>[
                      Text('He\'d have you all unravel at the'),
                      Text('Heed not the rabble'),
                      Text('Sound of screams but the'),
                      Text('Who scream'),
                      Text('Revolution is coming...'),
                      Text('Revolution, they...'),
                    ],
                  ),
              )
            ],
            )
              ],
            ),
        ),
    );
  }
}

bottomNavItem() {
  return BottomNavigationBarItem(
    icon: Icon(Icons.home),
    title: Text("Home"),
  );
}