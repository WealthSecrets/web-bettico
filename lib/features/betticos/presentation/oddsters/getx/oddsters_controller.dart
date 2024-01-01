import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OddstersController extends GetxController {
  OddstersController({
    required this.getAllOddsters,
    required this.searchAllOddsters,
  });

  final GetAllOddsters getAllOddsters;
  final SearchAllOddsters searchAllOddsters;

  RxList<User> oddsters = <User>[].obs;
  RxList<User> userSearchResults = <User>[].obs;
  RxBool isLoading = false.obs;
  RxBool isSearchOddsters = false.obs;
  RxInt tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex(index);
  }

  void loadAllOddsters(BuildContext context) async {
    isLoading(true);
    final Either<Failure, List<User>> failureOrOddsters = await getAllOddsters(NoParams());
    failureOrOddsters.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<User> value) {
        isLoading(false);
        oddsters(value);
      },
    );
  }

  void searchOddsters(BuildContext context, String query) async {
    isSearchOddsters(true);
    final Either<Failure, List<User>> failureOrOddsters = await searchAllOddsters(SearchUserRequest(query: query));
    failureOrOddsters.fold<void>(
      (Failure failure) {
        isSearchOddsters(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<User> value) {
        isSearchOddsters(false);
        userSearchResults(value);
      },
    );
  }
}
