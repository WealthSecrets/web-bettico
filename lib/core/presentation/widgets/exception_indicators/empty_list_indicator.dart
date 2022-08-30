import 'package:betticos/core/core.dart';
import 'package:flutter/cupertino.dart';

class EmptyListIndicator extends StatelessWidget {
  const EmptyListIndicator({
    Key? key,
    this.title,
    this.message,
    this.size,
    this.gap,
    this.spacing,
  }) : super(key: key);

  final String? title;
  final String? message;
  final double? size;
  final double? gap;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return ExceptionIndicator(
      title: title ?? 'Nothing found here.',
      message: message ??
          'No post were found. You can add new posts or follow others to see their post.',
      assetName: AssetImages.emptyBox,
      size: size,
      gap: gap,
      spacing: spacing,
    );
  }
}
