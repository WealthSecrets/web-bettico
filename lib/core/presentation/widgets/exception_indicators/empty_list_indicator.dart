import 'package:betticos/core/core.dart';
import 'package:flutter/cupertino.dart';

class EmptyListIndicator extends StatelessWidget {
  const EmptyListIndicator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExceptionIndicator(
      title: 'Nothing found here.',
      message:
          'No post were found. You can add new posts or follow others to see their post.',
      assetName: AssetImages.emptyBox,
    );
  }
}
