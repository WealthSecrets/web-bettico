import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.imageUrl, this.size, this.headers, this.margin});

  final String imageUrl;
  final double? size;
  final Map<String, String>? headers;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 40,
      width: size ?? 40,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(image: NetworkImage(imageUrl, headers: headers), fit: BoxFit.cover),
      ),
    );
  }
}
