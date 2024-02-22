import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActualPost extends StatelessWidget {
  const ActualPost({super.key, required this.post, required this.bController});

  final Post post;
  final BaseScreenController bController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.mA,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFCED5DC)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(image: AssetImage(AssetImages.profileImage), fit: BoxFit.cover),
                ),
              ),
              if (post.user.firstName != null || post.user.lastName != null) ...<Widget>[
                const SizedBox(width: 5),
                Text(
                  '${post.user.firstName ?? ''} ${post.user.lastName ?? ''}',
                  style: context.caption.copyWith(
                    color: context.colors.black,
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              const SizedBox(width: 5),
              Text(
                '@${post.user.username} . ${timeago.format(post.createdAt)}',
                style: context.caption.copyWith(fontWeight: FontWeight.normal, color: context.colors.text),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (post.text != null) ...<Widget>[
            Text(
              post.text!,
              style: context.caption.copyWith(color: context.colors.black, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10)
          ],
          if (post.images != null && post.images!.isNotEmpty)
            TimelineImageDivider(
              images: const <String>[
                'https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg',
                'https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg'
              ],
              token: bController.userToken.value,
            ),
        ],
      ),
    );
  }
}
