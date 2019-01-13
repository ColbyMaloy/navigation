import 'package:flutter/material.dart';
import 'package:navigation/menu_screen.dart';

class ZoomScaffold extends StatefulWidget {
  final Screen contentScreen;
  final Widget menuScreen;

  ZoomScaffold({this.contentScreen, this.menuScreen});
  @override
  _ZoomScaffoldState createState() => _ZoomScaffoldState();
}

class _ZoomScaffoldState extends State<ZoomScaffold>
    with TickerProviderStateMixin {
  MenuController menuController;

  Curve scaleDownCurve = Interval(0.0, 0.25, curve: Curves.easeOut);
  Curve scaleUpCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = Interval(0.0, 1.0, curve: Curves.easeOut);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuController = MenuController(vsync: this)
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
    var slidePercent, scalePercent;

    switch (menuController.state) {
      case MenuState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.closing:
        slidePercent = slideInCurve.transform(menuController.percentOpen);
        scalePercent = scaleUpCurve.transform(menuController.percentOpen);
        break;
      case MenuState.open:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(menuController.percentOpen);
        scalePercent = scaleDownCurve.transform(menuController.percentOpen);
        break;
    }

    final slideAmount = 275 * slidePercent;

    final contentScale = 1 - (.2 * scalePercent);

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
  final TickerProvider vsync;
  final AnimationController controller;
  MenuState state = MenuState.closed;

  MenuController({
    this.vsync,
  }) : controller = AnimationController(
          vsync: vsync,
        ) {
    controller
      ..duration = const Duration(milliseconds: 1000)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.completed:
            state = MenuState.open;
            break;
          case AnimationStatus.dismissed:
            state = MenuState.closed;
            break;
          case AnimationStatus.forward:
            state = MenuState.opening;
            break;
          case AnimationStatus.reverse:
            state = MenuState.closing;
            break;
        }
        notifyListeners();
      });
  }

  @override
  dispose() {
    super.dispose();
    controller.dispose();
  }

  get percentOpen {
    return controller.value;
  }

  open() {
    controller.forward();
  }

  close() {
    controller.reverse();
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
