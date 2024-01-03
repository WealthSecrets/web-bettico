import 'package:auto_size_text/auto_size_text.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required this.title,
    this.imagePath,
    this.subtitle,
    this.trailingText,
    this.onPressed,
    this.onCopy,
    this.backgroundColor,
    this.padding,
    this.size,
    this.iconColor,
  });

  final VoidCallback? onPressed;
  final VoidCallback? onCopy;
  final String? imagePath;
  final String title;
  final String? subtitle;
  final String? trailingText;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? size;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 62,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.colors.faintGrey),
        ),
        child: Row(
          children: <Widget>[
            if (imagePath != null) ...<Widget>[
              const SizedBox(width: 8),
              Image.asset(
                imagePath!,
                height: size ?? 26,
                color: context.colors.primary,
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.colors.textDark,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                  ),
                  AutoSizeText(
                    '${trailingText != null ? '$trailingText | ' : ''}${subtitle ?? ''}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: context.colors.text,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (onCopy != null)
              IconButton(
                onPressed: onCopy,
                icon: Image.asset(
                  AssetImages.copyFile,
                  height: 24,
                  width: 24,
                  color: const Color(0xFF999999),
                ),
              )
            else
              Icon(
                Ionicons.chevron_forward_sharp,
                size: 24,
                color: context.colors.faintGrey,
              )
          ],
        ),
      ),
    );
  }
}
