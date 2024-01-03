import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.color,
    this.textColor,
    this.padding,
    this.fontSize,
    this.selected = false,
    this.tagValue,
  });

  final String text;
  final String? tagValue;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final bool selected;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          color: color ??
              (selected
                  ? context.colors.primary.withOpacity(disabled ? 0 : 0.6)
                  : Colors.white.withOpacity(disabled ? 0 : 0.6)),
          borderRadius: BorderRadius.circular(50),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black12, blurRadius: 5.0, offset: Offset(0, 3), spreadRadius: 2)
          ],
        ),
        child: Row(
          children: <Widget>[
            Text(
              text,
              textScaleFactor: 1.0,
              style: TextStyle(
                fontSize: fontSize ?? 10,
                color: textColor ?? (selected ? Colors.white : const Color(0xFF4A4B65)),
                fontWeight: FontWeight.w800,
              ),
            ),
            if (tagValue != null) const SizedBox(width: 16),
            if (tagValue != null)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: selected ? Colors.white : context.colors.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
                  child: Text(
                    tagValue!,
                    style: TextStyle(fontSize: 12, color: selected ? context.colors.primary : Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
