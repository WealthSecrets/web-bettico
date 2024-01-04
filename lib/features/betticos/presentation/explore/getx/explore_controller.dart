import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

enum Options { posts, anonymous, games }

class ExploreController extends GetxController with GetSingleTickerProviderStateMixin {
  ExploreController({
    required this.explorePosts,
    required this.fetchHashtags,
    required this.searchPosts,
  });

  final ExplorePosts explorePosts;
  final FetchHashtags fetchHashtags;
  final SearchPosts searchPosts;

  RxList<Post> posts = <Post>[].obs;
  RxList<Hashtag> hashtags = <Hashtag>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingHashtags = false.obs;
  RxBool isCompleted = false.obs;
  Rx<Options> selectedOption = Options.values.first.obs;

  RxInt pageK = 1.obs;
  Rx<ListPage<Post>> postsL = ListPage<Post>.empty().obs;
  PagingController<int, Post> pagingController = PagingController<int, Post>(firstPageKey: 1);

  RxString selectedHashtag = ''.obs;

  Rx<TextEditingController> textEditingController = TextEditingController(text: '').obs;

  late TabController tabController;

  // Search variables
  RxList<Post> top = <Post>[].obs;
  RxList<Post> latest = <Post>[].obs;
  RxList<Post> images = <Post>[].obs;
  RxList<User> users = <User>[].obs;
  RxList<Hashtag> filteredHashtags = <Hashtag>[].obs;
  RxBool isSearching = false.obs;

  RxBool isOnSearchPage = false.obs;

  @override
  void onInit() {
    tabController = TabController(length: 5, vsync: this);
    pagingController.addPageRequestListener(getExplorePosts);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    textEditingController.close();
  }

  void getExplorePosts(int pageKey) async {
    pageK(pageKey);
    isLoading(true);
    final Either<Failure, PaginatedResponseData<Post>> failureOrResult = await explorePosts(
      PageParmas(page: pageK.value, size: 100, leagueId: 1),
    );
    failureOrResult.fold<void>(
      (Failure failure) {
        isLoading(false);
        pagingController.error = failure;
      },
      (PaginatedResponseData<Post> response) {
        isLoading(false);
        if (response.isLastPage) {
          pagingController.appendLastPage(response.data);
        } else {
          pagingController.appendPage(response.data, response.nextPage);
        }
      },
    );
  }

  void getFilteredPosts(int pageKey) async {
    pageK(pageKey);
    isSearching(true);
    final Either<Failure, SearchResponse> failureOrResult = await searchPosts(
      SearchPageParams(
        keyword: selectedHashtag.value,
        page: pageK.value,
        size: 100,
      ),
    );
    failureOrResult.fold<void>(
      (Failure failure) {
        isSearching(false);
      },
      (SearchResponse response) {
        isSearching(false);
        top.value = response.top;
        latest.value = response.latest;
        images.value = response.images;
        users.value = response.users;
        filteredHashtags.value = response.hashtags;
      },
    );
  }

  void getAllHashtags() async {
    final Either<Failure, List<Hashtag>> failureOrResult = await fetchHashtags(
      NoParams(),
    );
    failureOrResult.fold<void>(
      (Failure failure) {
        isLoadingHashtags(false);
      },
      (List<Hashtag> response) {
        isLoadingHashtags(false);
        hashtags.value = response;
      },
    );
  }

  void refreshPosts() {
    pagingController.refresh();
    selectedOption(Options.posts);
  }

  void setSelectedHashtag(String hashtag) {
    if (selectedHashtag.value != hashtag) {
      selectedHashtag.value = hashtag;
    }
  }

  void navigateToSearchPage() {
    if (!isOnSearchPage.value) {
      isOnSearchPage.value = true;
      navigationController.navigateTo(AppRoutes.search);
    }
  }
}
