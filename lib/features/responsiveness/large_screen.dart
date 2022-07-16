import 'package:betticos/core/presentation/routes/home_router.dart';
import 'package:flutter/material.dart';
import 'left_side_bar.dart';

class HomeBaseScreen extends StatelessWidget {
  const HomeBaseScreen({
    Key? key,
    // required this.child,
  }) : super(key: key);

  // final Widget child;

  RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 5,
          child: LeftSideBar(ctx: context),
        ),
        Expanded(
          flex: 8,
          child: Navigator(
            observers: <NavigatorObserver>[
              HeroController(createRectTween: _createRectTween),
            ],
            onGenerateRoute: onHomeGenerateRoute,
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.white,
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}
