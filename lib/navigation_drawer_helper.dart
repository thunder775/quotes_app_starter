import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationItem {
  String title;
  IconData icon;

  NavigationItem({@required this.icon, @required this.title});
}

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView(
          children: <Widget>[
            ExpansionTile(
              title: Text('Select Quotes Animation'),
              children: <Widget>[
                ListTile(
                  title: Text('Faded Animation'),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
