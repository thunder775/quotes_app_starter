import 'dart:convert';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class QuotesScreen extends StatefulWidget {
  final String tag;

  const QuotesScreen({Key key,@required this.tag}) : super(key: key);
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation _curvedAnimation;

  double buttonPositionY = 58;
  String quote='Fetching Data';
  String author = 'Fetching Data';
  bool loading = false;




  Future<Map> getQuotes() async {
    Response response = await get(
        'https://favqs.com/api/quotes/?filter=${widget.tag}&type=tag',
        headers: {
          'Authorization': 'Token token=fb4117205f11d23e8f935e65d6389b2e'
        });
    print(response.body);

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

  int index = 0;

  Future updateQuotes() async {
    isLoading();
    Map jsonMap = await getQuotes();
    isNotLoading();
    setState(() {
      controller.forward(from: 0);

      author = jsonMap['quotes'][index]['author'];
      quote = jsonMap['quotes'][index]['body'];
    });
  }

  Color yello_to_black() {
    return Color.lerp(
        Color(0xFF00003F), Colors.white, (buttonPositionY) / (60));
  }

  Color black_to_white() {
    return Color.lerp(Colors.white, Colors.black, (buttonPositionY) / (60));
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
      setState(() {});
    });
    super.initState();
    updateQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: yello_to_black(),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
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
                                  fontFamily: 'Ubuntu',
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
                                fontSize: 33),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 24.0, bottom: 12),
                          child: FloatingActionButton(
                              heroTag: 'nextbutton',
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.red,
                              onPressed: () async {
                                index += 1;
                                setState(() {});
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
                          buttonPositionY -= details.delta.dy;
                          buttonPositionY = buttonPositionY.clamp(2.0, 58.0);
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
