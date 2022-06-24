import 'package:flutter/material.dart';
import '/core/core.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    required this.error,
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final Failure error;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => error.message.contains('Internet')
      ? NoConnectionIndicator(
          onTryAgain: onTryAgain,
        )
      : GenericErrorIndicator(
          onTryAgain: onTryAgain,
        );
}
