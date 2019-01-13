import 'package:flutter/material.dart';
import 'package:navigation/zoom_scaffold.dart';

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

  createMenuItems(MenuController controller) {
    return Transform(
      transform: Matrix4.translationValues(0.0, 225, 0.0),
      child: Column(
        children: <Widget>[
          MenuListItem(
            isSelected: true,
            title: "THE PADDOCK",onTap: (){
              controller.close();
            },
          ),
          MenuListItem(
            isSelected: false,
            title: "THE HERO",onTap: (){
              controller.close();
            },
          ),
          MenuListItem(
            isSelected: false,
            title: "HELP US GROW",onTap: (){
              controller.close();
            },
          ),
          MenuListItem(
            isSelected: false,
            title: "THE PADDOCK",onTap: (){
              controller.close();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ZoomMenuController(builder: (BuildContext context, MenuController menuController) {
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
            children: <Widget>[
              createMenuTitle(),
              createMenuItems(menuController),
            ],
          ),
        ),
      );
    });
  }
}

class MenuListItem extends StatelessWidget {
  final bool isSelected;
  final String title;
  final Function() onTap;

  MenuListItem({this.isSelected, this.title,this.onTap,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Color(0x44000000),
      onTap: isSelected ? null : onTap,
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
