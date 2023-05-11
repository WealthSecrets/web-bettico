import 'package:flutter/material.dart';
import '/core/core.dart';

class AppCheckBox extends StatefulWidget {
  const AppCheckBox({
    Key? key,
    this.lableText,
    this.value = false,
    this.checkBoxMargin,
    required this.onChanged,
    this.borderRadius,
    this.height = 25,
  }) : super(key: key);
  final String? lableText;
  final bool value;
  final double height;
  final EdgeInsetsGeometry? checkBoxMargin;
  final Function(bool) onChanged;
  final BorderRadius? borderRadius;

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.lableText != null)
            Text(
              widget.lableText!,
              textAlign: TextAlign.left,
              style: context.overline.copyWith(
                color: context.colors.text,
                fontWeight: FontWeight.w700,
              ),
            ),
          if (widget.lableText != null) const AppSpacing(v: 8),
          Container(
            height: widget.height,
            width: widget.height,
            margin: widget.checkBoxMargin,
            padding: EdgeInsets.all(widget.height / 6),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset.zero,
                  color: context.colors.hintLight.withOpacity(.2),
                ),
              ],
              borderRadius: widget.borderRadius ?? AppBorderRadius.button,
              border: Border.all(width: 1.0, color: context.colors.hintLight),
              color: context.colors.background,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              reverseDuration: const Duration(milliseconds: 400),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final Animation<double> scale =
                    Tween<double>(begin: 0.0, end: 1.0).animate(animation);
                return ScaleTransition(
                  scale: scale,
                  child: child,
                );
              },
              switchInCurve: Curves.elasticOut,
              switchOutCurve: Curves.elasticIn,
              child: !widget.value
                  ? const SizedBox()
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                        color: context.colors.primary,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
