import 'package:betticos/core/core.dart';
import 'package:flutter/cupertino.dart';

class GenericErrorIndicator extends StatelessWidget {
  const GenericErrorIndicator({
    Key? key,
    this.onTryAgain,
  }) : super(key: key);

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => ExceptionIndicator(
        title: 'Something went wrong',
        message: 'The application has encountered an unknown error.\n'
            'Please try again later.',
        assetName: AssetImages.confusedFace,
        onTryAgain: onTryAgain,
      );
}
