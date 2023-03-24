import 'package:auto_size_text/auto_size_text.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width - 30,
        decoration: BoxDecoration(
          color: context.colors.lightGrey,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: context.colors.faintGrey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    imagePath,
                    width: 25,
                    height: 25,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: AutoSizeText(
                      title,
                      minFontSize: 14,
                      maxFontSize: 16,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: context.colors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: context.colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
