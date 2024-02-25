import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 5,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: context.colors.primary),
    );
  }
}
