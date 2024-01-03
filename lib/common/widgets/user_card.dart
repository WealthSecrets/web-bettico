import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ProfileScreen(user: user),
          ),
        );
      },
      child: Row(
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(
                  '${AppEndpoints.userImages}/${user.photo}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '@${user.username}',
                  style: TextStyle(
                    color: context.colors.text,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          )
        ],
      ),
    );
  }
}
