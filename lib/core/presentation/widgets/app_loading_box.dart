import 'package:flutter/material.dart';
import '/core/core.dart';

class AppLoadingBox extends StatelessWidget {
  const AppLoadingBox({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.loaderColor,
    this.loaderSize,
    this.loadingProgress,
    this.loading = false,
  }) : super(key: key);

  final Widget child;
  final bool loading;
  final Color? backgroundColor;
  final double? loadingProgress;
  final Color? loaderColor;
  final double? loaderSize;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 1300),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (_, double animationValue, Widget? __) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            child,
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: DecoratedBox(
                  key: ValueKey<bool>(loading),
                  decoration: BoxDecoration(
                    color: backgroundColor ??
                        context.colors.background.withOpacity(.70),
                  ),
                  child: !loading
                      ? const SizedBox()
                      : Stack(
                          children: <Widget>[
                            Center(
                              child: LoadingLogo(
                                progress: loadingProgress,
                                color: loaderColor ?? context.colors.primary,
                                height: loaderSize ?? 30,
                                width: loaderSize ?? 30,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
