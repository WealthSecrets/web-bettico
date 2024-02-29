// ignore_for_file: must_be_immutable, use_key_in_widget_ructors
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class PostDetailsScreen extends StatefulWidget {
  PostDetailsScreen({super.key, required this.post, this.thePrevPost});

  Post post;
  Post? thePrevPost;

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
              onPressed: () => Navigator.of(context).pop<Post>(widget.thePrevPost),
            ),
            centerTitle: false,
            title: Text(
              widget.post.isOddbox ? 'odds'.tr : 'post'.tr,
              style: const TextStyle(color: Colors.black, fontSize: 16),
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
                  onComment: () => controller.navigateToAddPost(context, id: widget.post.id),
                  onLike: () => controller.likeThePost(context, widget.post.id),
                  onDislike: () => controller.dislikeThePost(context, widget.post.id),
                  sponsored: widget.post.boosted == true,
                );
              }

              return AppLoadingBox(
                loading: controller.isCommentLoading.value,
                child: TimelineCard(
                  post: controller.postComments[index - 1],
                  onTap: () async {
                    final Post? thePrevPost = await Navigator.of(context).push<Post>(
                      MaterialPageRoute<Post>(
                        builder: (BuildContext context) =>
                            PostDetailsScreen(post: controller.postComments[index - 1], thePrevPost: widget.post),
                      ),
                    );
                    if (thePrevPost != null) {
                      await controller.getAllPostComments(thePrevPost.id);
                    }
                  },
                  onComment: () => controller.navigateToAddPost(context, id: controller.postComments[index - 1].id),
                  onLike: () => controller.likeThePost(context, controller.postComments[index - 1].id),
                  onDislike: () => controller.dislikeThePost(context, controller.postComments[index - 1].id),
                  sponsored: controller.postComments[index - 1].boosted == true,
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
