import 'package:betticos/features/betticos/domain/requests/post/delete_post_params.dart';
import 'package:betticos/features/betticos/domain/usecases/post/delete_post.dart';
// import 'package:bitmap/bitmap.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ionicons/ionicons.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;

import '/core/core.dart';
// import '/core/presentation/services/notification_service.dart';
// import '/core/presentation/utils/app_endpoints.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/data/models/listpage/listpage.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/data/models/reply/reply_model.dart';
import '/features/betticos/domain/requests/post/add_post_request.dart';
import '/features/betticos/domain/requests/post/fetch_post_comments_request.dart';
import '/features/betticos/domain/requests/post/like_dislike_post_params.dart';
import '/features/betticos/domain/requests/reply/reply_request.dart';
import '/features/betticos/domain/usecases/feeling/add_feeling.dart';
import '/features/betticos/domain/usecases/post/add_post.dart';
import '/features/betticos/domain/usecases/post/dislike_post.dart';
import '/features/betticos/domain/usecases/post/fetch_following_posts.dart';
import '/features/betticos/domain/usecases/post/fetch_paginated_posts.dart';
import '/features/betticos/domain/usecases/post/fetch_post_comments.dart';
import '/features/betticos/domain/usecases/post/like_post.dart';
import '/features/betticos/domain/usecases/post/update_post.dart';
import '/features/betticos/domain/usecases/reply/add_reply.dart';
import '/features/betticos/domain/usecases/subscription/fetch_subscribed_oddboxes.dart';
import '/features/betticos/presentation/base/getx/base_screen_controller.dart';
import '/features/betticos/presentation/timeline/arguments/add_post_comment_argument.dart';
import '/features/betticos/presentation/timeline/arguments/post_details_argument.dart';
import '../../profile/getx/profile_controller.dart';

class TimelineController extends GetxController {
  TimelineController({
    required this.fetchFollowingPosts,
    required this.fetchPaginatedPosts,
    required this.fetchSubscribedOddboxes,
    required this.fetchPostComments,
    required this.addPost,
    required this.updatePost,
    required this.addReply,
    required this.addFeeling,
    // required this.notificationService,
    required this.likePost,
    required this.dislikePost,
    required this.deletePost,
  });

  final FetchFollowingPosts fetchFollowingPosts;
  final FetchSubscribedOddboxes fetchSubscribedOddboxes;
  final FetchPaginatedPosts fetchPaginatedPosts;
  final FetchPostComments fetchPostComments;
  final AddPost addPost;
  final UpdatePost updatePost;
  final AddReply addReply;
  final AddFeeling addFeeling;
  final LikePost likePost;
  final DislikePost dislikePost;
  final DeletePost deletePost;

  static TimelineController instance = Get.find();

  // notification dependencies
  // final NotificationService notificationService;

  // reactive variables
  RxList<Post> posts = <Post>[].obs;
  Rx<Post> detailPost = Post.empty().obs;
  Rx<ListPage<Post>> postsL = ListPage<Post>.empty().obs;
  RxList<Post> oddboxes = <Post>[].obs;
  RxList<Post> postComments = <Post>[].obs;
  RxString postId = ''.obs;
  RxString slipCode = ''.obs;
  Rx<Post> post = Post.empty().obs;
  RxString text = ''.obs;
  RxInt maxTextLength = 280.obs;
  RxList<Uint8List> files = <Uint8List>[].obs;
  RxDouble uploadPercentage = 0.0.obs;
  RxBool isCommentLoading = false.obs;
  RxBool isReply = false.obs;
  RxBool isOddbox = false.obs;
  RxInt tabIndex = 0.obs;
  RxInt pageK = 1.obs;
  Rx<PagingController<int, Post>> pagingController =
      PagingController<int, Post>(firstPageKey: 1).obs;

  // loading state
  RxBool isLoading = false.obs;
  RxBool isLikingPost = false.obs;
  RxBool isDislikingPost = false.obs;
  RxBool isPostLoading = false.obs;
  RxBool isOddboxLoading = false.obs;
  RxBool isAddingPost = false.obs;
  RxBool isAddingComment = false.obs;
  RxBool isCompleted = false.obs;

  final BaseScreenController bController = Get.find<BaseScreenController>();
  final ProfileController pController = Get.find<ProfileController>();

  // io.Socket? socket;

  @override
  void onInit() {
    // notificationService.initialize();
    // connectAndListen();
    pagingController.value.addPageRequestListener(getPaginatedPosts);
    // getAllFollowingPosts();
    super.onInit();
  }

  // void connectAndListen() {
  //   socket = io.io(
  //     environment.isProduction
  //         ? 'http://api.wealthsecrets.io:8000'
  //         : 'http://192.168.0.117:8000',
  //     io.OptionBuilder().setTransports(<String>['websocket']).build(),
  //   );
  //   socket?.onConnect((dynamic _) async {
  //     socket?.on('post-added-${bController.user.value.id}', postAddedListener);
  //     socket?.on('post-liked-${bController.user.value.id}', postLikedListener);
  //     socket?.on('post-commented-${bController.user.value.id}',
  //         postCommentedOnListener);
  //     socket?.on('follow-${bController.user.value.id}-user', followListener);
  //     socket?.on(
  //         'follow-${bController.user.value.id}-follower', followerListener);
  //     socket?.on(
  //         'subscribe-${bController.user.value.id}', subscriptionListener);
  //     socket?.on(
  //         'user-blocked-${bController.user.value.id}', userBlockedListener);
  //   });
  // }

  void postAddedListener(dynamic data) async {
    final Post newPost = Post.fromJson(data as Map<String, dynamic>);
    if (!posts.contains(newPost)) {
      posts.insert(0, newPost);
      if (newPost.images != null) {
        // final Bitmap bitmap = await Bitmap.fromProvider(NetworkImage(
        //   '${AppEndpoints.postImages}/${newPost.images![0]}',
        //   headers: <String, String>{
        //     'Authorization': 'Bearer ${bController.userToken.value}'
        //   },
        // ));
        // await notificationService.imageNotification(
        //     '${newPost.user.firstName} ${newPost.user.lastName}',
        //     '${newPost.text}',
        //     bitmap);
      } else {
        // await notificationService.instantNotification(
        //     '${newPost.user.firstName} ${newPost.user.lastName}',
        //     '${newPost.text}');
      }
    }
  }

  void postLikedListener(dynamic data) async {
    final Post newPost = Post.fromJson(data['post'] as Map<String, dynamic>);
    // final User user =
    User.fromJson(data['user'] as Map<String, dynamic>);
    if (newPost.images != null && newPost.images!.isNotEmpty) {
      // final Bitmap bitmap = await Bitmap.fromProvider(NetworkImage(
      //   '${AppEndpoints.postImages}/${newPost.images![0]}',
      //   headers: <String, String>{
      //     'Authorization': 'Bearer ${bController.userToken.value}'
      //   },
      // ));
      // await notificationService.imageNotification(
      //   '${user.firstName} ${user.lastName} liked',
      //   '${newPost.text}',
      //   bitmap,
      // );
    } else {
      // await notificationService.instantNotification(
      //   '${user.firstName} ${user.lastName} liked',
      //   '${newPost.text}',
      // );
    }
  }

  void postCommentedOnListener(dynamic data) async {
    // final Post thePost = Post.fromJson(data['post'] as Map<String, dynamic>);
    final Post theComment =
        Post.fromJson(data['comment'] as Map<String, dynamic>);
    if (theComment.images != null && theComment.images!.isNotEmpty) {
      // final Bitmap bitmap = await Bitmap.fromProvider(NetworkImage(
      //   '${AppEndpoints.postImages}/${theComment.images![0]}',
      //   headers: <String, String>{
      //     'Authorization': 'Bearer ${bController.userToken.value}'
      //   },
      // ));
      // await notificationService.imageNotification(
      //   '${theComment.user.firstName} ${theComment.user.lastName} commented',
      //   '${theComment.text}',
      //   bitmap,
      // );
    } else {
      // await notificationService.instantNotification(
      //     '${theComment.user.firstName} ${theComment.user.lastName} commented',
      //     '${theComment.text}');
    }
  }

  void followListener(dynamic data) async {
    // final User follower =
    User.fromJson(data as Map<String, dynamic>);
    final Map<String, dynamic> theLoggedInUserMap =
        bController.user.value.toJson();
    final int hisFollowersCount = theLoggedInUserMap['followers'] as int;
    theLoggedInUserMap['followers'] = hisFollowersCount + 1;
    final User theLoggedInUser = User.fromJson(theLoggedInUserMap);
    bController.updateTheUser(theLoggedInUser);
    // await notificationService.instantNotification(
    //   'Bettico',
    //   '${follower.firstName} ${follower.lastName} followed you',
    // );
  }

  void followerListener(dynamic data) async {
    final User user = User.fromJson(data as Map<String, dynamic>);
    pController.setProfileUser(user);
  }

  void subscriptionListener(dynamic data) async {
    // final User user =
    User.fromJson(data as Map<String, dynamic>);
    // await notificationService.instantNotification(
    //   'Bettico',
    //   '${user.firstName} ${user.lastName} subscribed to you',
    // );
  }

  void userBlockedListener(dynamic data) async {
    final String blockedUserId = data as String;
    pagingController.value.itemList!
        .removeWhere((Post p) => p.user.id == blockedUserId);
    pagingController.value.notifyListeners();
  }

  void getAllFollowingPosts() async {
    isPostLoading(true);

    final Either<Failure, List<Post>> failureOrPosts =
        await fetchFollowingPosts(NoParams());

    failureOrPosts.fold(
      (Failure failure) {
        isPostLoading(false);
        Get.snackbar(
          '',
          failure.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      },
      (List<Post> pts) {
        isPostLoading(false);
        posts(pts);
      },
    );
  }

  void getAllSubscribedOddboxes(BuildContext context) async {
    isOddboxLoading(true);

    final Either<Failure, List<Post>> failureOrOddboxes =
        await fetchSubscribedOddboxes(NoParams());

    failureOrOddboxes.fold<void>(
      (Failure failure) {
        isOddboxLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<Post> value) {
        isOddboxLoading(false);
        oddboxes(value);
      },
    );
  }

  void changeTabIndex(int index) {
    tabIndex(index);
  }

  void getPaginatedPosts(int pageKey) async {
    pageK(pageKey);
    isLoading(true);
    final Either<Failure, ListPage<Post>> failureOrPosts =
        await fetchPaginatedPosts(
      PageParmas(
        page: pageK.value,
        size: 100,
        leagueId: 1,
      ),
    );

    failureOrPosts.fold(
      (Failure failure) {
        isLoading(false);
        pagingController.value.error = failure;
      },
      (ListPage<Post> newPage) {
        isLoading(false);
        final int previouslyFetchedItemsCount =
            pagingController.value.itemList?.length ?? 0;

        final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
        final List<Post> newItems = newPage.itemList;

        if (isLastPage) {
          pagingController.value.appendLastPage(newItems);
          if (!isCompleted.value) {
            posts.addAll(newItems);
          }
          isCompleted(true);
        } else {
          final int nextPageKey = pageKey + 1;
          pagingController.value.appendPage(newItems, nextPageKey);
          if (!isCompleted.value) {
            posts.addAll(newItems);
          }
        }
        postsL(newPage);
      },
    );
  }

  void getPostByPostId(String postId) {
    final Post? pst = posts.firstWhereOrNull((Post pst) => pst.id == postId);
    if (pst != null) {
      post(pst);
    }
  }

  void removeImage(int index) {
    // final List<File> imageFiles = List<File>.from(files);
    // imageFiles.indexOf((File file) => false)
    files.removeAt(index);
  }

  void addImage(Uint8List file) {
    files.add(file);
  }

  Future<void> getAllPostComments(String postId) async {
    isCommentLoading(true);

    // resetValues();

    final Either<Failure, List<Post>> failureOrPosts = await fetchPostComments(
      FetchPostCommentsRequest(
        postId: postId,
      ),
    );

    failureOrPosts.fold(
      (Failure failure) {
        isCommentLoading(false);
        Get.snackbar(
          '',
          failure.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      },
      (List<Post> pts) {
        isCommentLoading(false);
        postComments(pts);
      },
    );
  }

  List<Post> getTopUsers() {
    final List<Post> orderedOddbox = <Post>[];
    for (int i = 0; i < oddboxes.length; i++) {
      if (!checkIfUserAlreadyExists(orderedOddbox, oddboxes[i].user.id)) {
        orderedOddbox.add(oddboxes[i]);
      }
    }
    orderedOddbox.sort((Post a, Post b) =>
        getUserPercentage(b.user.id).compareTo(getUserPercentage(a.user.id)));
    return orderedOddbox;
  }

  // double getFeelingAverageForUserPosts(String userId) {
  //   final List<Post> userPosts =
  //       oddboxes.where((Post post) => post.user.id == userId).toList();
  //   int wins = 0;
  //   int losses = 0;
  //   for (int i = 0; i < userPosts.length; i++) {
  //     if (userPosts[i].likeUsers.length > userPosts[i].dislikeUsers.length) {
  //       wins = wins + 1;
  //     } else {
  //       losses = losses + 1;
  //     }
  //   }

  //   return (wins / userPosts.length) * 100;
  // }

  bool checkIfUserAlreadyExists(List<Post> psts, String userId) {
    final Post? value =
        psts.firstWhereOrNull((Post element) => element.user.id == userId);
    if (value != null) {
      return true;
    }
    return false;
  }

  int getUsersTotalWins(String userId) {
    final List<Post> userPosts =
        oddboxes.where((Post post) => post.user.id == userId).toList();
    int wins = 0;
    for (int i = 0; i < userPosts.length; i++) {
      if (userPosts[i].likeUsers.length > userPosts[i].dislikeUsers.length) {
        wins = wins + 1;
      }
    }

    return wins;
  }

  int getUserTotalLosses(String userId) {
    final List<Post> userPosts =
        oddboxes.where((Post post) => post.user.id == userId).toList();
    int losses = 0;
    for (int i = 0; i < userPosts.length; i++) {
      if (userPosts[i].dislikeUsers.length > userPosts[i].likeUsers.length) {
        losses = losses + 1;
      }
    }
    return losses;
  }

  double getUserPercentage(String userId) {
    final int total =
        oddboxes.where((Post post) => post.user.id == userId).toList().length;
    final int wins = getUsersTotalWins(userId);
    return (wins / total) * 100;
  }

  void addNewPost(BuildContext context, {bool? isReply, String? postId}) async {
    if (timelineIsInvalid) {
      await AppSnacks.show(
        context,
        message: 'Can not post an empty timeline.',
      );
      return;
    }

    isAddingPost(true);

    final Either<Failure, Post> failureOrPost = await addPost(
      AddPostRequest(
        files: files,
        onSendProgress: (int count, int total) {
          uploadPercentage(count / total);
        },
        text: text.value,
        slipCode: slipCode.value,
        isOddbox: slipCode.isNotEmpty,
        isReply: isReply,
        postId: postId,
      ),
    );

    failureOrPost.fold(
      (Failure failure) {
        isAddingPost(false);
        resetValuesAfterPost();
        if (failure.message == 'Unexpected field') {
          AppSnacks.show(
            context,
            message: 'Only four images are allowed.',
          );
        } else {
          AppSnacks.show(
            context,
            message: failure.message,
          );
        }
      },
      (Post pt) {
        isAddingPost(false);
        resetValuesAfterPost();
        Get.back<dynamic>(result: pt);
        pagingController.value.itemList!.insert(0, pt);
        pagingController.value.notifyListeners();
      },
    );
  }

  bool get timelineIsInvalid =>
      text.value.isEmpty && files.isEmpty && slipCode.value.isEmpty;

  void addNewReply(BuildContext context, String commentId) async {
    isLoading(true);

    final Either<Failure, Reply> failureOrPost = await addReply(
      ReplyRequest(
        text: text.value,
        commentId: commentId,
      ),
    );

    failureOrPost.fold(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(
          context,
          message: failure.message,
        );
      },
      (Reply _) {
        isLoading(false);
      },
    );
  }

  void likeThePost(
    BuildContext context,
    String postId, {
    bool isOddbox = false,
    bool isComment = false,
  }) async {
    isLikingPost(true);

    Post? post;
    if (isComment) {
      post = postComments.firstWhereOrNull((Post p) => p.id == postId);
    } else {
      if (isOddbox) {
        post = oddboxes.firstWhereOrNull((Post p) => p.id == postId);
      } else {
        post = posts.firstWhereOrNull((Post p) => p.id == postId);
      }
    }

    if (post != null) {
      final Either<Failure, Post> failureOrPost = await likePost(
        LikeDislikePostParams(
          postId: postId,
          user: bController.user.value.id,
        ),
      );

      failureOrPost.fold(
        (Failure failure) {
          isLikingPost(false);
          AppSnacks.show(
            context,
            message: failure.message,
          );
        },
        (Post pst) {
          isLikingPost(false);
          if (isComment) {
            final int postIndex = postComments.indexOf(post);
            postComments[postIndex] = pst;
          } else {
            if (isOddbox) {
              final int postIndex = oddboxes.indexOf(post);
              oddboxes[postIndex] = pst;
            } else {
              final int postIndex = posts.indexOf(post);
              posts[postIndex] = pst;
              pagingController.value.itemList!.replaceRange(
                  0, pagingController.value.itemList!.length, <Post>[...posts]);
              pagingController.value.notifyListeners();
            }
          }
        },
      );
    } else {
      isLikingPost(false);
      await AppSnacks.show(
        context,
        message: 'Error liking post',
      );
    }
  }

  void dislikeThePost(
    BuildContext context,
    String postId, {
    bool isOddbox = false,
    bool isComment = false,
  }) async {
    isLikingPost(true);

    Post? post;
    if (isComment) {
      post = postComments.firstWhereOrNull((Post p) => p.id == postId);
    } else {
      if (isOddbox) {
        post = oddboxes.firstWhereOrNull((Post p) => p.id == postId);
      } else {
        post = posts.firstWhereOrNull((Post p) => p.id == postId);
      }
    }

    if (post != null) {
      final Either<Failure, Post> failureOrPost = await dislikePost(
        LikeDislikePostParams(
          postId: postId,
          user: bController.user.value.id,
        ),
      );

      failureOrPost.fold(
        (Failure failure) {
          isLikingPost(false);
          AppSnacks.show(
            context,
            message: failure.message,
          );
        },
        (Post pst) {
          isLikingPost(false);
          if (isComment) {
            final int postIndex = postComments.indexOf(post);
            postComments[postIndex] = pst;
          } else {
            if (isOddbox) {
              final int postIndex = oddboxes.indexOf(post);
              oddboxes[postIndex] = pst;
            } else {
              final int postIndex = posts.indexOf(post);
              posts[postIndex] = pst;

              pagingController.value.itemList!.replaceRange(
                  0, pagingController.value.itemList!.length, <Post>[...posts]);
              pagingController.value.notifyListeners();
            }
          }
        },
      );
    } else {
      isLikingPost(false);
      await AppSnacks.show(
        context,
        message: 'Error disliking post',
      );
    }
  }

  void setTheDetailPost(Post post) {
    detailPost(post);
  }

  void navigateToAddPost(BuildContext context, {String? pstId}) async {
    if (pstId == null) {
      postId('');
      isReply(false);
      final dynamic post = await Get.toNamed<dynamic>(AppRoutes.timelinePost);
      if (post != null) {
        resetValues();
        getAllFollowingPosts();
        if (context.mounted) {
          getAllSubscribedOddboxes(context);
          await AppSnacks.show(
            context,
            message: 'Post added succcessfully',
            backgroundColor: context.colors.success,
            leadingIcon: const Icon(
              Ionicons.checkmark_circle_outline,
              color: Colors.white,
            ),
          );
        }
      }
    } else {
      isReply(true);
      postId(pstId);
      final dynamic post = await Get.toNamed<dynamic>(AppRoutes.timelinePost,
          arguments: AddPostCommentArgument(postId: pstId));
      // final dynamic post = await navigationController.navigateTo(
      //     AppRoutes.timelinePost,
      //     arguments: AddPostCommentArgument(postId: pstId));
      if (post != null) {
        getPaginatedPosts(pageK.value);
        pagingController.value.refresh();
        if (context.mounted) {
          getAllSubscribedOddboxes(context);
          await AppSnacks.show(
            context,
            message: 'Comment added succcessfully',
            backgroundColor: context.colors.success,
            leadingIcon: const Icon(
              Ionicons.checkmark_circle_outline,
              color: Colors.white,
            ),
          );
        }
      }
    }
  }

  void removePostFromMyPosts(String id) {
    pagingController.value.itemList!.removeWhere((Post p) => p.id == id);
    pagingController.value.notifyListeners();
  }

  void deleteUserPost(BuildContext context, String postId) async {
    isLoading(true);
    final Either<Failure, void> failureOrUser =
        await deletePost(DeletePostParams(postId: postId));

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

  void navigateToPostDetails(Post post) async {
    final dynamic value = await Get.toNamed<dynamic>(
      AppRoutes.postDetails,
      arguments: PostDetailsArgument(
        post: post,
      ),
    );
    if (value != null) {
      resetValues();
    }
  }

  void onSlipCodeFieldSubmitted(String value) {
    slipCode(value);
    Get.back<void>();
  }

  void resetSlipCodeValue() {
    slipCode('');
    Get.back<void>();
  }

  void resetValues() {
    postComments(<Post>[]);
    files(<Uint8List>[]);
  }

  void resetValuesAfterPost() {
    text('');
    slipCode('');
    files(<Uint8List>[]);
    isOddbox(false);
  }

  void onTextInputChanged(String value) {
    if (value.length <= maxTextLength.value) {
      text(value);
    }
  }

  void onFileChanged(Uint8List value) {
    files.add(value);
  }
}
