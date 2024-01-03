import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembersController extends GetxController {
  MembersController({required this.getMyMembers});

  final GetMyMembers getMyMembers;

  RxList<User> myMembers = <User>[].obs;
  RxBool isLoading = false.obs;

  void loadAllMyMembers(BuildContext context) async {
    isLoading(true);

    final Either<Failure, List<User>> failureOrMembers = await getMyMembers(NoParams());

    failureOrMembers.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<User> value) {
        isLoading(false);
        myMembers(value);
      },
    );
  }
}
