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
    required this.addRepost,
    BaseScreenController? bController,
    ProfileController? pController,
  })  : bController = bController ?? Get.find<BaseScreenController>(),
        pController = pController ?? Get.find<ProfileController>();

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
  final AddRepost addRepost;

  static TimelineController instance = Get.find();
  final RxList<Post> posts = <Post>[].obs;
  final RxList<Repost> reposts = <Repost>[].obs;
  final Rx<Post> detailPost = Post.empty().obs;
  Rx<ListPage<Post>> postsL = ListPage<Post>.empty().obs;
  Rx<ListPage<Repost>> repostsL = ListPage<Repost>.empty().obs;
  final RxList<Post> oddboxes = <Post>[].obs;
  final RxList<Post> postComments = <Post>[].obs;
  final RxList<Repost> repostComments = <Repost>[].obs;
  final RxList<CombinedItem<dynamic>> combinedItems = <CombinedItem<dynamic>>[].obs;
  Rx<ListPage<CombinedItem<dynamic>>> combinedL = ListPage<CombinedItem<dynamic>>.empty().obs;
  final RxString postId = ''.obs;
  final RxString slipCode = ''.obs;
  final Rx<Post> post = Post.empty().obs;
  final RxString text = ''.obs;
  final RxInt maxTextLength = 280.obs;
  final RxList<Uint8List> files = <Uint8List>[].obs;
  final RxDouble uploadPercentage = 0.0.obs;
  final RxBool isCommentLoading = false.obs;
  final RxBool isReply = false.obs;
  final RxBool isOddbox = false.obs;
  final RxInt tabIndex = 0.obs;
  final RxInt pageK = 1.obs;
  final Rx<PagingController<int, CombinedItem<dynamic>>> pagingController =
      PagingController<int, CombinedItem<dynamic>>(firstPageKey: 1).obs;
  final RxBool isLoading = false.obs;
  final RxBool isLikingPost = false.obs;
  final RxBool isAddingPost = false.obs;
  final RxBool isCompleted = false.obs;
  final RxBool isDislikingPost = false.obs;
  final RxBool isPostLoading = false.obs;
  final RxBool isOddboxLoading = false.obs;
  final RxBool isAddingComment = false.obs;
  final BaseScreenController bController;
  final ProfileController pController;

  @override
  void onInit() {
    pagingController.value.addPageRequestListener(getCombinedItems);
    super.onInit();
  }

  void getAllSubscribedOddboxes(BuildContext context) async {
    isOddboxLoading(true);

    final Either<Failure, List<Post>> failureOrOddboxes = await fetchSubscribedOddboxes(NoParams());

    failureOrOddboxes.fold(
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

  void getCombinedItems(int pageKey) async {
    pageK(pageKey);
    isLoading(true);

    final Either<Failure, ListPage<Post>> failureOrPosts = await fetchPaginatedPosts(
      PageParmas(page: pageK.value, size: 100, leagueId: 1),
    );

    final Either<Failure, ListPage<Repost>> failureOrReposts = await fetchPaginatedReposts(
      PageParmas(page: pageK.value, size: 100, leagueId: 1),
    );

    final List<CombinedItem<dynamic>> combinedItemsBuffer = <CombinedItem<dynamic>>[];

    failureOrPosts.fold(
      (Failure failure) {
        isLoading(false);
        pagingController.value.error = failure;
      },
      (ListPage<Post> newPage) {
        postsL(newPage);
        combinedItemsBuffer.addAll(newPage.itemList.map((Post post) => CombinedItem<Post>(item: post, isPost: true)));
      },
    );

    failureOrReposts.fold(
      (Failure failure) {
        isLoading(false);
        pagingController.value.error = failure;
      },
      (ListPage<Repost> newPage) {
        repostsL(newPage);
        combinedItemsBuffer
            .addAll(newPage.itemList.map((Repost repost) => CombinedItem<Repost>(item: repost, isPost: false)));
      },
    );

    combinedItemsBuffer
        .sort((CombinedItem<dynamic> a, CombinedItem<dynamic> b) => -a.item.createdAt.compareTo(b.item.createdAt));

    final ListPage<CombinedItem<dynamic>> listPageCombined = ListPage<CombinedItem<dynamic>>(
      grandTotalCount: combinedItemsBuffer.length,
      itemList: combinedItemsBuffer,
    );

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
    final Post? pst = posts.firstWhereOrNull((Post post) => post.id == postId);
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
      FetchPostCommentsRequest(postId: postId),
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
    for (final Post oddbox in oddboxes) {
      if (!checkIfUserAlreadyExists(orderedOddbox, oddbox.user.id)) {
        orderedOddbox.add(oddbox);
      }
    }
    orderedOddbox.sort(
      (Post a, Post b) => getUserPercentage(b.user.id).compareTo(getUserPercentage(a.user.id)),
    );
    return orderedOddbox;
  }

  bool checkIfUserAlreadyExists(List<Post> psts, String userId) {
    return psts.any((Post element) => element.user.id == userId);
  }

  int getUsersTotalWins(String userId) {
    final List<Post> userPosts = oddboxes.where((Post post) => post.user.id == userId).toList();
    return userPosts.where((Post post) => post.likeUsers.length > post.dislikeUsers.length).length;
  }

  int getUserTotalLosses(String userId) {
    final List<Post> userPosts = oddboxes.where((Post post) => post.user.id == userId).toList();
    return userPosts.where((Post post) => post.dislikeUsers.length > post.likeUsers.length).length;
  }

  double getUserPercentage(String userId) {
    final int total = oddboxes.where((Post post) => post.user.id == userId).length;
    final int wins = getUsersTotalWins(userId);
    return (wins / total) * 100;
  }

  void addNewPost(BuildContext context, {bool? isReply, String? postId}) async {
    if (timelineIsInvalid) {
      await AppSnacks.show(context, message: 'Can not post an empty timeline.');
      return;
    }

    isAddingPost(true);

    final Either<Failure, Post> failureOrPost = await addPost(
      AddPostRequest(
        files: files,
        onSendProgress: (int count, int total) => uploadPercentage(count / total),
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
        final CombinedItem<Post> newCombinedItem = CombinedItem<Post>(item: pt, isPost: true);
        combinedItems.insert(0, newCombinedItem);
        pagingController.value.itemList = combinedItems.map((CombinedItem<dynamic> item) => item).toList();
        combinedItems
            .sort((CombinedItem<dynamic> a, CombinedItem<dynamic> b) => b.item.createdAt.compareTo(a.item.createdAt));
        pagingController.refresh();
        Get.back<dynamic>(result: pt);
      },
    );
  }

  void addNewRepost(BuildContext context, {required String postId}) async {
    isAddingPost(true);
    Navigator.of(context).pop();
    final Either<Failure, Repost> failureOrRepost = await addRepost(
      RepostRequest(postId: postId, commentsOnRepost: text.value),
    );

    failureOrRepost.fold(
      (Failure failure) {
        isAddingPost(false);
        text('');
        AppSnacks.show(context, message: failure.message);
      },
      (Repost pt) {
        isAddingPost(false);
        text('');
        final CombinedItem<Repost> newCombinedItem = CombinedItem<Repost>(item: pt, isPost: false);
        combinedItems.insert(0, newCombinedItem);
        pagingController.value.itemList = combinedItems.map((CombinedItem<dynamic> item) => item).toList();
        combinedItems
            .sort((CombinedItem<dynamic> a, CombinedItem<dynamic> b) => b.item.createdAt.compareTo(a.item.createdAt));
        pagingController.refresh();
        AppSnacks.show(
          context,
          message: 'Repost successful',
          backgroundColor: context.colors.success,
          leadingIcon: const Icon(Ionicons.checkmark_circle_outline, color: Colors.white),
        );
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
      (_) {
        isLoading(false);
      },
    );
  }

  void likeThePost(BuildContext context, String postId) async {
    isLikingPost(true);

    final Either<Failure, Post> failureOrPost = await likePost(
      LikeDislikePostParams(postId: postId, user: bController.user.value.id),
    );

    failureOrPost.fold(
      (Failure failure) {
        isLikingPost(false);
        AppSnacks.show(context, message: failure.message);
      },
      (Post pst) {
        isLikingPost(false);
        updateCombinedItems(pst.id, pst, true);
      },
    );
  }

  void likeTheRepost(BuildContext context, String repostId, {bool isComment = false}) async {
    isLikingPost(true);

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
        updateCombinedItems(rpst.id, rpst, false);
      },
    );
  }

  void updateCombinedItems(String id, dynamic updatedItem, bool isPost) {
    final int index = combinedItems.indexWhere((CombinedItem<dynamic> item) => item.item.id == id);
    if (index != -1) {
      combinedItems[index] = CombinedItem<dynamic>(item: updatedItem, isPost: isPost);
      pagingController.value.itemList = combinedItems.map((CombinedItem<dynamic> item) => item).toList();
      pagingController.refresh();
    }
  }

  void dislikeThePost(BuildContext context, String postId) async {
    isLikingPost(true);

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
        updateCombinedItems(pst.id, pst, true);
      },
    );
  }

  void dislikeTheRepost(BuildContext context, String repostId, {bool isComment = false}) async {
    isLikingPost(true);

    final Either<Failure, Repost> failureOrPost = await dislikeRepost(
      LikeDislikePostParams(
        postId: repostId,
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
      (Repost rpst) {
        isLikingPost(false);
        updateCombinedItems(rpst.id, rpst, false);
      },
    );
  }

  void setTheDetailPost(Post post) {
    detailPost(post);
  }

  void navigateToAddPost(BuildContext context, {Post? p, bool? isAreply}) async {
    if (p == null) {
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
            message: 'Post added successfully',
            backgroundColor: context.colors.success,
            leadingIcon: const Icon(
              Ionicons.checkmark_circle_outline,
              color: Colors.white,
            ),
          );
        }
      }
    } else {
      isReply(isAreply ?? false);
      postId(p.id);
      final dynamic post = await Get.toNamed<dynamic>(
        AppRoutes.timelinePost,
        arguments: AddPostCommentArgument(post: p, isReply: isAreply ?? false),
      );
      if (post != null) {
        getCombinedItems(pageK.value);
        pagingController.value.refresh();
        if (context.mounted) {
          getAllSubscribedOddboxes(context);
          await AppSnacks.show(
            context,
            message: isAreply == true ? 'Comment added successfully' : 'Repost successful.',
            backgroundColor: context.colors.success,
            leadingIcon: const Icon(Ionicons.checkmark_circle_outline, color: Colors.white),
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
