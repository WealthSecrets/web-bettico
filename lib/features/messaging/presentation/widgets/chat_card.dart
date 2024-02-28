import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

enum ChatType { receiver, sender }

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.chatType, this.images, required this.text, required this.username});

  final ChatType chatType;
  final String text;
  final List<String>? images;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: chatType == ChatType.receiver ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        width: 269,
        padding: AppPaddings.lA,
        child: Column(
          crossAxisAlignment: chatType == ChatType.receiver ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: chatType == ChatType.receiver ? Alignment.topLeft : Alignment.topRight,
              child: Text(
                chatType == ChatType.receiver ? '@$username' : 'you',
                style: context.caption
                    .copyWith(fontWeight: FontWeight.w300, color: context.colors.darkenText, letterSpacing: 0.1),
              ),
            ),
            const SizedBox(height: 6),
            if (images != null) ...<Widget>[
              ImageDivider(images: images!, token: ''),
              const SizedBox(height: 6),
            ],
            Container(
              padding: AppPaddings.mA,
              decoration: BoxDecoration(
                color: chatType == ChatType.receiver ? const Color(0xFFFAF7FF) : const Color(0xFFF2EBFF),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    text,
                    style: context.body2.copyWith(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.2),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '16:44',
                      style: context.overline
                          .copyWith(fontWeight: FontWeight.w300, letterSpacing: 0.2, color: const Color(0xFF7E8B99)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
