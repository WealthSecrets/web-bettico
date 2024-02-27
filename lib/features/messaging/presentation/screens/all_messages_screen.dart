import 'package:betticos/common/routes/app_routes.dart';
import 'package:betticos/constants/controllers.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';

class AllMessagesScreen extends StatelessWidget {
  const AllMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        MessageCard(
          messageType: MessageType.box,
          onTap: () => navigationController.navigateTo(AppRoutes.chatDetails),
        ),
        const MessageCard(messageType: MessageType.chat, unread: false),
        const MessageCard(messageType: MessageType.chat, unread: false),
        const MessageCard(messageType: MessageType.chat),
        const MessageCard(messageType: MessageType.box, unread: false),
      ],
    );
  }
}
