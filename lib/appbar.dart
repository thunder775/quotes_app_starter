import 'package:flutter/material.dart';
import 'package:quotes_app_starter/quotes_screen.dart';
import 'package:shimmer/shimmer.dart';

class CustomAppbar extends StatelessWidget {
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
              Color(0xFF984FD0).withOpacity(.4),
              Color(0xFF984FD0).withOpacity(.6),
              Color(0xFF984FD0),
            ]),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Text(
              'THUNDER 775',
              style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuotesScreen(
                          tag: 'food',
                        )));
              },
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        blurRadius: 10.0,
                        spreadRadius: .5,
                        offset: Offset(
                          1.0,
                          1.0,
                        ),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                width: MediaQuery.of(context).size.width * .70,
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '\"Quote Of The Day\"',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Ubuntu',
                              color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 20,
                          color: Color(0xFF984FD0),
                        )
                      ],
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Shimmer.fromColors(
                period: Duration(seconds: 2),
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Center(
                  child: Text(
                    'GET BEST QUOTES !',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        fontFamily: 'Ubuntu',
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'On Just One Click',
            style: TextStyle(
                letterSpacing: 1,
                fontSize: 12,
                fontFamily: 'Ubuntu',
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
