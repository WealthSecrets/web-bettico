import 'package:flutter/material.dart';

class HeroAnimationRoute<T> extends MaterialPageRoute<T> {
  HeroAnimationRoute({
    required super.builder,
    super.settings,
    required Duration duration,
  }) : _duration = duration;

  final Duration _duration;

  @override
  Duration get transitionDuration => _duration;

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
        reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );
    return FadeTransition(opacity: opacity, child: child);
  }
}
