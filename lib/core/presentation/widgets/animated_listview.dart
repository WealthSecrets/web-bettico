import 'dart:async';

import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class AppAnimatedListView extends StatefulWidget {
  const AppAnimatedListView({
    AnimationController? animationController,
    // required this.children,
    Key? key,
    this.duration = const Duration(milliseconds: 1000),
    this.delay,
    required this.itemCount,
    required this.item,
    this.padding,
    this.direction = Axis.vertical,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController? _animationController;
  // final List<Widget> children;
  final Duration? duration;
  final Duration? delay;
  final Axis direction;
  final int itemCount;
  final Widget item;
  final EdgeInsetsGeometry? padding;

  @override
  State<AppAnimatedListView> createState() => _AppAnimatedListViewState();
}

class _AppAnimatedListViewState extends State<AppAnimatedListView>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Timer? delay;
  @override
  void initState() {
    _animationController = widget._animationController ??
        AnimationController(
          vsync: this,
          duration: widget.duration ??
              Duration(
                milliseconds: widget.itemCount * 200,
              ),
        );
    if (widget._animationController == null) {
      delay = Timer(widget.delay ?? Duration.zero, () {
        _animationController?.forward();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    delay?.cancel();
    if (widget._animationController == null) {
      _animationController?.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (BuildContext context, Widget? child) {
        return ListView.builder(
          padding: widget.padding ?? AppPaddings.lA,
          itemCount: widget.itemCount,
          itemBuilder: (BuildContext context, int index) {
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(
                CurvedAnimation(
                  curve: Interval(
                    1 / widget.itemCount * index * 0.25,
                    1 / widget.itemCount * index,
                    curve: Curves.easeInOut,
                  ),
                  parent: _animationController!,
                ),
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: widget.direction == Axis.vertical
                      ? Offset(0.0, index == 0 ? 1.5 : .5)
                      : const Offset(.25, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    curve: Interval(
                      index == 0
                          ? 0
                          : 1 / widget.itemCount * (index + 1) * 0.20,
                      index == 0 ? .5 : 1 / widget.itemCount * (index + 1),
                      curve: index == 0
                          ? Curves.fastLinearToSlowEaseIn
                          : Curves.linearToEaseOut,
                    ),
                    parent: _animationController!,
                  ),
                ),
                child: widget.item,
              ),
            );
          },
          // children: <Widget>[
          //   ...List<Widget>.generate(widget.children.length, (int index) {
          //     return FadeTransition(
          //       opacity: Tween<double>(
          //         begin: 0,
          //         end: 1,
          //       ).animate(
          //         CurvedAnimation(
          //           curve: Interval(
          //             1 / widget.children.length * index * 0.25,
          //             1 / widget.children.length * index,
          //             curve: Curves.easeInOut,
          //           ),
          //           parent: _animationController!,
          //         ),
          //       ),
          //       child: SlideTransition(
          //         position: Tween<Offset>(
          //           begin: widget.direction == Axis.vertical
          //               ? Offset(0.0, index == 0 ? 1.5 : .5)
          //               : const Offset(.25, 0.0),
          //           end: Offset.zero,
          //         ).animate(
          //           CurvedAnimation(
          //             curve: Interval(
          //               index == 0
          //                   ? 0
          //                   : 1 / widget.children.length * (index + 1) * 0.20,
          //               index == 0
          //                   ? .5
          //                   : 1 / widget.children.length * (index + 1),
          //               curve: index == 0
          //                   ? Curves.fastLinearToSlowEaseIn
          //                   : Curves.linearToEaseOut,
          //             ),
          //             parent: _animationController!,
          //           ),
          //         ),
          //         child: widget.children[index],
          //       ),
          //     );
          //   })
          // ],
        );
      },
    );
  }
}
