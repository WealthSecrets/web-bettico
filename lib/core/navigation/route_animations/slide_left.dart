import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart';

class SlideLeftRoute<T> extends CupertinoPageRoute<T> {
  SlideLeftRoute({required super.builder, super.settings});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1000);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.8, end: 1).animate(
            CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn, parent: animation),
          ),
          child: SlideTransition(
            position:
                Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                    .animate(
              CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastLinearToSlowEaseIn.flipped,
              ),
            ),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
