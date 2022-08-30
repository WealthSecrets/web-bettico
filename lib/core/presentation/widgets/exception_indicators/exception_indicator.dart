import 'package:flutter/material.dart';
import '/core/core.dart';

/// Basic layout for indicating that an exception occurred.
class ExceptionIndicator extends StatelessWidget {
  const ExceptionIndicator({
    required this.title,
    required this.assetName,
    this.message,
    this.onTryAgain,
    this.size,
    this.gap,
    this.spacing,
    Key? key,
  }) : super(key: key);
  final String title;
  final String? message;
  final String assetName;
  final double? size;
  final double? gap;
  final double? spacing;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 16,
          ),
          child: Column(
            children: <Widget>[
              Image.asset(
                assetName,
                height: size ?? 100,
                width: size ?? 100,
              ),
              SizedBox(height: gap ?? 32),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              if (message != null) SizedBox(height: spacing ?? 16),
              if (message != null)
                Text(
                  message!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              if (onTryAgain != null) const Spacer(),
              if (onTryAgain != null)
                AppButton(
                  key: const Key('tryAgain'),
                  enabled: true,
                  padding: EdgeInsets.zero,
                  backgroundColor: context.colors.primary,
                  onPressed: onTryAgain!,
                  child: const Text(
                    'Try Again',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
}
