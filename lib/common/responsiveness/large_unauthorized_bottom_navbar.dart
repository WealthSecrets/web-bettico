import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class LargeUnAthenticatedBottomNavbar extends StatelessWidget {
  const LargeUnAthenticatedBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 80),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: context.colors.primary),
        child: Row(
          children: <Widget>[
            const Expanded(flex: 4, child: SizedBox()),
            const Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Sign up now to know what\'s happening on Xviral.',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SelectableButton(
                      text: 'Log in',
                      color: Colors.white,
                      fontSize: 14,
                      textColor: context.colors.primary,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 8),
                    SelectableButton(
                      text: 'Sign up',
                      color: Colors.white,
                      fontSize: 14,
                      textColor: context.colors.primary,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
