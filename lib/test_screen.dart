import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation _curvedAnimation;

  double buttonPositionY = 58;
  String quote;
  String author;
  bool loading = false;
  bool fadeTransition = true;

  Future<Map> getQuotes() async {
    Response response = await get('https://favqs.com/api/qotd');
//    print(response.body);

    return jsonDecode(response.body);
  }

  void isLoading() {
    setState(() {
      loading = true;
    });
  }

  void isNotLoading() {
    setState(() {
      loading = false;
    });
  }

  Future updateQuotes() async {
    isLoading();
    Map jsonMap = await getQuotes();
    isNotLoading();
    setState(() {
      controller.forward(from: 0);

      author = jsonMap['quote']['author'];
      quote = jsonMap['quote']['body'];
    });
  }

  Color yello_to_black() {
    return Color.lerp(
        Colors.yellow, Color(0xFF00003F), (buttonPositionY) / (60));
  }

  Color black_to_white() {
    return Color.lerp(Colors.black, Colors.white, (buttonPositionY) / (60));
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOutExpo, parent: controller);
    controller.addListener(() {
      setState(() {
        print(controller.value);
      });
    });
    super.initState();
    updateQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          elevation: 5,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Icon(
                  Icons.cloud_done,
                  color: Colors.lightBlueAccent,
                  size: MediaQuery.of(context).size.height * .18,
                ),
              ),
              ExpansionTile(
                title: Text(
                  'Quotes Animation',
                  style: TextStyle(fontSize: 22),
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
              ExpansionTile(
                title: Text(
                  'Category',
                  style: TextStyle(fontSize: 22),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text('Inspirational'),
                  ),
                  ListTile(
                    title: Text('Motivational'),
                  )
                ],
              ),
              Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Icon(Icons.copyright), Text('thunder775')],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: yello_to_black(),
      body: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, bottom: 16, top: 0, right: 40),
                      child: fadeTransition
                          ? FadeTransition(
                              opacity: controller,
                              child: Text(
                                '$quote',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: black_to_white(),
                                  fontSize: 33,
                                  fontFamily: 'DancingScript',
                                ),
                              ),
                            )
                          : SlideTransition(
                              position: Tween(
                                      begin: Offset(-1.0, 0.0),
                                      end: Offset.zero)
                                  .animate(_curvedAnimation),
                              child: Text(
                                '$quote',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: black_to_white(),
                                  fontSize: 33,
                                  fontFamily: 'DancingScript',
                                ),
                              ),
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, bottom: 8),
                          child: Text(
                            '$author',
                            style: TextStyle(
                                fontFamily: 'DancingScript',
                                color: Colors.red,
                                fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0,bottom: 12),
                          child: FloatingActionButton(
                              heroTag: 'nextbutton',
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.red,
                              onPressed: () async {
                                await updateQuotes();
                              },
                              child: loading
                                  ? SpinKitHourGlass(
                                      color: Colors.red,
                                      size: 30.0,
                                    )
                                  : Icon(Icons.arrow_forward)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      /// background container
                      height: 250,
                      width: 42,
                      color: yello_to_black(),
                    ),
                    Positioned(
                      /// socket container
                      bottom: 0,
                      right: 11,
                      child: Container(
                        height: 80,
                        width: 22,
                        decoration: BoxDecoration(
                          color: black_to_white().withOpacity(.2),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                    Positioned(
                      /// switch wire
                      top: 0,
                      right: 20,
                      child: Container(
                        color: black_to_white(),
                        width: 2.5,
                        height: 172 - (buttonPositionY - 70),
                      ),
                    ),
                    Positioned(
                      /// switch blob
                      bottom: buttonPositionY,
                      right: 12,
                      child: GestureDetector(
                        onVerticalDragUpdate: (DragUpdateDetails details) {
//                          print(details.delta.dy);
                          buttonPositionY -= details.delta.dy;
                          buttonPositionY = buttonPositionY.clamp(2.0, 58.0);
//                          if(buttonPositionY>28) buttonPositionY = 58;
//                          else if(buttonPositionY<=28) buttonPositionY = 2;
                          setState(() {});
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.75),
                                  blurRadius: 5,
                                  offset: Offset(0, 5)),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
