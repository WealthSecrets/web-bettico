import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullImage extends StatelessWidget {
  const FullImage({super.key, required this.image});

  final Uint8List image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(child: Hero(tag: 'imageHero', child: Center(child: Image.memory(image, fit: BoxFit.cover)))),
      ),
    );
  }
}
