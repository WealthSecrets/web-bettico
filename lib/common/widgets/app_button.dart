import 'package:betticos/common/utils/utils.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    this.loading = false,
    this.enabled = true,
    this.hasShadow = false,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.spinnerColor,
    this.boxShadow,
    this.padding,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? spinnerColor;
  final List<BoxShadow>? boxShadow;
  final bool loading;
  final bool enabled;
  final bool hasShadow;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.button,
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(12)),
        child: SizedBox(
          height: 56,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              if (widget.hasShadow)
                DecoratedBox(
                  decoration: BoxDecoration(
                    boxShadow: widget.boxShadow ??
                        <BoxShadow>[
                          BoxShadow(
                            blurRadius: 20,
                            spreadRadius: 4,
                            color: context.colors.primary.shade200,
                          )
                        ],
                  ),
                  child: const SizedBox(
                    height: 10,
                    width: 200,
                  ),
                ),
              SizedBox.expand(
                child: CupertinoButton(
                  padding: widget.padding,
                  borderRadius: widget.borderRadius ?? AppBorderRadius.button,
                  onPressed: widget.loading ? null : widget.onPressed,
                  color: widget.backgroundColor ?? context.colors.primary,
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: context.button.copyWith(color: widget.foregroundColor ?? Colors.white),
                    child: widget.child,
                  ),
                ),
              ),
              IgnorePointer(
                ignoring: widget.enabled,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.center,
                  height: kToolbarHeight,
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: widget.borderRadius ?? AppBorderRadius.button,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft.add(const Alignment(.4, 0)),
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        context.colors.background.withOpacity(widget.enabled ? 0.0 : 0.6),
                        context.colors.background.withOpacity(widget.enabled ? 0.0 : 0.6),
                        context.colors.background.withOpacity(widget.enabled ? 0.0 : 0.6),
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: widget.borderRadius ?? AppBorderRadius.button,
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppConstrainedButton extends StatelessWidget {
  const AppConstrainedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.constraints,
    this.fontSize,
    this.selected = false,
    this.disabled = false,
    this.borderRadius,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final BoxConstraints? constraints;
  final bool selected;
  final BorderRadius? borderRadius;
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints ?? const BoxConstraints(maxHeight: 25, minWidth: 80),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: AppPaddings.sV,
          backgroundColor: selected ? color?.withOpacity(disabled! ? 0.6 : 1) ?? Colors.white : null,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? AppBorderRadius.smallAll,
            side: selected ? BorderSide.none : BorderSide(color: color ?? Colors.white),
          ),
        ),
        onPressed: () {
          if (!disabled!) {
            onPressed();
          }
        },
        child: Text(
          text,
          textScaleFactor: 1.0,
          style: TextStyle(
            fontSize: fontSize ?? 10,
            color: selected ? textColor ?? context.colors.textDark : color,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
