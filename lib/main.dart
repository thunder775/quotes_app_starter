import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes_app_starter/test_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TestScreen(),
  ));
}

class QuotesPage extends StatefulWidget {
  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  String quote;
  String author;
  bool loading = false;

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
      author = jsonMap['quote']['author'];
      quote = jsonMap['quote']['body'];
    });
  }

  @override
  void initState() {
    super.initState();
    updateQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            //wire container------------------------------
            right: 29,
            top: 0,
            child: Container(
              height: 172,
              width: 4,
              color: Colors.white,
            ),
          ),
          Positioned(
            // socket container--------------------------
            right: 20,
            top: 170,
            child: Container(
              height: 80,
              width: 22,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.2),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
          Positioned(
            // switch container----------------------------
            right: 21,
            top: 172,
            child: GestureDetector(
              onTap: () {
                print('hey');
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
          SingleChildScrollView(
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, bottom: 16, top: 100, right: 40),
                    child: Text(
                      '$quote',
                      style: TextStyle(
                        fontSize: 33,
                        fontFamily: 'DancingScript',
                      ),
                    ),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
