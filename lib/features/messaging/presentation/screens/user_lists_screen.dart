import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          Padding(
            padding: AppPaddings.lA,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Image.asset(AppAssetIcons.closeFrame, height: 32, width: 32),
                ),
                const SizedBox(width: 100),
                Text(
                  'New Message',
                  style: context.body1.copyWith(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.2),
                ),
              ],
            ),
          ),
          Padding(
            padding: AppPaddings.lH,
            child: SearchField(
              hintText: 'Search people',
              fillColor: const Color(0xFFF5F8FF),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11.0),
                borderSide: const BorderSide(color: Color(0xFFF5F8FF)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11.0),
                borderSide: const BorderSide(color: Color(0xFFF5F8FF)),
              ),
            ),
          ),
          const _MethodContainer(icon: AppAssetIcons.usersGrad, title: 'Send to a new group'),
          const _MethodContainer(icon: AppAssetIcons.pinGrad, title: 'Send to subscribers'),
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: AppPaddings.lH.add(AppPaddings.mV),
                  child: Row(
                    children: <Widget>[
                      const Avatar(
                        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
                        size: 30,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Richmond Blankson',
                              style: context.body2.copyWith(
                                  fontWeight: FontWeight.w400, color: context.colors.textInputText, letterSpacing: 0.2),
                            ),
                            Text(
                              '@blanksonR',
                              style: context.overline.copyWith(
                                  color: context.colors.icon, letterSpacing: 0.2, fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(color: context.colors.dividerColor, thickness: 0.3),
            ),
          )
        ],
      ),
    );
  }
}

class _MethodContainer extends StatelessWidget {
  const _MethodContainer({required this.icon, required this.title});

  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: AppPaddings.lH,
      child: Row(
        children: <Widget>[
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(color: const Color(0xFFFAF7FF), borderRadius: BorderRadius.circular(45)),
            child: Center(child: Image.asset(icon, height: 24)),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style:
                context.body1.copyWith(fontWeight: FontWeight.w500, letterSpacing: 0.2, color: context.colors.primary),
          ),
        ],
      ),
    );
  }
}
