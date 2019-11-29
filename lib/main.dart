import 'package:flutter/material.dart';
import 'appbar.dart';
import 'category_card.dart';
import 'navigation_drawer.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SliverHomeScreen(),
  ));
}

bool fadeTransition = true;

class SliverHomeScreen extends StatefulWidget {
  @override
  _SliverHomeScreenState createState() => _SliverHomeScreenState();
}

class _SliverHomeScreenState extends State<SliverHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          elevation: 5,
          child: NavigationColumn(),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(color: Color(0xFF984FD0)),
            pinned: true,
            backgroundColor: Colors.white,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: CustomAppbar(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              CategoryCard(
                category: 'Inspirational',
                image: 'inspire',
              ),
              CategoryCard(
                category: 'Life',
                image: 'life',
              ),
              CategoryCard(
                category: 'Management',
                image: 'management',
              ),
              CategoryCard(
                category: 'Sports',
                image: 'sports',
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
