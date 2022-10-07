// ignore_for_file: must_be_immutable, use_key_in_widget_ructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/presentation/timeline/getx/timeline_controller.dart';
import '/features/betticos/presentation/timeline/widgets/timeline_card.dart';

class PostDetailsScreen extends StatefulWidget {
  PostDetailsScreen({Key? key, required this.post, this.thePrevPost}) : super(key: key);

  Post post;
  Post? thePrevPost;

  static const String route = '/post-detail';

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final TimelineController controller = Get.find<TimelineController>();

  @override
  void initState() {
    super.initState();
    controller.getAllPostComments(widget.post.id);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Ionicons.close),
              color: context.colors.primary,
              onPressed: () {
                Navigator.of(context).pop<Post>(widget.thePrevPost);
              },
            ),
            centerTitle: false,
            title: Text(
              widget.post.isOddbox ? 'odds'.tr : 'post'.tr,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: controller.postComments.length + 1,
            padding: AppPaddings.lT,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return TimelineCard(
                  post: widget.post,
                  largeFonts: true,
                  onTap: () {},
                  onCommentTap: () => controller.navigateToAddPost(
                    context,
                    pstId: widget.post.id,
                  ),
                  onLikeTap: () => controller.likeThePost(context, widget.post.id, isOddbox: widget.post.isOddbox),
                  onDislikeTap: () =>
                      controller.dislikeThePost(context, widget.post.id, isOddbox: widget.post.isOddbox),
                );
              }

              return AppLoadingBox(
                loading: controller.isCommentLoading.value,
                child: TimelineCard(
                  post: controller.postComments[index - 1],
                  onTap: () async {
                    final Post? thePrevPost = await Navigator.of(context).push<Post>(
                      MaterialPageRoute<Post>(
                        builder: (BuildContext context) => PostDetailsScreen(
                          post: controller.postComments[index - 1],
                          thePrevPost: widget.post,
                        ),
                      ),
                    );
                    if (thePrevPost != null) {
                      await controller.getAllPostComments(thePrevPost.id);
                    }
                  },
                  onCommentTap: () => controller.navigateToAddPost(
                    context,
                    pstId: controller.postComments[index - 1].id,
                  ),
                  onLikeTap: () => controller.likeThePost(
                    context,
                    controller.postComments[index - 1].id,
                    isComment: true,
                  ),
                  onDislikeTap: () => controller.dislikeThePost(
                    context,
                    controller.postComments[index - 1].id,
                    isComment: true,
                  ),
                ),
              );
            },
          ),
        ),
        onWillPop: () {
          Navigator.of(context).pop<Post>(widget.thePrevPost);
          return Future<bool>.value(true);
        },
      ),
    );
  }
}
