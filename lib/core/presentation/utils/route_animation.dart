import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FadeInRoute<T> extends PageRoute<T> {
  FadeInRoute({this.builder, RouteSettings? settings})
      : super(settings: settings);
  final WidgetBuilder? builder;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
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

class NoAnimationRoute<T> extends MaterialPageRoute<T> {
  NoAnimationRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => super.transitionDuration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

class SlideLeftRoute<T> extends CupertinoPageRoute<T> {
  SlideLeftRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1000);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
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

class SlideUpRoute<T> extends CupertinoPageRoute<T> {
  SlideUpRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
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

class NoTransitionHeroAnimationRoute<T> extends MaterialPageRoute<T> {
  NoTransitionHeroAnimationRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    required Duration transitionDuration,
  })  : _transitionDuration = transitionDuration,
        super(builder: builder, settings: settings);

  final Duration _transitionDuration;

  @override
  Duration get transitionDuration => _transitionDuration;
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

class HeroAnimationRoute<T> extends MaterialPageRoute<T> {
  HeroAnimationRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    required Duration duration,
  })  : _duration = duration,
        super(builder: builder, settings: settings);

  final Duration _duration;

  @override
  Duration get transitionDuration => _duration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
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
