import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:betticos/features/presentation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardController extends GetxController {
  CardController({required this.blockUser, required this.deletePost});

  final BlockUser blockUser;
  final DeletePost deletePost;

  // loading varaibles
  RxBool isLoading = false.obs;

  // controllers
  final ProfileController profileController = Get.find<ProfileController>();
  final TimelineController timelineController = Get.find<TimelineController>();

  void blockTheUser(BuildContext context, String userId) async {
    isLoading(true);

    final Either<Failure, User> failureOrUser = await blockUser(UserRequest(userId: userId));

    failureOrUser.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (_) {
        isLoading(false);
      },
    );
  }

  void deleteUserPost(BuildContext context, String postId) async {
    isLoading(true);
    final Either<Failure, void> failureOrUser = await deletePost(DeletePostParams(postId: postId));

    failureOrUser.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (_) {
        profileController.removePostFromMyPosts(postId);
        timelineController.removePostFromMyPosts(postId);
        isLoading(false);
      },
    );
  }
}
