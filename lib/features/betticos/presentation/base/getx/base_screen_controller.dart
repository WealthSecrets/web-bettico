import 'package:betticos/features/auth/domain/usecases/logout_user.dart';
import 'package:betticos/features/betticos/data/models/setup/setup_model.dart';
import 'package:betticos/features/betticos/domain/usecases/load_token.dart';
import 'package:betticos/features/betticos/domain/usecases/setup/get_setup.dart';
import 'package:betticos/features/betticos/domain/usecases/update_user_device.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/user_bonus_request.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/bet/update_user_bonus.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/domain/usecases/load_user.dart';
import '../../../domain/requests/follow/user_request.dart';
import '../../../domain/requests/user/user_device_request.dart';
import '../../../domain/usecases/follow/get_my_followers.dart';
import '../../../domain/usecases/follow/get_my_followings.dart';

class BaseScreenController extends GetxController {
  BaseScreenController({
    required this.loadUser,
    required this.loadToken,
    required this.logoutUser,
    required this.getMyFollowers,
    required this.updateUserBonus,
    required this.updateUserDevice,
    required this.getMyFollowings,
    required this.getSetup,
  });
  final LoadUser loadUser;
  final LoadToken loadToken;
  final LogoutUser logoutUser;
  final UpdateUserBonus updateUserBonus;
  final GetMyFollowers getMyFollowers;
  final UpdateUserDevice updateUserDevice;
  final GetMyFollowings getMyFollowings;
  final GetSetup getSetup;

  Rx<User> user = User.empty().obs;
  Rx<String> userToken = ''.obs;
  Rx<Setup> setup = Setup.empty().obs;
  RxBool isLoading = false.obs;
  RxBool isUpdatingUserBonus = false.obs;
  RxList<User> myFollowers = <User>[].obs;
  RxList<User> myFollowings = <User>[].obs;
  RxBool isLoggingOut = false.obs;
  RxBool isGettingSetup = false.obs;
  RxString device = ''.obs;

  @override
  void onInit() {
    loadUserFromToken();
    loadUserToken();
    fetchSetup();
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

  void increaseDecreaseUserBonus(
    BuildContext context,
    String type,
    double amount, {
    void Function()? failureCallback,
    void Function()? successCallback,
  }) async {
    isUpdatingUserBonus.value = true;
    final Either<Failure, User> failureOrUser = await updateUserBonus(
      UserBonusRequest(
        type: type,
        amount: amount,
      ),
    );

    failureOrUser.fold((Failure failure) {
      isUpdatingUserBonus(false);
      // failureCallback?.call() Do not call failure call back since user can choose from option
      AppSnacks.show(context, message: failure.message);
    }, (User u) {
      isUpdatingUserBonus(false);
      user.value = u;
      successCallback?.call();
    });
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

  void fetchSetup() async {
    isGettingSetup(true);
    final Either<Failure, Setup> failureOrSetup = await getSetup(NoParams());
    failureOrSetup.fold<void>(
      (Failure failure) {
        isGettingSetup(false);
      },
      (Setup set) {
        isGettingSetup(false);
        setup(set);
      },
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

  bool isYou(String? userId) {
    if (userId == null) {
      return false;
    }
    return user.value.id == userId;
  }

  void logOutTheUser(BuildContext context) async {
    isLoggingOut.value = true;
    final Either<Failure, void> failureOrVoid = await logoutUser(NoParams());
    failureOrVoid.fold<void>(
      (Failure failure) {
        isLoggingOut.value = false;
        AppSnacks.show(context, message: failure.message);
      },
      (void _) {
        isLoggingOut.value = false;
        userToken.value = '';
        user.value = User.empty();
        Get.back<void>();
        menuController.changeActiveItemTo(AppRoutes.explore);
      },
    );
  }

  void updateUserDeviceInfo(String? dvic) async {
    if (dvic != null) {
      final Either<Failure, User> failureOrUser =
          await updateUserDevice(UserDeviceRequest(device: dvic));
      failureOrUser.fold((_) {}, (User user) {
        if (user.device != null) {
          device.value = user.device!;
        }
      });
    }
  }

  bool get isLoggedIn => userToken.value.isNotEmpty;
}
