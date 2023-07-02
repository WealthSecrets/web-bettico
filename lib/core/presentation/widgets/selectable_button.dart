import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class SelectableButton extends StatelessWidget {
  const SelectableButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.color,
      this.textColor,
      this.constraints,
      this.fontSize,
      this.selected,
      this.tagValue})
      : super(key: key);

  final String text;
  final String? tagValue;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final BoxConstraints? constraints;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints ?? const BoxConstraints(maxHeight: 45, minWidth: 100),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: color ?? (selected ?? false ? context.colors.primary : const Color(0xFFD7D7D7)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: tagValue == null ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
              child: Text(
                text,
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: fontSize ?? 10,
                  color: textColor ?? (selected ?? false ? Colors.white : const Color(0xFF4A4B65)),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (tagValue != null) const SizedBox(width: 16),
            if (tagValue != null)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: selected ?? false ? Colors.white : context.colors.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
                  child: Text(
                    tagValue!,
                    style: TextStyle(fontSize: 12, color: selected ?? false ? context.colors.primary : Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
