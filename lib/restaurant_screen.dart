
import 'package:flutter/material.dart';
import 'package:navigation/zoom_scaffold.dart';

final Screen restaurantScreen = Screen(
    title: "THE PALEO PADDOCK ",
    background: DecorationImage(
        image: AssetImage("assets/woodebg.jpg"), fit: BoxFit.cover),
    contentBuilder: (context) {
      return ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          RestaurantCard(
            headerImage:
                "https://cdn.jamieoliver.com/home/wp-content/uploads/2016/06/2.jpg",
          ),
          RestaurantCard(
            headerImage:
                "https://cdn.jamieoliver.com/home/wp-content/uploads/2016/06/2.jpg",
          ),
          RestaurantCard(
            headerImage:
                "https://cdn.jamieoliver.com/home/wp-content/uploads/2016/06/2.jpg",
          ),
        ],
      );
    });

class RestaurantCard extends StatelessWidget {
  final String headerImage;
  final IconData icon;
  final String title;
  final String subTitle;
  final int heartCount;

  RestaurantCard(
      {this.headerImage,
      this.icon,
      this.title,
      this.subTitle,
      this.heartCount});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Column(
        children: <Widget>[
          Image.network(
            headerImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 150.0,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Icon(
                    Icons.fastfood,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "il domacca",
                      style: TextStyle(fontSize: 25.0),
                    ),
                    Text(
                      "78 5TH AVENUE, NEW YORK",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Anton",
                        letterSpacing: 1.0,
                        color: const Color(0xFFAAAAAA),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 2.0,
                height: 70.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.white, Color(0xFFAAAAAA)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                    Text("34"),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
