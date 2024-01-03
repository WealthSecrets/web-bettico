import 'package:betticos/common/utils/app_assets_images.dart';
import 'package:flutter/cupertino.dart';

import 'exception_indicators.dart';

class GenericErrorIndicator extends StatelessWidget {
  const GenericErrorIndicator({super.key, this.onTryAgain});

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    return ExceptionIndicator(
      title: 'Something went wrong',
      message: 'The application has encountered an unknown error.\n'
          'Please try again later.',
      assetName: AssetImages.confusedFace,
      onTryAgain: onTryAgain,
    );
  }
}
