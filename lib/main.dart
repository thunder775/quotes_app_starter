import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MaterialApp(
    home: QuotesPage(),
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 16),
              child: Text(
                '${quote}',
                style: TextStyle(fontFamily: 'DancingScript', fontSize: 40),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 8),
              child: Text(
                '${author}',
                style: TextStyle(
                    fontFamily: 'DancingScript',
                    color: Colors.red,
                    fontSize: 25),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                      onPressed: () async {
                        await updateQuotes();
                      },
                      child: loading
                          ? SpinKitCircle(
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
    );
  }
}
