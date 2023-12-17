import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.imageUrl, this.size, this.headers, this.margin, this.onPressed});

  final String imageUrl;
  final double? size;
  final Map<String, String>? headers;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size ?? 40,
        width: size ?? 40,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(image: NetworkImage(imageUrl, headers: headers), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
