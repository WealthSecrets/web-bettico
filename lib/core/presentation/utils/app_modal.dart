import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import '/core/core.dart';

Future<T?> showAppModal<T>({
  required BuildContext context,
  required Widget Function(BuildContext context) builder,
  double? height,
  double? width,
  bool dismissible = true,
  bool blur = false,
  bool root = true,
  EdgeInsets? padding,
  BoxConstraints? constraints,
  List<BoxShadow>? boxShadow,
  Color backgroundColor = Colors.black45,
  bool barrierDismissible = true,
  Alignment? alignment,
  Duration? duration,
  ColorFilter? colorFilter,
}) async {
  return Navigator.of(context, rootNavigator: root).push(
    _CupertinoModalPopupRoute<T>(
      builder: builder,
      alignment: alignment,
      backgroundColor: backgroundColor,
      blur: blur,
      duration: duration,
      barrierDismissible: barrierDismissible,
      colorFilter: colorFilter,
    ),
  );
}

class _CupertinoModalPopupRoute<T> extends PopupRoute<T> {
  _CupertinoModalPopupRoute({
    required this.builder,
    this.blur = false,
    this.backgroundColor,
    this.colorFilter,
    this.duration,
    this.alignment,
    RouteSettings? settings,
    bool? barrierDismissible,
  })  : _barrierDismissible = barrierDismissible ?? false,
        super(settings: settings);

  final WidgetBuilder builder;
  final bool _barrierDismissible;
  final bool blur;
  final Color? backgroundColor;
  final ColorFilter? colorFilter;
  final Alignment? alignment;
  final Duration? duration;

  @override
  Color get barrierColor => backgroundColor ?? Colors.black45;

  @override
  bool get barrierDismissible => _barrierDismissible;

  @override
  bool get semanticsDismissible => false;

  @override
  Duration get transitionDuration => duration ?? const Duration(milliseconds: 1000);

  @override
  String? get barrierLabel => '';

  late final Animation<double> _animation;

  @override
  Animation<double> createAnimation() {
    return _animation = CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastLinearToSlowEaseIn.flipped,
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (barrierDismissible && _animation.isCompleted) {
              Navigator.pop(context);
            }
          },
          child: FadeTransition(
            opacity: animation,
            child: ColorFiltered(
              colorFilter: colorFilter ?? const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
              child: const Material(
                color: Colors.transparent,
                child: SizedBox.expand(),
              ),
            ),
          ),
        ),
        if (blur)
          AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, _) {
              return BlurredBox(
                backgroundColor: Colors.transparent,
                sigmaX: blur ? animation.value * 7 : 0.0,
                sigmaY: blur ? animation.value * 7 : 0.0,
              );
            },
          ),
        Align(
          alignment: alignment ?? Alignment.bottomCenter,
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: _animation.status == AnimationStatus.reverse ? 0.0 : 1.0,
            ).animate(
              CurvedAnimation(
                curve: const Interval(
                  .4,
                  1.0,
                  curve: Curves.fastLinearToSlowEaseIn,
                ),
                parent: _animation,
              ),
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, .9),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  curve: Interval(
                    .0,
                    1.0,
                    curve: _animation.status == AnimationStatus.reverse ? Curves.bounceIn.flipped : Curves.bounceIn,
                  ),
                  parent: _animation,
                ),
              ),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

class AppDialogueModal extends StatelessWidget {
  const AppDialogueModal({
    Key? key,
    required this.icon,
    required this.title,
    required this.buttonText,
    required this.onDismissed,
    required this.description,
  }) : super(key: key);

  final Widget icon;
  final Widget title;
  final String buttonText;
  final String description;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppPaddings.lA,
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: AppBorderRadius.smallAll,
      ),
      padding: AppPaddings.homeA,
      child: AppAnimatedColumn(
        delay: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 1000),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          icon,
          const AppSpacing(v: 20),
          title,
          const AppSpacing(v: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.colors.text,
              fontSize: 14,
            ),
          ),
          const AppSpacing(v: 20),
          AppButton(
            onPressed: () {
              onDismissed();
              Navigator.of(context).pop();
            },
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AppOptionDialogueModal extends StatelessWidget {
  const AppOptionDialogueModal({
    Key? key,
    required this.modalContext,
    this.onPressed,
    required this.title,
    required this.message,
    required this.affirmButtonText,
    this.iconData,
    this.backgroundColor,
  }) : super(key: key);

  final BuildContext modalContext;
  final Function()? onPressed;
  final String title;
  final String message;
  final String affirmButtonText;
  final IconData? iconData;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Container(
          margin: AppPaddings.lA,
          decoration: BoxDecoration(
            color: context.colors.background,
            borderRadius: AppBorderRadius.largeAll,
          ),
          padding: AppPaddings.lA,
          child: AppAnimatedColumn(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 1000),
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const AppSpacing(v: 10),
              Container(
                padding: AppPaddings.lA,
                decoration: BoxDecoration(
                  color: backgroundColor ?? context.colors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData ?? Ionicons.trash_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const AppSpacing(v: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const AppSpacing(v: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const AppSpacing(v: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(modalContext).pop(false);
                      },
                      child: Text(
                        'cancel'.tr.toUpperCase(),
                        style: TextStyle(
                          color: context.colors.text,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const AppSpacing(h: 20),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: const Size.fromHeight(55),
                        backgroundColor: backgroundColor ?? context.colors.primary,
                      ),
                      onPressed: onPressed,
                      child: Text(
                        affirmButtonText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class AppTextDailogModal extends StatelessWidget {
  const AppTextDailogModal({
    Key? key,
    required this.modalContext,
    this.onAffrimButtonPressed,
    required this.title,
    required this.onChanged,
    this.onCancelledPressed,
    this.controller,
    required this.affirmButtonText,
    this.iconData,
    this.backgroundColor,
  }) : super(key: key);

  final BuildContext modalContext;
  final Function()? onAffrimButtonPressed;
  final Function(String) onChanged;
  final Function()? onCancelledPressed;
  final TextEditingController? controller;
  final String affirmButtonText;
  final String title;
  final IconData? iconData;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppPaddings.lA,
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: AppBorderRadius.largeAll,
      ),
      padding: AppPaddings.lA,
      child: AppAnimatedColumn(
        delay: const Duration(milliseconds: 100),
        duration: const Duration(milliseconds: 1000),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const AppSpacing(v: 10),
          Container(
            padding: AppPaddings.lA,
            decoration: BoxDecoration(
              color: backgroundColor ?? context.colors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData ?? Ionicons.football,
              color: Colors.white,
              size: 20,
            ),
          ),
          const AppSpacing(v: 20),
          Material(
            child: AppTextInput(
              controller: controller,
              disabled: false,
              labelText: title,
              backgroundColor: context.colors.primary.shade100,
              lableStyle: TextStyle(
                color: context.colors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
              onChanged: onChanged,
              validator: (String string) => null,
            ),
          ),
          const AppSpacing(v: 20),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: onCancelledPressed,
                  child: Text(
                    'cancel'.tr.toUpperCase(),
                    style: TextStyle(
                      color: context.colors.text,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const AppSpacing(h: 20),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(55),
                    backgroundColor: backgroundColor ?? context.colors.primary,
                  ),
                  onPressed: onAffrimButtonPressed,
                  child: Text(
                    affirmButtonText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
