import 'package:flutter/material.dart';
import 'package:navigation/menu_screen.dart';
import 'package:navigation/other_screen.dart';
import 'package:navigation/restaurant_screen.dart';

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
  

  createContentDisplay() {
    return Container(
      decoration: BoxDecoration(
        image: activeScreen.background,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            activeScreen.title,
            style: TextStyle(fontSize: 25, fontFamily: "Anton"),
          ),
          centerTitle: true,
        ),
        body: activeScreen.contentBuilder(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MenuScreen()
        //createContentDisplay(),
      ],
    );
  }
}
