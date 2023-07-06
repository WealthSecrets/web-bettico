import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class Notice extends StatelessWidget {
  const Notice({super.key, required this.message, this.backgroundColor, this.textColor});

  final String message;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: backgroundColor ?? context.colors.primary.shade100),
      child: Text(
        message,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: textColor ?? context.colors.primary),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
