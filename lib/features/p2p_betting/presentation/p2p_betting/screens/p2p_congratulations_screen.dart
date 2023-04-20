import 'package:betticos/core/core.dart';
import 'package:betticos/features/p2p_betting/data/models/bettor/bettor.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2PBettingCongratScreen extends StatefulWidget {
  const P2PBettingCongratScreen({
    Key? key,
  }) : super(key: key);
  @override
  _P2PBettingCongratScreenState createState() => _P2PBettingCongratScreenState();
}

class _P2PBettingCongratScreenState extends State<P2PBettingCongratScreen> {
  final P2PBetController p2pBetController = Get.find<P2PBetController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Congratulation! 🎉',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.colors.success,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const AppSpacing(v: 8),
            Text(
              'You have placed the bet successfully.\nGood luck to you.',
              style: TextStyle(
                color: context.colors.text,
                fontWeight: FontWeight.w600,
                fontSize: 12,
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
                        padding: AppPaddings.sA,
                        decoration: BoxDecoration(
                          border: p2pBetController.bet.value.creator.team !=
                                  p2pBetController.liveScore.value.localTeam.data.name
                              ? null
                              : Border.all(
                                  color: context.colors.primary,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Image.network(
                            p2pBetController.liveScore.value.localTeam.data.logo,
                            height: 45,
                            width: 45,
                          ),
                        ),
                      ),
                      const AppSpacing(v: 8),
                      Text(
                        p2pBetController.liveScore.value.localTeam.data.name,
                        style: TextStyle(
                          color: context.colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Vrs',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 60,
                        width: 60,
                        padding: AppPaddings.sA,
                        decoration: BoxDecoration(
                          border: p2pBetController.bet.value.creator.team !=
                                  p2pBetController.liveScore.value.visitorTeam.data.name
                              ? null
                              : Border.all(
                                  color: context.colors.primary,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Image.network(
                            p2pBetController.liveScore.value.visitorTeam.data.logo,
                            height: 45,
                            width: 45,
                          ),
                        ),
                      ),
                      const AppSpacing(v: 8),
                      Text(
                        p2pBetController.liveScore.value.visitorTeam.data.name,
                        style: TextStyle(
                          color: context.colors.black,
                          fontSize: 12,
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
                      const Text(
                        'Choice: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        p2pBetController.bet.value.creator.choice.stringValue.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.colors.success,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Potential Reward: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '\$${p2pBetController.bet.value.amount * 2}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.colors.success,
                          fontSize: 12,
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
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Back Home'.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
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
