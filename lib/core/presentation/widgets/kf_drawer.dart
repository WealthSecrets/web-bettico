library kf_drawer;

import 'package:flutter/material.dart';

class KFDrawerController {
  KFDrawerController(
      {this.items = const <KFDrawerItem>[],
      required KFDrawerContent initialPage}) {
    page = initialPage;
  }

  List<KFDrawerItem> items;
  Function? close;
  Function? open;
  KFDrawerContent? page;
}

// ignore: must_be_immutable
class KFDrawerContent extends StatefulWidget {
  KFDrawerContent({Key? key}) : super(key: key);
  VoidCallback? onMenuPressed;

  @override
  State<StatefulWidget> createState() => KFDrawerContentState();
}

class KFDrawerContentState extends State<KFDrawerContent> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class KFDrawer extends StatefulWidget {
  const KFDrawer({
    Key? key,
    this.header,
    this.footer,
    this.items = const <KFDrawerItem>[],
    this.controller,
    this.decoration,
    this.drawerWidth,
    this.minScale,
    this.borderRadius,
    this.shadowBorderRadius,
    this.shadowOffset,
    this.scrollable = true,
    this.menuPadding,
    this.disableContentTap = true,
  }) : super(key: key);

  final Widget? header;
  final Widget? footer;
  final BoxDecoration? decoration;
  final List<KFDrawerItem> items;
  final KFDrawerController? controller;
  final double? drawerWidth;
  final double? minScale;
  final double? borderRadius;
  final double? shadowBorderRadius;
  final double? shadowOffset;
  final bool scrollable;
  final EdgeInsets? menuPadding;
  final bool disableContentTap;

  @override
  _KFDrawerState createState() => _KFDrawerState();
}

class _KFDrawerState extends State<KFDrawer> with TickerProviderStateMixin {
  bool _menuOpened = false;
  bool _isDraggingMenu = false;

  double _drawerWidth = 0.66;
  double _minScale = 0.86;
  double _borderRadius = 32.0;
  double _shadowBorderRadius = 44.0;
  double _shadowOffset = 16.0;
  bool _scrollable = false;
  bool _disableContentTap = true;

  late Animation<double> animation, scaleAnimation;
  late Animation<BorderRadius?> radiusAnimation;
  late AnimationController animationController;

  void _open() {
    animationController.forward();
    setState(() {
      _menuOpened = true;
    });
  }

  void _close() {
    animationController.reverse();
    setState(() {
      _menuOpened = false;
    });
  }

  void _onMenuPressed() {
    _menuOpened ? _close() : _open();
  }

  void _finishDrawerAnimation() {
    if (_isDraggingMenu) {
      bool opened = false;
      setState(() {
        _isDraggingMenu = false;
      });
      if (animationController.value >= 0.4) {
        animationController.forward();
        opened = true;
      } else {
        animationController.reverse();
      }
      setState(() {
        _menuOpened = opened;
      });
    }
  }

  List<KFDrawerItem> _getDrawerItems() {
    if (widget.controller?.items != null) {
      return widget.controller!.items.map((KFDrawerItem item) {
        item.onPressed ??= () {
          widget.controller!.page = item.page;
          if (widget.controller!.close != null) {
            widget.controller!.close!();
          }
        };
        item.page?.onMenuPressed = _onMenuPressed;
        return item;
      }).toList();
    }
    return widget.items;
  }

  @override
  void initState() {
    super.initState();
    if (widget.minScale != null) {
      _minScale = widget.minScale!;
    }
    if (widget.borderRadius != null) {
      _borderRadius = widget.borderRadius!;
    }
    if (widget.shadowOffset != null) {
      _shadowOffset = widget.shadowOffset!;
    }
    if (widget.shadowBorderRadius != null) {
      _shadowBorderRadius = widget.shadowBorderRadius!;
    }
    if (widget.drawerWidth != null) {
      _drawerWidth = widget.drawerWidth!;
    }
    if (widget.scrollable) {
      _scrollable = widget.scrollable;
    }
    if (widget.disableContentTap) {
      _disableContentTap = widget.disableContentTap;
    }
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object???s value.
        });
      });

    scaleAnimation =
        Tween<double>(begin: 1.0, end: _minScale).animate(animationController);
    radiusAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(0.0),
            end: BorderRadius.circular(_borderRadius))
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.ease));
  }

  @override
  Widget build(BuildContext context) {
    widget.controller?.page?.onMenuPressed = _onMenuPressed;
    widget.controller?.close = _close;
    widget.controller?.open = _open;

    return Listener(
      onPointerDown: (PointerDownEvent event) {
        if (_disableContentTap) {
          if (_menuOpened &&
              event.position.dx / MediaQuery.of(context).size.width >=
                  _drawerWidth) {
            _close();
          } else {
            setState(() {
              _isDraggingMenu = (!_menuOpened && event.position.dx <= 8.0);
            });
          }
        } else {
          setState(() {
            _isDraggingMenu = (_menuOpened &&
                    event.position.dx / MediaQuery.of(context).size.width >=
                        _drawerWidth) ||
                (!_menuOpened && event.position.dx <= 8.0);
          });
        }
      },
      onPointerMove: (PointerMoveEvent event) {
        if (_isDraggingMenu) {
          animationController.value =
              event.position.dx / MediaQuery.of(context).size.width;
        }
      },
      onPointerUp: (PointerUpEvent event) {
        _finishDrawerAnimation();
      },
      onPointerCancel: (PointerCancelEvent event) {
        _finishDrawerAnimation();
      },
      child: Stack(
        children: <Widget>[
          _KFDrawer(
            padding: widget.menuPadding,
            scrollable: _scrollable,
            animationController: animationController,
            header: widget.header,
            footer: widget.footer,
            items: _getDrawerItems(),
            decoration: widget.decoration,
          ),
          Transform.scale(
            scale: scaleAnimation.value,
            child: Transform.translate(
              offset: Offset(
                  (MediaQuery.of(context).size.width * _drawerWidth) *
                      animation.value,
                  0.0),
              child: AbsorbPointer(
                absorbing: _menuOpened && _disableContentTap,
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 32.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(_shadowBorderRadius)),
                              child: Container(
                                color: Colors.white.withAlpha(128),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: animation.value * _shadowOffset),
                      child: ClipRRect(
                        borderRadius: radiusAnimation.value,
                        child: Container(
                          color: Colors.white,
                          child: widget.controller?.page,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class _KFDrawer extends StatefulWidget {
  const _KFDrawer({
    Key? key,
    this.animationController,
    this.header,
    this.footer,
    this.items = const <KFDrawerItem>[],
    this.decoration,
    this.scrollable = true,
    this.padding,
  }) : super(key: key);

  final Widget? header;
  final Widget? footer;
  final List<KFDrawerItem> items;
  final BoxDecoration? decoration;
  final bool scrollable;
  final EdgeInsets? padding;

  final Animation<double>? animationController;

  @override
  __KFDrawerState createState() => __KFDrawerState();
}

class __KFDrawerState extends State<_KFDrawer> {
  EdgeInsets _padding = const EdgeInsets.symmetric(vertical: 64.0);

  Widget _getMenu() {
    if (widget.scrollable) {
      return ListView(
        children: <Widget>[
          Container(
            child: widget.header,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.items,
          ),
          if (widget.footer != null) widget.footer!,
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            child: widget.header,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.items,
            ),
          ),
          if (widget.footer != null) widget.footer!,
        ],
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.padding != null) {
      _padding = widget.padding!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      child: Padding(
        padding: _padding,
        child: _getMenu(),
      ),
    );
  }
}

class KFDrawerItem extends StatelessWidget {
  KFDrawerItem({Key? key, this.onPressed, this.text, this.icon})
      : super(key: key);

  KFDrawerItem.initWithPage(
      {Key? key, this.onPressed, this.text, this.icon, this.alias, this.page})
      : super(key: key);

  GestureTapCallback? onPressed;
  Widget? text;
  Widget? icon;

  String? alias;
  KFDrawerContent? page;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  child: icon,
                ),
                if (text != null) text!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
