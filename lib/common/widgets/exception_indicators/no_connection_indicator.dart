import 'package:betticos/common/utils/app_assets_images.dart';
import 'package:flutter/cupertino.dart';

import 'exception_indicator.dart';

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
