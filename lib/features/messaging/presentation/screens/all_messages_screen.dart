import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';

class AllMessagesScreen extends StatelessWidget {
  const AllMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        MessageCard(messageType: MessageType.box),
        MessageCard(messageType: MessageType.chat, unread: false),
        MessageCard(messageType: MessageType.chat, unread: false),
        MessageCard(messageType: MessageType.chat),
        MessageCard(messageType: MessageType.box, unread: false),
      ],
    );
  }
}
