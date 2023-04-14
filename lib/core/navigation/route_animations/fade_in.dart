import 'package:flutter/material.dart';

class FadeInRoute<T> extends PageRoute<T> {
  FadeInRoute({this.builder, super.settings});

  final WidgetBuilder? builder;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final Animation<double> opacity =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    return FadeTransition(opacity: opacity, child: child);
  }

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String get barrierLabel => 'FadeInRoute';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder!(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);
}
