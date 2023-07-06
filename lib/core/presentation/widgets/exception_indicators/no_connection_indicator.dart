import 'package:betticos/core/core.dart';
import 'package:flutter/cupertino.dart';

class NoConnectionIndicator extends StatelessWidget {
  const NoConnectionIndicator({super.key, this.onTryAgain});

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    return ExceptionIndicator(
      title: 'No connection',
      message: 'Please check internet connection and try again.',
      assetName: AssetImages.frustratedFace,
      onTryAgain: onTryAgain,
    );
  }
}
