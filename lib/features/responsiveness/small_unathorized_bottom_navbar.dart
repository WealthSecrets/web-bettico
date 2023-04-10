import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SmallUnAthenticatedBottomNavbar extends StatelessWidget {
  const SmallUnAthenticatedBottomNavbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 80),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          color: context.colors.primary,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Sign up now to know what\'s happening on Xviral.',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
            const SizedBox(width: 24),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(40),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: context.colors.lightGrey,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  Ionicons.log_in_sharp,
                  size: 24,
                  color: context.colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
