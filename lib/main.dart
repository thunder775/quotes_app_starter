import 'package:flutter/material.dart';
import 'package:quotes_app_starter/test_screen.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
bool fadeTransition = true;
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          elevation: 5,
          child: Container(decoration: BoxDecoration(
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
          )
            ,child: Column(
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
                  children: <Widget>[Icon(Icons.copyright), Text('thunder775',style: TextStyle(fontFamily: 'Ubuntu'),)],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF984FD0),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                        MediaQuery.of(context).size.width * .20),
                    bottomRight: Radius.circular(
                        MediaQuery.of(context).size.width * .20)),
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
                    padding: const EdgeInsets.only(top: 18.0),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width * .70,
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Quotes Of The Day',
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'On Just One Click',
                    style: TextStyle(
                        letterSpacing: 1,
//                          fontWeight: FontWeight.bold,
                        fontSize: 12,
                        fontFamily: 'Ubuntu',
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  String category;

//  String urlCategory;
  String image;

  CategoryCard({this.category, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuotesScreen(
                      tag: category,
                    )));
        print('hey');
      },
      child: Padding(
        padding: const EdgeInsets.only(top:26.0,left: 26,right: 26),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: Container(
              child: Stack(
            children: <Widget>[
              Image(
                image: AssetImage('assets/$image.jpg'),
              ),
              Positioned(
                  bottom: 15,
                  left: 15,
                  child: Container(
                    child: Text(
                      category,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                          fontSize: 32),
                    ),
                  ))
            ],
          )),
        ),
      ),
    );
  }
}
