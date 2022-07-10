// ignore_for_file: always_specify_types, use_full_hex_values_for_flutter_colors

import 'package:betticos/features/p2p_betting/presentation/livescore/screens/livescore_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '/core/presentation/utils/app_endpoints.dart';
import '/features/betticos/presentation/base/getx/base_screen_controller.dart';
import '/features/betticos/presentation/bet_competition/screens/bet_competition_screen.dart';
import '/features/betticos/presentation/members/screens/members_screen.dart';
import '/features/betticos/presentation/oddsbox/screens/oddsbox_screen.dart';
import '/features/betticos/presentation/oddsters/screens/oddsters_screen.dart';
import '/features/betticos/presentation/payments/screens/payments_screen.dart';
import '/features/betticos/presentation/profile/screens/profile_screen.dart';
import '/features/betticos/presentation/timeline/screens/timeline_screen.dart';
import '../../../../settings/presentation/settings/screens/settings_screen.dart';
import '../../referral/screens/referral_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);
  @override
  BaseScreenState createState() => BaseScreenState();
}

class BaseScreenState extends State<BaseScreen> {
  final BaseScreenController controller = Get.find<BaseScreenController>();

  KFDrawerController? _drawerController;

  @override
  void initState() {
    super.initState();

    _drawerController = KFDrawerController(
      initialPage: TimelineScreen(),
      items: <KFDrawerItem>[
        KFDrawerItem.initWithPage(
          text: Text(
            'timeline'.tr.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: AppFonts.base,
            ),
          ),
          icon: const Icon(
            Icons.home,
            color: Colors.white,
            size: 20,
          ),
          page: TimelineScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'profile'.tr.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: AppFonts.base,
            ),
          ),
          icon: const Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            _drawerController?.close!();
            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    ProfileScreen(showBackButton: true),
              ),
            );
          },
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'odd_box'.tr.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: AppFonts.base,
            ),
          ),
          icon: const Icon(
            Ionicons.gift_outline,
            color: Colors.white,
            size: 20,
          ),
          page: OddsboxScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'members'.tr.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: AppFonts.base,
            ),
          ),
          icon: const Icon(
            Icons.supervised_user_circle,
            color: Colors.white,
            size: 20,
          ),
          page: MembersScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'oddsters'.tr.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: AppFonts.base,
            ),
          ),
          icon: const Icon(
            Icons.trending_up,
            color: Colors.white,
            size: 20,
          ),
          page: OddstersScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'payments'.tr.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: AppFonts.base,
            ),
          ),
          icon: const Icon(
            Ionicons.cash_outline,
            color: Colors.white,
            size: 20,
          ),
          page: PaymentsScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'bet_comp'.tr.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: AppFonts.base,
            ),
          ),
          icon: const Icon(
            Ionicons.football_outline,
            color: Colors.white,
            size: 20,
          ),
          page: BetCompetitionScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'p2p_bet'.tr.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: AppFonts.base,
            ),
          ),
          icon: Image.asset(
            'assets/images/betting.png',
            color: Colors.white,
            height: 20,
            width: 20,
          ),
          page: LiveScoreScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'refer_friend'.tr.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: AppFonts.base,
            ),
          ),
          icon: const Icon(
            Ionicons.share_social_sharp,
            color: Colors.white,
            size: 20,
          ),
          page: ReferralScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'settings'.tr.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: AppFonts.base,
            ),
          ),
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
            size: 20,
          ),
          page: SettingsScreen(),
        ),
        if (controller.user.value.role == 'user')
          KFDrawerItem(
            text: Text(
              'become_oddster'.tr.toUpperCase(),
              style: context.caption.copyWith(
                color: Colors.white,
                fontFamily: AppFonts.base,
              ),
            ),
            icon: const Icon(
              Ionicons.person_outline,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Get.toNamed<void>(AppRoutes.login);
            },
          ),
        KFDrawerItem(
          text: Text(
            'logout'.tr.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: AppFonts.base,
            ),
          ),
          icon: const Icon(
            Ionicons.log_out_outline,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => showLogoutDialog(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            margin: AppPaddings.bodyB,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Obx(() {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          ProfileScreen(showBackButton: true),
                    ),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: NetworkImage(
                              '${AppEndpoints.userImages}/${controller.user.value.photo}',
                              headers: {
                                'Authorization':
                                    'Bearer ${controller.userToken.value}',
                              }),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${controller.user.value.firstName} ${controller.user.value.lastName}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '@${controller.user.value.username}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffca8442a), Color(0xFFFDBE13)],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }

  void showLogoutDialog(
    BuildContext context, {
    String? title,
    Icon? icon,
  }) {
    showAppModal<void>(
      context: context,
      alignment: Alignment.center,
      builder: (BuildContext context) => AppOptionDialogueModal(
        modalContext: context,
        title: 'logout'.tr,
        iconData: Ionicons.log_out_outline,
        backgroundColor: context.colors.error,
        message: 'sure_logout'.tr,
        affirmButtonText: 'logout'.tr.toUpperCase(),
        onPressed: () => controller.logOutTheUser(context),
      ),
    );
  }
}
