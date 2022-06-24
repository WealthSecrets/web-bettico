import 'package:betticos/core/core.dart';
import 'package:betticos/features/p2p_betting/data/models/bettor/bettor.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/arguments/p2p_congrats_argument.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';

class P2PBettingCongratScreen extends StatefulWidget {
  const P2PBettingCongratScreen({
    Key? key,
  }) : super(key: key);

  @override
  _P2PBettingCongratScreenState createState() =>
      _P2PBettingCongratScreenState();
}

class _P2PBettingCongratScreenState extends State<P2PBettingCongratScreen> {
  final P2PBetController p2pBetController = Get.find<P2PBetController>();

  final P2PCongratsArgument? args = Get.arguments as P2PCongratsArgument?;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // SizedBox(
            //   height: 100,
            //   child: Lottie.asset('assets/json/checked.json'),
            // ),
            // const AppSpacing(v: 40),
            Text(
              'Congratulation! 🎉',
              style: context.h6.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.success,
              ),
              textAlign: TextAlign.center,
            ),
            const AppSpacing(v: 8),
            Text(
              'You have placed the bet successfully.\nGood luck to you.',
              style: context.caption.copyWith(
                color: context.colors.text,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const AppSpacing(v: 16),
            Padding(
              padding: AppPaddings.bodyH.add(AppPaddings.lV),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: 60,
                        width: 60,
                        // padding: AppPaddings.sA,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: null,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        // child: SizedBox(
                        //   height: 40,
                        //   width: 40,
                        //   child: SvgPicture.asset(
                        //     'assets/svgs/leicester-city-fc.svg',
                        //   ),
                        // ),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: args?.isFixture ?? false
                              ? p2pBetController.bet.value.creator.team ==
                                      p2pBetController.fixture.value.awayName
                                  ? context.colors.primary
                                  : context.colors.text
                              : p2pBetController.bet.value.creator.team ==
                                      p2pBetController.match.value.awayName
                                  ? context.colors.primary
                                  : context.colors.text,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Text(
                              StringUtils.getInitials(
                                args?.isFixture ?? false
                                    ? p2pBetController.fixture.value.awayName
                                    : p2pBetController.match.value.awayName,
                              ),
                              style: context.body2.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const AppSpacing(v: 8),
                      Text(
                        args?.isFixture ?? false
                            ? p2pBetController.fixture.value.awayName
                            : p2pBetController.match.value.awayName,
                        style: context.caption.copyWith(
                          color: context.colors.black,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Vrs',
                    style: context.h6.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 60,
                        width: 60,
                        // padding: AppPaddings.sA,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(
                          //   color: context.colors.primary,
                          //   width: 2,
                          //   style: BorderStyle.solid,
                          // ),
                          border: null,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: args?.isFixture ?? false
                              ? p2pBetController.bet.value.creator.team ==
                                      p2pBetController.fixture.value.homeName
                                  ? context.colors.primary
                                  : context.colors.text
                              : p2pBetController.bet.value.creator.team ==
                                      p2pBetController.match.value.homeName
                                  ? context.colors.primary
                                  : context.colors.text,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Text(
                              StringUtils.getInitials(
                                args?.isFixture ?? false
                                    ? p2pBetController.fixture.value.homeName
                                    : p2pBetController.match.value.homeName,
                              ),
                              style: context.body2.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const AppSpacing(v: 8),
                      Text(
                        args?.isFixture ?? false
                            ? p2pBetController.fixture.value.homeName
                            : p2pBetController.match.value.homeName,
                        style: context.caption.copyWith(
                          color: context.colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const AppSpacing(v: 20),
            Padding(
              padding: AppPaddings.bodyH,
              child: Row(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Choice: ',
                        style: context.caption.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        p2pBetController.bet.value.creator.choice.stringValue
                            .toUpperCase(),
                        style: context.caption.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colors.success,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Potential Reward: ',
                        style: context.caption.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${p2pBetController.bet.value.amount}',
                        style: context.caption.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colors.success,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const AppSpacing(v: 100),
            Padding(
              padding: AppPaddings.bodyH,
              child: AppButton(
                enabled: true,
                borderRadius: AppBorderRadius.largeAll,
                onPressed: () => Get.back<void>(),
                child: Text(
                  'Back Home'.toUpperCase(),
                  style: context.body2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
