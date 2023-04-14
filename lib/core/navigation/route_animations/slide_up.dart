import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart';

class SlideUpRoute<T> extends CupertinoPageRoute<T> {
  SlideUpRoute({required super.builder, super.settings});

  @override
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
          opacity: Tween<double>(begin: 0.7, end: 1).animate(
            CurvedAnimation(curve: Curves.ease, parent: animation),
          ),
          child: SlideTransition(
            position:
                Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
                    .animate(
              CurvedAnimation(curve: Curves.linearToEaseOut, parent: animation),
            ),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
