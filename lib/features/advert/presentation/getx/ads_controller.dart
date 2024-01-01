import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:betticos/features/presentation.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class AdsController extends GetxController {
  AdsController({required this.createAdvert, required this.getAllAdverts});

  final CreateAdvert createAdvert;
  final GetAllAdverts getAllAdverts;

  RxInt currentStep = 0.obs;
  Rx<RangeValues> rangeValues = const RangeValues(18, 65).obs;
  RxList<CountryCode> countries = <CountryCode>[].obs;
  Rx<Gender> gender = Gender.both.obs;
  Rx<SpecialCategoryType> category = SpecialCategoryType.unknown.obs;
  RxBool isSpecialAdCategory = false.obs;
  RxBool runUntilPaused = false.obs;
  Rx<Post> post = Post.empty().obs;
  RxInt budget = 10.obs;
  RxInt duration = 3.obs;
  RxInt maxAmount = 1000.obs;
  Rx<Category> selectedCategory = Category.other.obs;
  RxString location = 'Ghana'.obs;
  Rx<Target> target = Target.views.obs;
  RxList<Advert> adverts = <Advert>[].obs;
  RxDouble estimatedReach = 0.0.obs;
  RxBool isCreatingAd = false.obs;
  RxBool isFetchingAds = false.obs;

  final BaseScreenController baseScreenController = Get.find<BaseScreenController>();
  final TimelineController timelineController = Get.find<TimelineController>();
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void onInit() {
    super.onInit();
    fetchAdverts();
  }

  void addCountry(CountryCode? code) {
    if (code != null && !countryExists(code)) {
      countries.add(code);
    }
  }

  bool countryExists(CountryCode code) {
    final CountryCode? value = countries.firstWhereOrNull((CountryCode c) => c.name == code.name);
    if (value != null) {
      return true;
    }
    return false;
  }

  void removeCountry(CountryCode code) {
    countries.remove(code);
  }

  void addAdvert(BuildContext context) async {
    isCreatingAd.value = true;

    if (post.value.id.isEmpty) {
      return AppSnacks.show(context, message: 'Post for ad was not selected');
    }

    final Either<Failure, Advert> failureOrSuccess = await createAdvert(
      CreateAdvertRequest(
        post: post.value.id,
        budget: budget.value,
        ageRange: AgeRange(minimum: rangeValues.value.start.toInt(), maximum: rangeValues.value.end.toInt()),
        category: selectedCategory.value,
        target: target.value,
        gender: gender.value,
        location: location.value,
        duration: duration.value,
      ),
    );

    failureOrSuccess.fold(
      (Failure failure) {
        isCreatingAd.value = false;
      },
      (Advert ad) {
        isCreatingAd.value = false;
        navigationController.popUntil(AppRoutes.timeline);
        timelineController.updatePostListView(post.value.id, ad.post, isOddbox: post.value.isOddbox);
        profileController.updatePost(post.value.id, ad.post, isOddbox: post.value.isOddbox);
        AppSnacks.show(
          context,
          message: 'You have successfully created an ad.',
          leadingIcon: const Icon(Ionicons.checkmark_circle_sharp, color: Colors.white, size: 20),
          backgroundColor: context.colors.success,
        );
      },
    );
  }

  void fetchAdverts() async {
    isFetchingAds.value = true;

    final Either<Failure, List<Advert>> failureOrBets = await getAllAdverts(NoParams());

    failureOrBets.fold<void>(
      (Failure failure) => isFetchingAds.value = false,
      (List<Advert> ads) {
        isFetchingAds.value = false;
        adverts.value = ads;
      },
    );
  }

  void estimateReach() {
    final Setup setup = baseScreenController.setup.value;
    if (target.value == Target.views) {
      final double cost = setup.viewCost;
      final int period = setup.viewPeriod;
      final int expectedReach = setup.expectedViews;
      final double reachPerUnitCost = expectedReach / cost;
      estimatedReach.value = ((budget.value * period) / duration.value) * reachPerUnitCost;
    } else if (target.value == Target.clicks) {
      final double cost = setup.clickCost;
      final int period = setup.clickPeriod;
      final int expectedReach = setup.expectedClicks;
      final double reachPerUnitCost = expectedReach / cost;
      estimatedReach.value = ((budget.value * period) / duration.value) * reachPerUnitCost;
    } else if (target.value == Target.engagements) {
      final double cost = setup.engagementCost;
      final int period = setup.engagementPeriod;
      final int expectedReach = setup.expectedEngagement;
      final double reachPerUnitCost = expectedReach / cost;
      estimatedReach.value = ((budget.value * period) / duration.value) * reachPerUnitCost;
    }
  }

  void reset() {
    post.value = Post.empty();
    budget.value = 1;
    duration.value = 1;
    gender.value = Gender.both;
    location.value = 'Ghana';
  }
}
