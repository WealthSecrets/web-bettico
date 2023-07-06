import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class SucessScreenRouteArgument {
  const SucessScreenRouteArgument({
    required this.title,
    required this.message,
    required this.onPressed,
  });

  final String title;
  final String message;
  final VoidCallback onPressed;
}

class SucessScreen extends StatelessWidget {
  const SucessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SucessScreenRouteArgument? args = ModalRoute.of(context)!.settings.arguments as SucessScreenRouteArgument?;
    return Scaffold(
      body: Padding(
        padding: AppPaddings.bodyH,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(AssetImages.checkedColor, height: 65, width: 65),
            const SizedBox(height: 16),
            if (args != null)
              Text(
                args.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            const SizedBox(height: 32),
            if (args != null)
              Text(
                args.message,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: context.colors.text),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 50),
            Row(
              children: <Widget>[
                Expanded(
                  child: AppButton(
                    padding: EdgeInsets.zero,
                    borderRadius: AppBorderRadius.largeAll,
                    backgroundColor: context.colors.text,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'BACK',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                if (args != null)
                  Expanded(
                    child: AppButton(
                      padding: EdgeInsets.zero,
                      borderRadius: AppBorderRadius.largeAll,
                      backgroundColor: context.colors.primary,
                      onPressed: args.onPressed,
                      child: const Text(
                        'VIEW HISTORY',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
