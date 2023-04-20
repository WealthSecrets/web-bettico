import 'package:betticos/features/onboarding_splash/presentation/onbaording/getx/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/features/onboarding_splash/presentation/onbaording/widgets/onbaord_indicators.dart';
import '/features/onboarding_splash/presentation/onbaording/widgets/onboard_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  static const String route = 'OnboardingScreen';
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  final OnboardController controller = Get.find<OnboardController>();
  late final PageController pageController;
  late final ValueNotifier<int> activeIndexValueNotifier;
  late final ValueNotifier<double> pageOffsetValueNotifier;

  final List<String> onBoardTexts = <String>[
    '${'follow_oddsters'.tr}\n${'sure_bet'.tr}\n${'exclusive_odds'.tr}',
    '${'get_slip_code'.tr}\n${'strategized'.tr}\n${'success'.tr}',
    '${'win_bet'.tr}\n${'be_happy'.tr}\n${'be_happy'.tr}',
  ];
  final List<String> onBoardAssets = <String>[
    AssetSVGs.follow.path,
    AssetSVGs.slipCode.path,
    AssetSVGs.win.path,
  ];

  @override
  void initState() {
    activeIndexValueNotifier = ValueNotifier<int>(0);
    pageOffsetValueNotifier = ValueNotifier<double>(0.0);
    pageController = PageController();
    pageController.addListener(() {
      pageOffsetValueNotifier.value = activeIndexValueNotifier.value - (pageController.page ?? 0.0);
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    activeIndexValueNotifier.dispose();
    pageOffsetValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: activeIndexValueNotifier,
      builder: (BuildContext context, int activeIndex, _) {
        return Scaffold(
            body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: ValueListenableBuilder<double>(
                      valueListenable: pageOffsetValueNotifier,
                      builder: (BuildContext context, double pageOffset, _) {
                        return PageView(
                          physics: const BouncingScrollPhysics(),
                          onPageChanged: (int index) => activeIndexValueNotifier.value = index,
                          controller: pageController,
                          children: List<Widget>.generate(
                            onBoardTexts.length,
                            (int index) => OnboardCard(
                              index: index,
                              isPrevious: pageOffset < index,
                              isActive: index == activeIndex,
                              text: onBoardTexts[index].split('\n'),
                              svgAssetPath: onBoardAssets[index],
                            ),
                          ),
                        );
                      }),
                ),
                Expanded(
                  child: Padding(
                    padding: AppPaddings.bodyA,
                    child: Row(
                      children: <Widget>[
                        OnboardIndicators(
                          activeItem: activeIndex,
                          itemCount: onBoardTexts.length,
                          radius: 8,
                        ),
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            switchInCurve: Curves.fastLinearToSlowEaseIn,
                            child: Align(
                              key: ValueKey<bool>(activeIndex < 2),
                              alignment: Alignment.centerRight,
                              child: activeIndex < 2
                                  ? TextButton(
                                      onPressed: () => pageController.nextPage(
                                          duration: const Duration(milliseconds: 1200),
                                          curve: Curves.fastLinearToSlowEaseIn),
                                      child: Text(
                                        'skip'.tr,
                                        style: context.body2.copyWith(
                                          color: context.colors.primary,
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: MaterialButton(
                                        height: 50,
                                        color: context.colors.primary,
                                        elevation: 0.0,
                                        onPressed: () => controller.saveOnBoarded(),
                                        child: Text(
                                          'enter'.tr.toUpperCase(),
                                          style: context.body2.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
