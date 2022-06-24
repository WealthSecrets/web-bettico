import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class MatchAvatar extends StatelessWidget {
  const MatchAvatar({
    Key? key,
    required this.name,
    required this.selected,
    this.disabled,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);
  final String name;
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
          color: Colors.white,
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
        child: CircleAvatar(
          radius: 27.0,
          backgroundColor: selected
              ? backgroundColor?.withOpacity(disabled! ? 0.6 : 1) ??
                  context.colors.primary.withOpacity(disabled! ? 0.6 : 1)
              : context.colors.text,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Text(
              StringUtils.getInitials(name),
              style: context.body2.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
