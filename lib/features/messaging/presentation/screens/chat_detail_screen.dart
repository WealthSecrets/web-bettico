import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> dummyChats = <Map<String, dynamic>>[
  <String, dynamic>{
    'chatType': ChatType.receiver,
    'text': 'Hello Nana, I am really in love with this your platform!',
    'username': 'maxjacobson',
  },
  <String, dynamic>{
    'chatType': ChatType.sender,
    'text': 'Hi jacobson, Thank you very much and I’m glad you love it!',
    'username': 'nanakay',
  },
  <String, dynamic>{
    'chatType': ChatType.sender,
    'text': 'In Accra',
    'username': 'nanakay',
  },
  <String, dynamic>{
    'chatType': ChatType.receiver,
    'text': 'Not at the moment but we could catch up next week',
    'username': 'maxjacobson',
  },
  <String, dynamic>{
    'chatType': ChatType.sender,
    'text': 'Hey man! you buying?',
    'username': 'nanakay',
    'images': <String>[
      AssetImages.profileImage,
      AssetImages.profileImage,
      AssetImages.profileImage,
      AssetImages.profileImage,
      AssetImages.profileImage,
      AssetImages.profileImage,
    ],
  },
  <String, dynamic>{
    'chatType': ChatType.receiver,
    'text': 'Naa, I\'m not interested in those items. Do you have anything else?',
    'username': 'maxjacobson',
  },
];

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0),
      borderSide: const BorderSide(color: Color(0xFFF5F7F9)),
    );
    return Scaffold(
      appBar: const _AppBar(),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            padding: AppPaddings.bodyB.add(AppPaddings.homeB),
            itemCount: dummyChats.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> chat = dummyChats[index];
              return ChatCard(
                username: chat['username'],
                text: chat['text'],
                chatType: chat['chatType'],
                images: chat['images'],
              );
            },
          ),
          _BottomTextField(border: border),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

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
            onTap: () => navigationController.goBack(),
            child: Image.asset(AppAssetIcons.arrowLeft, height: 24, width: 24, color: const Color(0xFF22272F)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              children: <Widget>[
                Avatar(imageUrl: AssetImages.profileImage, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Maximillian',
                  style: context.body1
                      .copyWith(fontWeight: FontWeight.w500, letterSpacing: 0.2, color: const Color(0xFF272E35)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Image.asset(AppAssetIcons.info, height: 24, width: 24),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _BottomTextField extends StatelessWidget {
  const _BottomTextField({required this.border});

  final InputBorder border;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: AppPaddings.lA,
        height: 73,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                style: const TextStyle(
                  color: Color(0xFF4A545E),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                ),
                decoration: InputDecoration(
                  hintText: 'Type a new message',
                  hintStyle: const TextStyle(
                    color: Color(0xFF4A545E),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2,
                  ),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                  disabledBorder: border,
                  errorBorder: border,
                  focusedErrorBorder: border,
                  filled: true,
                  fillColor: const Color(0xFFF5F7F9),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 41,
                width: 41,
                decoration: BoxDecoration(color: context.colors.primary, borderRadius: BorderRadius.circular(40)),
                child: const Center(child: Icon(Icons.arrow_upward_sharp, color: Colors.white, size: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
