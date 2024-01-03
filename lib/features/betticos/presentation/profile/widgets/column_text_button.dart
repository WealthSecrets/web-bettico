import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import '../screens/user_list_screen.dart';

class ColumnTextButton extends StatelessWidget {
  const ColumnTextButton({super.key, required this.title, required this.count, this.user, this.isFollowers = false});

  final User? user;
  final String title;
  final String count;
  final bool isFollowers;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => UserListScreen(isFollowers: isFollowers, theUser: user),
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
          Text(count, style: TextStyle(color: context.colors.text, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
