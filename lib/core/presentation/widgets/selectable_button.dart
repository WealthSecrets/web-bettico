import 'package:flutter/material.dart';

class SelectableButton extends StatelessWidget {
  const SelectableButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.constraints,
    this.fontSize,
    this.selected,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final BoxConstraints? constraints;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          constraints ?? const BoxConstraints(maxHeight: 45, minWidth: 100),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: color ??
              (selected ?? false
                  ? const Color(0xFFFCAF0E)
                  : const Color(0xFFD7D7D7)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          textScaleFactor: 1.0,
          style: TextStyle(
            fontSize: fontSize ?? 10,
            color: textColor ??
                (selected ?? false ? Colors.white : const Color(0xFF4A4B65)),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
