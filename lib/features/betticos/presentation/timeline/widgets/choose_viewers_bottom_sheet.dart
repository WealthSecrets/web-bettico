import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionsBottomSheet extends StatelessWidget {
  OptionsBottomSheet({super.key, this.options = const <OptionArgument>[], required this.title, this.color, this.size});
  final List<OptionArgument> options;
  final String title;
  final Color? color;
  final double? size;
  final BaseScreenController controller = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: AppPaddings.lA,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Image.asset(AppAssetIcons.closeFrame, height: 32, width: 32),
                ),
                const SizedBox(width: 100),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.2),
                ),
              ],
            ),
          ),
          ...options.map(
            (OptionArgument arg) => _InkWellButton(
              icon: arg.icon,
              text: arg.title,
              onTap: arg.onPressed,
              color: color,
              size: size,
            ),
          ),
        ],
      ),
    );
  }
}

class _InkWellButton extends StatelessWidget {
  const _InkWellButton({required this.icon, required this.text, required this.onTap, this.color, this.size});

  final String icon;
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppPaddings.lA,
        child: Row(
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(color: const Color(0xFFF5F0FF), borderRadius: AppBorderRadius.largeAll),
              child: Center(child: Image.asset(icon, height: size ?? 24, width: size ?? 24, color: color)),
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: context.colors.textInputText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
