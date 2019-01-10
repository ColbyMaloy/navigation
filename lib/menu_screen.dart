import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  createMenuTitle() {
    return Transform(
      transform: Matrix4.translationValues(-100, 0.0, 0.0),
      child: OverflowBox(
        maxWidth: double.infinity,
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
            "Menu",
            style: TextStyle(
              color: Color(0xFF444444),
              fontSize: 240,
            ),
            textAlign: TextAlign.left,
            softWrap: false,
          ),
        ),
      ),
    );
  }

  createMenuItems() {
    return Transform(
      transform: Matrix4.translationValues(0.0, 225, 0.0),
      child: Column(
        children: <Widget>[
          MenuListItem(
            isSelected: true,
            title: "THE PADDOCK",
          ),
          MenuListItem(
            isSelected: false,
            title: "THE HERO",
          ),
          MenuListItem(
            isSelected: false,
            title: "HELP US GROW",
          ),
          MenuListItem(
            isSelected: false,
            title: "The PADDOCK",
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://images.unsplash.com/photo-1530482817083-29ae4b92ff15?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[createMenuTitle(), createMenuItems()],
        ),
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  final bool isSelected;
  final String title;

  MenuListItem({this.isSelected, this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Color(0x44000000),
      onTap: isSelected ? null : () {},
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, top: 15, bottom: 15),
          child: Text(
            title,
            style: TextStyle(
                fontFamily: "Anton",
                fontSize: 25,
                letterSpacing: 2.0,
                color: isSelected ? Colors.red : Colors.white),
          ),
        ),
      ),
    );
  }
}
