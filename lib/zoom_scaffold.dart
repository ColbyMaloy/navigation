import 'package:flutter/material.dart';
import 'package:navigation/menu_screen.dart';

class ZoomScaffold extends StatefulWidget {
  final Screen contentScreen;
  final Widget menuScreen;

  ZoomScaffold({this.contentScreen, this.menuScreen});
  @override
  _ZoomScaffoldState createState() => _ZoomScaffoldState();
}

class _ZoomScaffoldState extends State<ZoomScaffold> {
  MenuController menuController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuController = MenuController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    menuController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.menuScreen,
        createContentDisplay(),
      ],
    );
  }

  createContentDisplay() {
    return zoomAndSlide(Container(
      decoration: BoxDecoration(
        image: widget.contentScreen.background,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              menuController.toggle();
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            widget.contentScreen.title,
            style: TextStyle(fontSize: 25, fontFamily: "Anton"),
          ),
          centerTitle: true,
        ),
        body: widget.contentScreen.contentBuilder(context),
      ),
    ));
  }

  zoomAndSlide(Widget content) {
    final slideAmount = 275 * menuController.percentOpen;

    final contentScale = 1 - (.2 * menuController.percentOpen);

    final cornerRadius = 10 * menuController.percentOpen;

    return Transform(
      transform: Matrix4.translationValues(slideAmount, 0, 0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: const Color(0x44000000),
              offset: Offset(0.0, 5),
              blurRadius: 20,
              spreadRadius: 10)
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(cornerRadius),
          child: content,
        ),
      ),
    );
  }
}

class ZoomMenuController extends StatelessWidget {
  final ZoomScaffoldBuilder builder;

  const ZoomMenuController({this.builder});

  getMenuController(BuildContext context) {
    final scaffoldState =
        context.ancestorStateOfType(TypeMatcher<_ZoomScaffoldState>())
            as _ZoomScaffoldState;

    return scaffoldState.menuController;
  }

  @override
  Widget build(BuildContext context) {
    return builder(context, getMenuController(context));
  }
}

typedef Widget ZoomScaffoldBuilder(
  BuildContext context,
  MenuController controller,
);

class Screen {
  final String title;
  final DecorationImage background;
  final WidgetBuilder contentBuilder;

  Screen({
    this.title,
    this.background,
    this.contentBuilder,
  });
}

class MenuController extends ChangeNotifier {
  MenuState state = MenuState.closed;
  double percentOpen = 0.0;

  open() {
    state = MenuState.open;
    percentOpen = 1.0;
    notifyListeners();
  }

  close() {
    state = MenuState.closed;
    percentOpen = 0.0;
    notifyListeners();
  }

  toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }
}

enum MenuState { open, closed, opening, closing }
