import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class MatchAvatar extends StatelessWidget {
  const MatchAvatar({
    Key? key,
    this.logo,
    required this.selected,
    this.disabled,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);
  final String? logo;
  final bool selected;
  final bool? disabled;
  final Color? backgroundColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: 60,
        padding: AppPaddings.sA,
        decoration: BoxDecoration(
          border: Border.all(
            color: selected
                ? backgroundColor?.withOpacity(disabled! ? 0.6 : 1) ??
                    context.colors.primary.withOpacity(disabled! ? 0.6 : 1)
                : context.colors.text,
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(30),
          // image: DecorationImage(
          //   image: AssetImage(AssetImages.leicester),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Center(
          child: logo != null
              ? Image.network(
                  logo!,
                  height: 45,
                  width: 45,
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
