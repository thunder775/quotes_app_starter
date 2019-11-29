
import 'package:flutter/material.dart';
import 'package:quotes_app_starter/quotes_screen.dart';

// ignore: must_be_immutable
class CategoryCard extends StatelessWidget {
  String category;
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
        padding: const EdgeInsets.only(top: 26.0, left: 26, right: 26),
        child: Stack(
          children: <Widget>[
            ClipRRect(borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                height: 180,
                width: MediaQuery.of(context).size.width * .9,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/$image.jpg'),
                ),
              ),
            ),
            Positioned(
                bottom: 15,
                left: 15,
                child: Text(
                  category,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Ubuntu', fontSize: 32),
                ))
          ],
        ),
      ),
    );
  }
}
