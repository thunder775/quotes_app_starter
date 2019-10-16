import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

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

  Future<Map> getQuotes() async {
    Response response = await get('https://favqs.com/api/qotd');
    print(response.body);
    return jsonDecode(response.body);
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
                  child: FloatingActionButton.extended(
                    label: Text('Next'),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    onPressed: () async {
                      Map jsonMap = await getQuotes();
                      setState(() {
                        author = jsonMap['quote']['author'];
                        quote = jsonMap['quote']['body'];
                      });
                    },
                    icon: Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
