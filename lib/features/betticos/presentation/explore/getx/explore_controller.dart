import 'package:betticos/core/models/paginated_response_data.dart';
import 'package:betticos/features/betticos/data/models/post/hashtag_model.dart';
import 'package:betticos/features/betticos/data/models/post/post_model.dart';
import 'package:betticos/features/betticos/domain/usecases/post/explore_posts.dart';
import 'package:betticos/features/betticos/domain/usecases/post/fetch_hashtags.dart';
import 'package:betticos/features/betticos/domain/usecases/post/search_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '/core/core.dart';
import '../../../data/models/listpage/listpage.dart';

enum Options { posts, sports, rates }

class ExploreController extends GetxController {
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
  PagingController<int, Post> pagingController =
      PagingController<int, Post>(firstPageKey: 1);

  PagingController<int, Post> searchPagingController =
      PagingController<int, Post>(firstPageKey: 1);

  RxString selectedHashtag = ''.obs;

  @override
  void onInit() {
    pagingController.addPageRequestListener((int pageKey) {
      getExplorePosts(pageKey);
    });
    super.onInit();
  }

  void getExplorePosts(int pageKey) async {
    pageK(pageKey);
    isLoading(true);
    final Either<Failure, PaginatedResponseData<Post>> failureOrResult =
        await explorePosts(
      PageParmas(
        page: pageK.value,
        size: 100,
        leagueId: 1,
      ),
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
    isLoading(true);
    final Either<Failure, PaginatedResponseData<Post>> failureOrResult =
        await searchPosts(
      SearchPageParams(
        keyword: selectedHashtag.value,
        page: pageK.value,
        size: 100,
      ),
    );
    failureOrResult.fold<void>(
      (Failure failure) {
        isLoading(false);
        searchPagingController.error = failure;
      },
      (PaginatedResponseData<Post> response) {
        isLoading(false);
        if (response.isLastPage) {
          searchPagingController.appendLastPage(response.data);
        } else {
          searchPagingController.appendPage(response.data, response.nextPage);
        }
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
    } else {
      selectedHashtag.value = '';
    }
  }
}
