import 'package:flutter/material.dart';
import 'package:navigation/menu_screen.dart';
import 'package:navigation/other_screen.dart';
import 'package:navigation/restaurant_screen.dart';
import 'package:navigation/zoom_scaffold.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var activeScreen = restaurantScreen;

  @override
  Widget build(BuildContext context) {
    return ZoomScaffold(
      menuScreen: MenuScreen(),
      contentScreen: activeScreen,
    );
  }
}
