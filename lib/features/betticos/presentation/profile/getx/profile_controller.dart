import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:betticos/features/presentation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart' as validator;

class ProfileController extends GetxController {
  ProfileController({
    required this.updateUser,
    required this.resolveUser,
    required this.updateUserProfilePhoto,
    required this.followUser,
    required this.subscribeToUser,
    required this.checkSubscription,
    required this.checkFollowing,
    required this.unfollowUser,
    required this.getMyFollowers,
    required this.getMyFollowings,
    required this.fetchMyPosts,
    required this.fetchMyOddboxes,
    required this.likePost,
    required this.dislikePost,
  });

  final UpdateUser updateUser;
  final ResolveUser resolveUser;
  final UpdateUserProfilePhoto updateUserProfilePhoto;
  final FollowUser followUser;
  final SubscribeToUser subscribeToUser;
  final UnfollowerUser unfollowUser;
  final GetMyFollowers getMyFollowers;
  final GetMyFollowings getMyFollowings;
  final FetchMyOddboxes fetchMyOddboxes;
  final FetchMyPosts fetchMyPosts;
  final CheckSubscription checkSubscription;
  final CheckFollowing checkFollowing;
  final LikePost likePost;
  final DislikePost dislikePost;

  // reactive variables
  RxBool isSignUpAsOddster = false.obs;
  RxBool isObscured = true.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString username = ''.obs;
  Rx<DateTime> dateOfBirth = DateTime.now().obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString country = ''.obs;
  RxString otpCode = ''.obs;
  RxString identificationType = ''.obs;
  RxString identificationNumber = ''.obs;
  Rx<DateTime> expiryDate = DateTime.now().obs;
  RxDouble uploadPercentage = 0.0.obs;
  Rx<Uint8List> docImage = Uint8List.fromList(<int>[]).obs;
  Rx<Uint8List> profileImage = Uint8List.fromList(<int>[]).obs;
  RxList<User> myFollowers = <User>[].obs;
  RxList<User> mySubscribers = <User>[].obs;
  RxList<User> myFollowings = <User>[].obs;
  RxList<User> myOddsterFollowings = <User>[].obs;
  RxList<Post> myPosts = <Post>[].obs;
  RxList<Post> myOddboxes = <Post>[].obs;
  RxBool isSubscribedToUser = false.obs;

  // loading state variables
  RxBool isLoading = false.obs;
  RxBool isFollowingUser = false.obs;
  RxBool isSubscribingToUser = false.obs;
  RxBool isCheckingSubscription = false.obs;
  RxBool isCheckingFollowing = false.obs;
  RxBool isUnfollowingUser = false.obs;
  RxBool isLoadingFollowers = false.obs;
  RxBool isLoadingSubscribers = false.obs;
  RxBool isLoadingFollowings = false.obs;
  RxBool isLoadingMyPosts = false.obs;
  RxBool isLoadingMyOddboxes = false.obs;
  RxBool isResolvingUser = false.obs;
  RxBool isLikingPost = false.obs;
  RxBool isDislikingPost = false.obs;
  RxBool isUpdatingUserProfile = false.obs;
  RxBool isFollowedByUser = false.obs;

  // get the loggedInUser
  Rx<User> user = User.empty().obs;
  Rx<String> userToken = Get.find<BaseScreenController>().userToken;

  // no reactive variables
  BuildContext? context;

  void toggleSignUpAsOddster() {
    isSignUpAsOddster(!isSignUpAsOddster.value);
  }

  void togglePasswordVisibility() {
    isObscured(!isObscured.value);
  }

  void updateTheUserProfilePhoto(BuildContext context) async {
    isLoading(true);

    final Either<Failure, User> fialureOrSuccess = await updateUserProfilePhoto(
      UpdatePhotoRequest(
        file: profileImage.value,
        onSendProgress: (int count, int total) {
          uploadPercentage(count / total);
        },
      ),
    );

    fialureOrSuccess.fold((Failure failure) {
      isLoading(false);
      AppSnacks.show(context, message: failure.message);
    }, (User value) {
      isLoading(false);
      user(value);
      Get.offNamed<void>(AppRoutes.base);
    });
  }

  void setProfileUser(User? u, {bool? performActions}) {
    if (u != null) {
      user(u);
    } else {
      final User ux = Get.find<BaseScreenController>().user.value;
      user(ux);
    }

    if (performActions ?? false) {
      performAllActions();
    }
  }

  void setUpdatingUserProfile(bool value) {
    isUpdatingUserProfile(value);
  }

  bool isNotLoggedInUser() {
    return user.value.id != Get.find<BaseScreenController>().user.value.id;
  }

  void performAllActions() {
    loadMyFollowers();
    loadMyFollowings();
    loadMyPosts();
    loadMyOddboxes();
    checkIfSubscribedToUser();
    checkIfFollowedByUser();
  }

  void followTheUser({User? u}) async {
    isFollowingUser(true);

    final Either<Failure, Follow> fialureOrSuccess = await followUser(
      UserRequest(userId: u?.id ?? user.value.id),
    );

    fialureOrSuccess.fold((Failure failure) {
      isFollowingUser(false);
      if (context != null) {
        AppSnacks.show(context!, message: failure.message);
      }
    }, (Follow _) {
      isFollowingUser(false);
      if (u != null) {
        final List<User> followings = List<User>.from(Get.find<BaseScreenController>().myFollowings);
        followings.add(u);
        Get.find<BaseScreenController>().myFollowings(followings);
      }
      isFollowedByUser(true);
    });
  }

  void subscribeToTheUser(BuildContext context, String userId) async {
    isSubscribingToUser(true);

    final Either<Failure, Subscription> fialureOrSuccess = await subscribeToUser(SubscribeRequest(userId: userId));

    fialureOrSuccess.fold((Failure failure) {
      isSubscribingToUser(false);
      AppSnacks.show(context, message: failure.message);
    }, (Subscription subscription) {
      isSubscribingToUser(false);
      if (subscription.userId.isEmpty || subscription.subscriberId.isEmpty) {
        isSubscribedToUser(false);
      } else {
        isSubscribedToUser(true);
      }
    });
  }

  void checkIfSubscribedToUser() async {
    isCheckingSubscription(true);

    final Either<Failure, Subscription> fialureOrSuccess = await checkSubscription(
      SubscribeRequest(userId: user.value.id),
    );

    fialureOrSuccess.fold((Failure failure) {
      isCheckingSubscription(false);
      if (context != null) {
        AppSnacks.show(context!, message: failure.message);
      }
    }, (Subscription subscription) {
      isCheckingSubscription(false);
      if (subscription.userId.isEmpty || subscription.subscriberId.isEmpty) {
        isSubscribedToUser(false);
      } else {
        isSubscribedToUser(true);
      }
    });
  }

  void checkIfFollowedByUser() async {
    isCheckingFollowing(true);

    final Either<Failure, Follow> fialureOrSuccess = await checkFollowing(
      UserRequest(userId: user.value.id),
    );

    fialureOrSuccess.fold((Failure failure) {
      isCheckingFollowing(false);
      if (context != null) {
        AppSnacks.show(context!, message: failure.message);
      }
    }, (Follow follow) {
      isCheckingFollowing(false);
      if (follow.userId.isEmpty || follow.followerId.isEmpty) {
        isFollowedByUser(false);
      } else {
        isFollowedByUser(true);
      }
    });
  }

  bool isFollowedByLoggedInUser(String userId, {User? user}) {
    User? u;
    if (user != null) {
      u = myFollowings.firstWhereOrNull((User u) => u.id == userId);
    } else {
      u = Get.find<BaseScreenController>().myFollowings.firstWhereOrNull((User u) => u.id == userId);
    }

    if (u != null) {
      return true;
    }
    return false;
  }

  void unfollowTheUser({User? u}) async {
    isUnfollowingUser(true);

    final Either<Failure, void> fialureOrSuccess = await unfollowUser(UserRequest(userId: u?.id ?? user.value.id));

    fialureOrSuccess.fold((Failure failure) {
      isUnfollowingUser(false);
      if (context != null) {
        AppSnacks.show(context!, message: failure.message);
      }
    }, (void _) {
      isUnfollowingUser(false);
      if (u != null) {
        final List<User> followings = List<User>.from(Get.find<BaseScreenController>().myFollowings);
        followings.removeWhere((User e) => e.id == u.id);
        Get.find<BaseScreenController>().myFollowings(followings);
      }
      isFollowedByUser(false);
      // if (user != null && user.role == 'oddster') {
      //   myOddsterFollowings.removeWhere((User u) => u.id == user.id);
      // }
      // loadMyFollowers(context, userId);
    });
  }

  void loadMyFollowers() async {
    isLoadingFollowers(true);
    resetValues();

    final Either<Failure, List<User>> fialureOrSuccess = await getMyFollowers(UserRequest(userId: user.value.id));

    fialureOrSuccess.fold((Failure failure) {
      isLoadingFollowers(false);
      if (context != null) {
        AppSnacks.show(context!, message: failure.message);
      }
    }, (List<User> followers) {
      isLoadingFollowers(false);
      myFollowers(followers);
    });
  }

  void loadMyFollowings() async {
    isLoadingFollowings(true);
    resetValues();

    final Either<Failure, List<User>> fialureOrSuccess = await getMyFollowings(UserRequest(userId: user.value.id));

    fialureOrSuccess.fold((Failure failure) {
      isLoadingFollowings(false);
      if (context != null) {
        AppSnacks.show(context!, message: failure.message);
      }
    }, (List<User> followers) {
      isLoadingFollowings(false);
      myFollowings(followers);
    });
  }

  void loadMyPosts() async {
    isLoadingMyPosts(true);
    resetValues();

    final Either<Failure, List<Post>> fialureOrSuccess =
        await fetchMyPosts(MyPostsOrOddboxesRequest(userId: user.value.id));

    fialureOrSuccess.fold((Failure failure) {
      isLoadingMyPosts(false);
      if (context != null) {
        AppSnacks.show(context!, message: failure.message);
      }
    }, (List<Post> posts) {
      isLoadingMyPosts(false);
      myPosts(posts);
    });
  }

  void loadMyOddboxes() async {
    isLoadingMyOddboxes(true);
    resetValues();

    final Either<Failure, List<Post>> fialureOrSuccess =
        await fetchMyOddboxes(MyPostsOrOddboxesRequest(userId: user.value.id));

    fialureOrSuccess.fold((Failure failure) {
      isLoadingMyOddboxes(false);
      if (context != null) {
        AppSnacks.show(context!, message: failure.message);
      }
    }, (List<Post> oddboxes) {
      isLoadingMyOddboxes(false);
      myOddboxes(oddboxes);
    });
  }

  List<User> getFollowingOddsters() {
    return myFollowings.where((User user) => user.role == 'oddster').toList();
  }

  bool myFollowingLikedPost(List<String> likeUsers) {
    for (int i = 0; i < likeUsers.length; i++) {
      final User? ud = myFollowings.firstWhereOrNull((User u) => u.id == likeUsers[i]);
      if (ud != null) {
        return true;
      }
    }
    return false;
  }

  String myFollowingWhoLikedPost(List<String> likeUsers) {
    for (int i = 0; i < likeUsers.length; i++) {
      final User? ud = myFollowings.firstWhereOrNull((User u) => u.id == likeUsers[i]);
      if (ud != null) {
        return '${ud.firstName} ${ud.lastName}';
      }
    }
    return '';
  }

  bool checkIfFollowingUser(User user) {
    final User? foundUser = myFollowings.firstWhereOrNull((User u) => u.id == user.id);
    return foundUser == null ? false : true;
  }

  void navigateToHomeOrOTP() {
    if (isSignUpAsOddster.value) {
      Get.toNamed<void>(AppRoutes.otpVerify);
    } else {
      Get.toNamed<void>(AppRoutes.mainWidget);
    }
  }

  Future<Either<Failure, User>> updateProfile(BuildContext context) async {
    isUpdatingUserProfile(true);

    final Either<Failure, User> failureOrUser = await updateUser(
      UpdateRequest(
        firstName: firstName.value.isEmpty ? null : firstName.value,
        lastName: lastName.value.isEmpty ? null : lastName.value,
        username: username.value.isEmpty ? null : username.value,
        phone: phone.value.isEmpty ? null : phone.value,
        country: country.value.isEmpty ? null : country.value,
      ),
    );
    return failureOrUser;
  }

  void resetValues() {
    myFollowers(<User>[]);
    myFollowings(<User>[]);
    myPosts(<Post>[]);
    myOddboxes(<Post>[]);
    isSubscribedToUser(false);
  }

  void setUserDetails(User user) {
    email(user.email);
    firstName(user.firstName);
    lastName(user.lastName);
    username(user.username);
    dateOfBirth(user.dateOfBirth);
    phone(user.phone);
  }

  void removePostFromMyPosts(String id) {
    final List<Post> thePosts = List<Post>.from(myPosts);
    thePosts.removeWhere((Post p) => p.id == id);
    myPosts(thePosts);
  }

  void onEmailInputChanged(String value) {
    email(value);
  }

  void onFirstNameInputChanged(String value) {
    firstName(value);
  }

  void onLastNameInputChanged(String value) {
    lastName(value);
  }

  void onUserNameInputChanged(String value) {
    username(value);
  }

  void onDateOfBirthInputChanged(DateTime value) {
    dateOfBirth(value);
  }

  void onPhoneInputChanged(String? number, String? isoCode) {
    if (number != null) {
      phone.value = number;
    }
    if (isoCode != null) {
      country.value = isoCode;
    }
  }

  void onExpiryDateInputChanged(DateTime value) {
    expiryDate(value);
  }

  void onFileSelected(Uint8List? file) {
    docImage(file);
  }

  void onProfileImageSelected(Uint8List? file) {
    profileImage(file);
  }

  String? validateFirstName(String? firstName) {
    String? errorMessage;
    if (firstName!.isEmpty) {
      errorMessage = 'Please enter your first name.';
    }

    return errorMessage;
  }

  String? validateLastName(String? lastName) {
    String? errorMessage;
    if (lastName!.isEmpty) {
      errorMessage = 'Please enter your last name.';
    }
    return errorMessage;
  }

  String? validateUserName(String? username) {
    String? errorMessage;
    if (username!.isEmpty) {
      errorMessage = 'Please enter your username.';
    }
    return errorMessage;
  }

  String? validatePhone(String? phone) {
    String? errorMessage;
    if (phone!.isEmpty) {
      errorMessage = 'Please enter your phone number.';
    }
    return errorMessage;
  }

  String? validateLocation(String? location) {
    String? errorMessage;
    if (location!.isEmpty) {
      errorMessage = 'Please enter your location';
    }
    return errorMessage;
  }

  String? validateIdentificationNumber(String? idNumber) {
    String? errorMessage;
    if (idNumber!.isEmpty) {
      errorMessage = 'Please enter the identification number.';
    }
    return errorMessage;
  }

  String? validateEmail(String? email) {
    String? errorMessage;
    if (email!.isEmpty) {
      errorMessage = 'Please enter email address';
    }

    if (!validator.isEmail(email.trim())) {
      errorMessage = 'Invalid email';
    }

    return errorMessage;
  }

  String? validateMinimumAge({
    required DateTime dateOfBirth,
    required int minimumAge,
    String? errorMessage,
  }) {
    if ((DateTime.now().difference(dateOfBirth).inDays / 365).round() < minimumAge) {
      return errorMessage ?? 'You should be at least $minimumAge years old';
    }

    return null;
  }

  String? validateExpiryDate(DateTime? expiringDate) {
    if (expiringDate == null) {
      return 'Please select date';
    }
    if (expiringDate.isBefore(DateTime.now().add(const Duration(days: 30)))) {
      return 'Expiring date is too close';
    }
    return null;
  }

  void likeThePost(BuildContext context, String postId, String userId, {bool isOddbox = false}) async {
    isLikingPost(true);

    Post? post;

    if (isOddbox) {
      post = myOddboxes.firstWhereOrNull((Post p) => p.id == postId);
    } else {
      post = myPosts.firstWhereOrNull((Post p) => p.id == postId);
    }

    if (post != null) {
      final Either<Failure, Post> failureOrPost = await likePost(
        LikeDislikePostParams(
          postId: postId,
          user: userId,
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

          if (isOddbox) {
            final int postIndex = myOddboxes.indexOf(post);
            myOddboxes[postIndex] = pst;
          } else {
            final int postIndex = myPosts.indexOf(post);
            myPosts[postIndex] = pst;
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

  void updatePost(String postId, Post pst, {bool isOddbox = false}) {
    Post? post;

    if (isOddbox) {
      post = myOddboxes.firstWhereOrNull((Post p) => p.id == postId);
    } else {
      post = myPosts.firstWhereOrNull((Post p) => p.id == postId);
    }
    if (isOddbox) {
      final int postIndex = myOddboxes.indexOf(post);
      myOddboxes[postIndex] = pst;
    } else {
      final int postIndex = myPosts.indexOf(post);
      myPosts[postIndex] = pst;
    }
  }

  void dislikeThePost(BuildContext context, String postId, String userId, {bool isOddbox = false}) async {
    isLikingPost(true);

    Post? post;

    if (isOddbox) {
      post = myOddboxes.firstWhereOrNull((Post p) => p.id == postId);
    } else {
      post = myPosts.firstWhereOrNull((Post p) => p.id == postId);
    }

    if (post != null) {
      final Either<Failure, Post> failureOrPost = await dislikePost(
        LikeDislikePostParams(
          postId: postId,
          user: userId,
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

          if (isOddbox) {
            final int postIndex = myOddboxes.indexOf(post);
            myOddboxes[postIndex] = pst;
          } else {
            final int postIndex = myPosts.indexOf(post);
            myPosts[postIndex] = pst;
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

  bool get formIsValid => validateEmail(email.value) == null;
}
