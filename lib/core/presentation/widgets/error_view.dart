import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'You are viewing an error.',
            style: theme.titleLarge!.copyWith(height: 1.5),
          ),
          TextSpan(text: '  —  ', style: theme.titleMedium),
          TextSpan(
            text: 'Peace Out!',
            style: theme.titleMedium!.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
