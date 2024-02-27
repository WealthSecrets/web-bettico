import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavigationBar({super.key, this.scaffoldKey, this.title});

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: AppPaddings.lH,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (scaffoldKey != null) {
                scaffoldKey!.currentState?.openDrawer();
              }
            },
            child: Container(
              height: 29,
              width: 29,
              decoration:
                  const BoxDecoration(image: DecorationImage(image: AssetImage(AssetImages.round), fit: BoxFit.cover)),
            ),
          ),
          if (title != null)
            Text(
              title!,
              style: context.body1
                  .copyWith(fontWeight: FontWeight.w500, letterSpacing: 0.2, color: const Color(0xFF272E35)),
            )
          else
            Image.asset(AssetImages.logo, height: 25, width: 25),
          IconButton(onPressed: () {}, icon: const SizedBox()),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
