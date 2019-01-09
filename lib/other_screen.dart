import 'package:navigation/zoom_scaffold.dart';
import 'package:flutter/material.dart';

final otherScreen = Screen(
    title: "Other Screen",
    background: DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(const Color(0xCC000000), BlendMode.multiply),
      image: NetworkImage(
        'https://images.pexels.com/photos/172289/pexels-photo-172289.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      ),
    ),
    contentBuilder: (context) {
      return Center(
        child: Container(height: 300,
          child: Card(
            child: Column(
              children: <Widget>[Text("Hello")],
            ),
          ),
        ),
      );
    });
