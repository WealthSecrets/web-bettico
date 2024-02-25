import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';

class CreatorBoxScreen extends StatelessWidget {
  const CreatorBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        MessageCard(messageType: MessageType.box),
        MessageCard(messageType: MessageType.box, unread: false),
      ],
    );
  }
}
