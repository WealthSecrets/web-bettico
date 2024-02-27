import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

import 'dot.dart';

enum MessageType { chat, box }

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.messageType, this.onTap, this.unread = true});

  final VoidCallback? onTap;
  final MessageType messageType;
  final bool unread;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppPaddings.lA,
        color: unread == true ? const Color(0xFFCED5DC).withOpacity(0.3) : null,
        child: Row(
          children: <Widget>[
            if (messageType == MessageType.chat)
              const Avatar(imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d', size: 45),
            if (messageType == MessageType.box)
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(color: const Color(0xFFF5F8FF), borderRadius: BorderRadius.circular(45)),
                child: Center(child: Image.asset(AppAssetIcons.gift, color: context.colors.primary, height: 24)),
              ),
            const SizedBox(width: 13),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width - 90,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Blankson',
                              style: context.body1.copyWith(
                                color: context.colors.black,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.1,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '@blanksonR',
                              style: context.body1.copyWith(
                                color: context.colors.textInputIconColor,
                                letterSpacing: 0.1,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '3h',
                        style: context.body1.copyWith(
                          color: context.colors.textInputIconColor,
                          letterSpacing: 0.1,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      if (unread == true) ...<Widget>[
                        const SizedBox(width: 5),
                        const Dot(),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                if (messageType == MessageType.chat)
                  Text(
                    'You: See you next weekend Jimmy!',
                    style: context.body1
                        .copyWith(color: context.colors.text, fontWeight: FontWeight.w300, letterSpacing: 0.1),
                  ),
                if (messageType == MessageType.box)
                  RichText(
                    text: TextSpan(
                      text: 'Today 162 Odds, code:',
                      style: TextStyle(color: context.colors.text, fontWeight: FontWeight.w300, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' 8249B0BE ',
                          style: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w300, fontSize: 16),
                        ),
                        TextSpan(
                          text: '....',
                          style: TextStyle(color: context.colors.text, fontWeight: FontWeight.w300, fontSize: 16),
                        ),
                      ],
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
