import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        MessageCard(messageType: MessageType.chat, unread: false),
        MessageCard(messageType: MessageType.chat, unread: false),
        MessageCard(messageType: MessageType.chat),
      ],
    );
  }
}
