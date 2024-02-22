import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:betticos/features/presentation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ionicons/ionicons.dart';

class TimelineController extends GetxController {
  TimelineController({
    required this.fetchFollowingPosts,
    required this.fetchPaginatedPosts,
    required this.fetchPaginatedReposts,
    required this.fetchSubscribedOddboxes,
    required this.fetchPostComments,
    required this.addPost,
    required this.updatePost,
    required this.addReply,
    required this.addFeeling,
    required this.likePost,
    required this.dislikePost,
    required this.likeRepost,
    required this.dislikeRepost,
    required this.deletePost,
  });

  final FetchFollowingPosts fetchFollowingPosts;
  final FetchSubscribedOddboxes fetchSubscribedOddboxes;
  final FetchPaginatedPosts fetchPaginatedPosts;
  final FetchPaginatedReposts fetchPaginatedReposts;
  final FetchPostComments fetchPostComments;
  final AddPost addPost;
  final UpdatePost updatePost;
  final AddReply addReply;
  final AddFeeling addFeeling;
  final LikePost likePost;
  final DislikePost dislikePost;
  final LikeRepost likeRepost;
  final DislikeRepost dislikeRepost;
  final DeletePost deletePost;

  static TimelineController instance = Get.find();
  RxList<Post> posts = <Post>[].obs;
  RxList<Repost> reposts = <Repost>[].obs;
  Rx<Post> detailPost = Post.empty().obs;
  Rx<ListPage<Post>> postsL = ListPage<Post>.empty().obs;
  Rx<ListPage<Repost>> repostsL = ListPage<Repost>.empty().obs;
  Rx<ListPage<CombinedItem<dynamic>>> combinedL = ListPage<CombinedItem<dynamic>>.empty().obs;
  RxList<Post> oddboxes = <Post>[].obs;
  RxList<Post> postComments = <Post>[].obs;
  RxList<Repost> repostComments = <Repost>[].obs;
  RxList<CombinedItem<dynamic>> combinedItems = <CombinedItem<dynamic>>[].obs;
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
  Rx<PagingController<int, CombinedItem<dynamic>>> pagingController =
      PagingController<int, CombinedItem<dynamic>>(firstPageKey: 1).obs;

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

  @override
  void onInit() {
    pagingController.value.addPageRequestListener(getCombinedItems);
    super.onInit();
  }

  // void getAllFollowingPosts() async {
  //   isPostLoading(true);

  //   final Either<Failure, List<Post>> failureOrPosts = await fetchFollowingPosts(NoParams());

  //   failureOrPosts.fold(
  //     (Failure failure) {
  //       isPostLoading(false);
  //       Get.snackbar(
  //         '',
  //         failure.message,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         snackPosition: SnackPosition.TOP,
  //       );
  //     },
  //     (List<Post> pts) {
  //       isPostLoading(false);
  //       posts(pts);
  //     },
  //   );
  // }

  void getAllSubscribedOddboxes(BuildContext context) async {
    isOddboxLoading(true);

    final Either<Failure, List<Post>> failureOrOddboxes = await fetchSubscribedOddboxes(NoParams());

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

  // void getPaginatedPosts(int pageKey) async {
  //   pageK(pageKey);
  //   isLoading(true);
  //   final Either<Failure, ListPage<Post>> failureOrPosts = await fetchPaginatedPosts(
  //     PageParmas(page: pageK.value, size: 100, leagueId: 1),
  //   );

  //   failureOrPosts.fold(
  //     (Failure failure) {
  //       isLoading(false);
  //       pagingController.value.error = failure;
  //     },
  //     (ListPage<Post> newPage) {
  //       isLoading(false);
  //       final int previouslyFetchedItemsCount = pagingController.value.itemList?.length ?? 0;

  //       final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
  //       final List<Post> newItems = newPage.itemList;

  //       if (isLastPage) {
  //         pagingController.value.appendLastPage(newItems);
  //         if (!isCompleted.value) {
  //           posts.addAll(newItems);
  //         }
  //         isCompleted(true);
  //       } else {
  //         final int nextPageKey = pageKey + 1;
  //         pagingController.value.appendPage(newItems, nextPageKey);
  //         if (!isCompleted.value) {
  //           posts.addAll(newItems);
  //         }
  //       }
  //       postsL(newPage);
  //     },
  //   );
  // }

  void getCombinedItems(int pageKey) async {
    pageK(pageKey);
    isLoading(true);

    final Either<Failure, ListPage<Post>> failureOrPosts = await fetchPaginatedPosts(
      PageParmas(page: pageK.value, size: 100, leagueId: 1),
    );

    final Either<Failure, ListPage<Repost>> failureOrReposts = await fetchPaginatedReposts(
      PageParmas(page: pageK.value, size: 100, leagueId: 1),
    );

    failureOrPosts.fold(
      (Failure failure) {
        isLoading(false);
        pagingController.value.error = failure;
      },
      (ListPage<Post> newPage) {
        postsL(newPage);
        for (final Post post in newPage.itemList) {
          combinedItems.add(CombinedItem<Post>(item: post, isPost: true));
        }
      },
    );

    failureOrReposts.fold(
      (Failure failure) {
        isLoading(false);
        pagingController.value.error = failure;
      },
      (ListPage<Repost> newPage) {
        repostsL(newPage);
        for (final Repost repost in newPage.itemList) {
          combinedItems.add(CombinedItem<Repost>(item: repost, isPost: false));
        }
      },
    );

    combinedItems.sort((CombinedItem<dynamic> a, CombinedItem<dynamic> b) {
      if (a.isPost && b.isPost) {
        return -a.item.createdAt.compareTo(b.item.createdAt);
      } else if (!a.isPost && !b.isPost) {
        return -a.item.createdAt.compareTo(b.item.createdAt);
      } else {
        return a.isPost ? 1 : -1;
      }
    });

    final ListPage<CombinedItem<dynamic>> listPageCombined =
        ListPage<CombinedItem<dynamic>>(grandTotalCount: combinedItems.length, itemList: combinedItems);

    final int previouslyFetchedItemsCount = pagingController.value.itemList?.length ?? 0;

    final bool isLastPage = listPageCombined.isLastPage(previouslyFetchedItemsCount);
    final List<CombinedItem<dynamic>> newItems = listPageCombined.itemList;

    if (isLastPage) {
      pagingController.value.appendLastPage(newItems);
      if (!isCompleted.value) {
        combinedItems.addAll(newItems);
      }
      isCompleted(true);
    } else {
      final int nextPageKey = pageKey + 1;
      pagingController.value.appendPage(newItems, nextPageKey);
      if (!isCompleted.value) {
        combinedItems.addAll(newItems);
      }
    }
    combinedL(listPageCombined);
  }

  void getPostByPostId(String postId) {
    final Post? pst = posts.firstWhereOrNull((Post pst) => pst.id == postId);
    if (pst != null) {
      post(pst);
    }
  }

  void removeImage(int index) => files.removeAt(index);

  void addImage(Uint8List file) {
    files.add(file);
  }

  Future<void> getAllPostComments(String postId) async {
    isCommentLoading(true);

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
    orderedOddbox.sort(
      (Post a, Post b) => getUserPercentage(b.user.id).compareTo(getUserPercentage(a.user.id)),
    );
    return orderedOddbox;
  }

  bool checkIfUserAlreadyExists(List<Post> psts, String userId) {
    final Post? value = psts.firstWhereOrNull((Post element) => element.user.id == userId);
    if (value != null) {
      return true;
    }
    return false;
  }

  int getUsersTotalWins(String userId) {
    final List<Post> userPosts = oddboxes.where((Post post) => post.user.id == userId).toList();
    int wins = 0;
    for (int i = 0; i < userPosts.length; i++) {
      if (userPosts[i].likeUsers.length > userPosts[i].dislikeUsers.length) {
        wins = wins + 1;
      }
    }

    return wins;
  }

  int getUserTotalLosses(String userId) {
    final List<Post> userPosts = oddboxes.where((Post post) => post.user.id == userId).toList();
    int losses = 0;
    for (int i = 0; i < userPosts.length; i++) {
      if (userPosts[i].dislikeUsers.length > userPosts[i].likeUsers.length) {
        losses = losses + 1;
      }
    }
    return losses;
  }

  double getUserPercentage(String userId) {
    final int total = oddboxes.where((Post post) => post.user.id == userId).toList().length;
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
        pagingController.value.itemList!.insert(0, CombinedItem<Post>(item: pt, isPost: true));
        pagingController.refresh();
      },
    );
  }

  bool get timelineIsInvalid => text.value.isEmpty && files.isEmpty && slipCode.value.isEmpty;

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
        if (post != null) {
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
                0,
                pagingController.value.itemList!.length,
                <CombinedItem<Post>>[...posts.map((Post p) => CombinedItem<Post>(item: p, isPost: true))],
              );
              pagingController.refresh();
            }
          }
        }
      },
    );
  }

  void likeTheRepost(BuildContext context, String repostId, {bool isComment = false}) async {
    isLikingPost(true);

    Repost? repost;
    if (isComment) {
      repost = repostComments.firstWhereOrNull((Repost rp) => rp.id == repostId);
    }

    final Either<Failure, Repost> failureOrPost = await likeRepost(
      LikeDislikePostParams(postId: repostId, user: bController.user.value.id),
    );

    failureOrPost.fold(
      (Failure failure) {
        isLikingPost(false);
        AppSnacks.show(context, message: failure.message);
      },
      (Repost rpst) {
        isLikingPost(false);
        if (repost != null) {
          if (isComment) {
            final int repostIndex = repostComments.indexOf(post);
            repostComments[repostIndex] = rpst;
          } else {
            final int repostIndex = reposts.indexOf(repost);
            reposts[repostIndex] = rpst;
            pagingController.value.itemList!.replaceRange(
              0,
              pagingController.value.itemList!.length,
              <CombinedItem<Repost>>[...reposts.map((Repost p) => CombinedItem<Repost>(item: p, isPost: false))],
            );
            pagingController.refresh();
          }
        }
      },
    );
  }

  void updatePostListView(
    String postId,
    Post post, {
    bool isOddbox = false,
    bool isComment = false,
  }) {
    Post? oldPost;

    if (isComment) {
      oldPost = postComments.firstWhereOrNull((Post p) => p.id == postId);
    } else {
      if (isOddbox) {
        oldPost = oddboxes.firstWhereOrNull((Post p) => p.id == postId);
      } else {
        oldPost = posts.firstWhereOrNull((Post p) => p.id == postId);
      }
    }

    if (isComment) {
      final int postIndex = postComments.indexOf(oldPost);
      postComments[postIndex] = post;
    } else {
      if (isOddbox) {
        final int postIndex = oddboxes.indexOf(oldPost);
        oddboxes[postIndex] = post;
      } else {
        final int postIndex = posts.indexOf(oldPost);
        posts[postIndex] = post;
        pagingController.value.itemList!.replaceRange(
          0,
          pagingController.value.itemList!.length,
          <CombinedItem<Post>>[...posts.map((Post p) => CombinedItem<Post>(item: p, isPost: true))],
        );
        pagingController.refresh();
      }
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
                0,
                pagingController.value.itemList!.length,
                <CombinedItem<Post>>[...posts.map((Post p) => CombinedItem<Post>(item: p, isPost: true))],
              );
              pagingController.refresh();
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
        getCombinedItems(pageK.value);
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
      final dynamic post =
          await Get.toNamed<dynamic>(AppRoutes.timelinePost, arguments: AddPostCommentArgument(postId: pstId));
      if (post != null) {
        getCombinedItems(pageK.value);
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
    pagingController.value.itemList!.removeWhere((CombinedItem<dynamic> p) => p.item.id == id);
    final List<Post> theComments = List<Post>.from(postComments);
    theComments.removeWhere((Post p) => p.id == id);
    postComments(theComments);
    pagingController.refresh();
  }

  void deleteUserPo(BuildContext context, String postId) async {
    isLoading(true);
    final Either<Failure, void> failureOrUser = await deletePost(DeletePostParams(postId: postId));

    failureOrUser.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (_) => isLoading(false),
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
