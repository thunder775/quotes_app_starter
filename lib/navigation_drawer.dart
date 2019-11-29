import 'package:flutter/material.dart';
import 'main.dart';
class NavigationColumn extends StatefulWidget {
  @override
  _NavigationColumnState createState() => _NavigationColumnState();
}

class _NavigationColumnState extends State<NavigationColumn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
              .3,
              .5,
              .7
            ],
            colors: [
              Color(0xFF984FD0).withOpacity(.1),
              Color(0xFF984FD0).withOpacity(.2),
              Color(0xFF984FD0).withOpacity(.3),
            ]),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                color: Colors.white70,
                child: ExpansionTile(
                  title: Text(
                    'Quotes Animation',
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Ubuntu',
                        color: Color(0xFF984FD0)),
                  ),
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        fadeTransition = true;

                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      title: Text('Fade Transition'),
                    ),
                    ListTile(
                      onTap: () {
                        fadeTransition = false;
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      title: Text('Slide Transition'),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.copyright),
              Text(
                'thunder775',
                style: TextStyle(fontFamily: 'Ubuntu'),
              )
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
