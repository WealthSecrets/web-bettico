import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class AnimatedButton extends StatelessWidget {
  const AnimatedButton({
    super.key,
    required this.count,
    required this.isLiked,
    required this.iconOutline,
    required this.iconSolid,
    this.onTap,
    this.isDislikeButton = false,
  });

  final int count;
  final bool isLiked;
  final String iconOutline;
  final String iconSolid;
  final Function()? onTap;
  final bool isDislikeButton;

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: 15,
      circleColor: CircleColor(
        start: isDislikeButton ? const Color(0xFFFF2626) : const Color(0xFFFDB811),
        end: isDislikeButton ? const Color(0xFFBD1616) : const Color(0xFFFCAF0E),
      ),
      bubblesColor: isDislikeButton
          ? const BubblesColor(dotPrimaryColor: Color(0xFFFF2626), dotSecondaryColor: Color(0xFFBD1616))
          : const BubblesColor(
              dotPrimaryColor: Color(0xFFFCA70B),
              dotSecondaryColor: Color(0xFFFC9906),
            ),
      likeBuilder: (bool isLiked) => Image.asset(
        isLiked ? iconSolid : iconOutline,
        color: isLiked ? (isDislikeButton ? context.colors.error : context.colors.primary) : context.colors.icon,
        height: 15,
        width: 15,
      ),
      likeCount: count,
      isLiked: isLiked,
      countBuilder: (int? c, bool value, String text) {
        return Text(
          '$c',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: context.colors.text),
        );
      },
      onTap: (bool isLiked) async {
        onTap?.call();
        return !isLiked;
      },
    );
  }
}
