import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/core/core.dart';

class LoadingLogo extends StatefulWidget {
  const LoadingLogo({
    Key? key,
    this.color,
    this.width = 30,
    this.height = 30,
    this.padding,
    this.progress,
  }) : super(key: key);

  final Color? color;
  final double width;
  final double height;
  final double? progress;
  final EdgeInsets? padding;

  @override
  _LoadingLogoState createState() => _LoadingLogoState();
}

class _LoadingLogoState extends State<LoadingLogo>
    with TickerProviderStateMixin {
  late AnimationController controller;
  Animation<double>? rotate;
  late Animation<double> scale;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    rotate = Tween<double>(begin: 360.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    scale = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Curves.fastLinearToSlowEaseIn));
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.primary.shade400.withOpacity(.04),
          shape: BoxShape.circle,
        ),
        height: widget.height,
        width: widget.height,
        child: FittedBox(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SvgPicture.asset(
                AssetSVGs.logo.path,
                height: 15,
                color: widget.color ?? context.colors.primary,
              ),
              FutureBuilder<bool>(
                  future: Future<bool>.delayed(
                      const Duration(milliseconds: 100), () => true),
                  builder: (_, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 28,
                        width: 28,
                        child: CircularProgressIndicator(
                          strokeWidth: .7,
                          value: widget.progress,
                          valueColor: AlwaysStoppedAnimation<Color?>(
                              widget.color ?? PrimaryColor.color),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
              FutureBuilder<bool>(
                future: Future<bool>.delayed(
                    const Duration(milliseconds: 200), () => true),
                builder: (_, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 26,
                      width: 26,
                      child: CircularProgressIndicator(
                        strokeWidth: .7,
                        value: widget.progress,
                        valueColor: AlwaysStoppedAnimation<Color?>(
                            (widget.color ?? PrimaryColor.color)
                                .withOpacity(.5)),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: .7,
                  value: widget.progress,
                  valueColor: AlwaysStoppedAnimation<Color?>(
                      (widget.color ?? PrimaryColor.color).withOpacity(.2)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
