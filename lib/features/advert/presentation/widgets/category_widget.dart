import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    this.onPressed,
    this.constraints,
    this.isSelected = false,
    required this.category,
  });

  final VoidCallback? onPressed;
  final BoxConstraints? constraints;
  final bool isSelected;
  final String category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints consts) {
          final double minWidth = (consts.maxWidth / 3) - 8;
          return ConstrainedBox(
            constraints: constraints ?? const BoxConstraints(maxHeight: 65),
            child: Container(
              padding: const EdgeInsets.all(8),
              width: minWidth,
              decoration: BoxDecoration(
                border: isSelected ? null : Border.all(color: Colors.grey.shade200),
                borderRadius: AppBorderRadius.smallAll,
                color: isSelected ? context.colors.primary : Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    category,
                    style: context.caption.copyWith(
                      color: isSelected ? Colors.white : context.colors.primary,
                    ),
                  ),
                  if (isSelected) ...<Widget>[
                    const Spacer(),
                    Icon(Icons.check_sharp, color: Colors.white, size: 16.h),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
