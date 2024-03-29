import 'package:flutter/material.dart';
import '/core/core.dart';
import 'generic_error_indicator.dart';
import 'no_connection_indicator.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({super.key, required this.error, this.onTryAgain});

  final Failure error;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => error.message.contains('Internet')
      ? NoConnectionIndicator(onTryAgain: onTryAgain)
      : GenericErrorIndicator(onTryAgain: onTryAgain);
}
