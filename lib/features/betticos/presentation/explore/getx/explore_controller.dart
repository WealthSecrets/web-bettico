import 'package:betticos/features/betticos/data/models/post/post_model.dart';
import 'package:betticos/features/betticos/domain/usecases/post/explore_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '/core/core.dart';
import '../../../data/models/listpage/listpage.dart';

class ExploreController extends GetxController {
  ExploreController({
    required this.explorePosts,
  });

  final ExplorePosts explorePosts;

  RxList<Post> posts = <Post>[].obs;
  RxBool isLoading = false.obs;
  RxBool isCompleted = false.obs;

  RxInt pageK = 1.obs;
  Rx<ListPage<Post>> postsL = ListPage<Post>.empty().obs;
  Rx<PagingController<int, Post>> pagingController =
      PagingController<int, Post>(firstPageKey: 1).obs;

  @override
  void onInit() {
    pagingController.value.addPageRequestListener((int pageKey) {
      getExplorePosts(pageKey);
    });
    super.onInit();
  }

  void getExplorePosts(int pageKey) async {
    pageK(pageKey);
    isLoading(true);
    final Either<Failure, ListPage<Post>> failureOrResult = await explorePosts(
      PageParmas(
        page: pageK.value,
        size: 100,
        leagueId: 1,
      ),
    );
    failureOrResult.fold<void>(
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
}
