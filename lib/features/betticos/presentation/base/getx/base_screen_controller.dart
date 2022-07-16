import 'package:betticos/features/auth/domain/usecases/logout_user.dart';
import 'package:betticos/features/auth/presentation/login/screens/login_screen.dart';
import 'package:betticos/features/betticos/domain/usecases/load_token.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/domain/usecases/load_user.dart';
import '../../../domain/requests/follow/user_request.dart';
import '../../../domain/usecases/follow/get_my_followers.dart';
import '../../../domain/usecases/follow/get_my_followings.dart';

class BaseScreenController extends GetxController {
  BaseScreenController({
    required this.loadUser,
    required this.loadToken,
    required this.logoutUser,
    required this.getMyFollowers,
    required this.getMyFollowings,
  });
  final LoadUser loadUser;
  final LoadToken loadToken;
  final LogoutUser logoutUser;
  final GetMyFollowers getMyFollowers;
  final GetMyFollowings getMyFollowings;

  Rx<User> user = User.empty().obs;
  Rx<String> userToken = ''.obs;
  RxBool isLoading = false.obs;
  RxList<User> myFollowers = <User>[].obs;
  RxList<User> myFollowings = <User>[].obs;

  static BaseScreenController instance = Get.find();

  @override
  void onInit() {
    loadUserFromToken();
    loadUserToken();
    super.onInit();
  }

  void loadUserFromToken() async {
    final Either<Failure, User> failureOrUser = await loadUser(NoParams());
    failureOrUser.fold<void>(
      (Failure failure) {},
      (User value) {
        user(value);
        loadMyFollowers();
        loadMyFollowings();
      },
    );
  }

  void changeLanguage(Locale locale) {
    Get.updateLocale(locale);
  }

  void loadUserToken() async {
    final Either<Failure, String> failureOrUser = await loadToken(NoParams());
    failureOrUser.fold<void>(
      (Failure failure) {},
      (String token) => userToken(token),
    );
  }

  void loadMyFollowers() async {
    final Either<Failure, List<User>> fialureOrSuccess =
        await getMyFollowers(UserRequest(userId: user.value.id));

    fialureOrSuccess.fold(
        (_) {}, (List<User> followers) => myFollowers(followers));
  }

  void loadMyFollowings() async {
    final Either<Failure, List<User>> fialureOrSuccess =
        await getMyFollowings(UserRequest(userId: user.value.id));

    fialureOrSuccess.fold(
        (_) {}, (List<User> followers) => myFollowings(followers));
  }

  void updateTheUser(User u) {
    user(u);
  }

  void logOutTheUser(BuildContext context) async {
    final Either<Failure, void> failureOrVoid = await logoutUser(NoParams());
    failureOrVoid.fold<void>(
      (Failure failure) => AppSnacks.show(context, message: failure.message),
      (void _) {
        Get.offAllNamed<void>(LoginScreen.route);
      },
    );
  }
}
