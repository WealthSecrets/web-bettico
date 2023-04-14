import 'package:flutter/material.dart';

class NoTransitionHeroAnimationRoute<T> extends MaterialPageRoute<T> {
  NoTransitionHeroAnimationRoute({
    required super.builder,
    super.settings,
    required Duration transitionDuration,
  }) : _transitionDuration = transitionDuration;

  final Duration _transitionDuration;

  @override
  Duration get transitionDuration => _transitionDuration;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
