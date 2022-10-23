import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/p2p_betting_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../auth/data/models/user/user.dart';
import '../../livescore/getx/live_score_controllers.dart';

enum ConnectionState {
  disconnected,
  connecting,
  connected,
  connectionFailed,
  connectionCancelled,
}

class P2PBettingScreen extends StatefulWidget {
  const P2PBettingScreen({
    Key? key,
    required this.liveScore,
  }) : super(key: key);

  final LiveScore liveScore;

  @override
  State<StatefulWidget> createState() => _P2PBettingScreenState();
}

class _P2PBettingScreenState extends State<P2PBettingScreen> {
  final P2PBetController controller = Get.find<P2PBetController>();
  final LiveScoreController lController = Get.find<LiveScoreController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  void initState() {
    super.initState();
    controller.setLiveScore(widget.liveScore);
    controller.setLiveScoreId(widget.liveScore.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User user = bController.user.value;
    return SizedBox(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leading: const Align(
            alignment: Alignment(0, -.8),
            child: AppBackButton(),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'P2P Betting',
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: context.colors.textDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Here you can create your P2P Bet',
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: context.colors.textDark,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        body: Obx(
          () => AppLoadingBox(
            loading: controller.isAddingBet.value ||
                lController.showLoadingLogo.value,
            child: SingleChildScrollView(
              padding: AppPaddings.lA,
              child: AppAnimatedColumn(
                duration: const Duration(milliseconds: 1000),
                direction: Axis.horizontal,
                children: <Widget>[
                  Text(
                    'Select one of the team to bet',
                    style: TextStyle(
                      color: context.colors.textDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  const AppSpacing(v: 8),
                  SizedBox(
                    height: 141.h,
                    width: 1.sw,
                    child: P2PBettingCard(
                      homeTeam: Team(
                        name: widget.liveScore.localTeam.data.name,
                        teamId: widget.liveScore.localTeam.data.id,
                        logo: widget.liveScore.localTeam.data.logo,
                      ),
                      awayTeam: Team(
                        name: widget.liveScore.visitorTeam.data.name,
                        teamId: widget.liveScore.visitorTeam.data.id,
                        logo: widget.liveScore.visitorTeam.data.logo,
                      ),
                      localTeamScore: widget.liveScore.scores!.localTeamScore,
                      time: widget.liveScore.time,
                      visitorTeamScore:
                          widget.liveScore.scores!.visitorTeamScore,
                      onAwayPressed: () => controller.selectTeam(
                        widget.liveScore.visitorTeam.data.name,
                        widget.liveScore.visitorTeam.data.id,
                      ),
                      onHomePressed: () => controller.selectTeam(
                        widget.liveScore.localTeam.data.name,
                        widget.liveScore.localTeam.data.id,
                      ),
                    ),
                  ),
                  const AppSpacing(v: 30),
                  Text(
                    'How much do you want to bet?',
                    style: TextStyle(
                      color: context.colors.textDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  const AppSpacing(v: 8),
                  AppTextInput(
                    labelText: 'AMOUNT (USD)',
                    textInputType: TextInputType.number,
                    onChanged: (String value) {
                      final double? amount = double.tryParse(value);
                      if (amount != null) {
                        controller.onAmountInputChanged(amount);
                        lController.convertAmount(context,
                            lController.selectedCurrency.value, amount);
                      }
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.deny(' '),
                    ],
                    backgroundColor: context.colors.primary.shade50,
                    validator: controller.validateAmount,
                  ),
                  const AppSpacing(v: 4),
                  Obx(
                    () => lController.isLoading.value
                        ? const SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(strokeWidth: 1),
                          )
                        : Text(
                            'USD coverted to  ${lController.selectedCurrency.toUpperCase()}: ${lController.convertedAmount}',
                            style: TextStyle(
                              color: context.colors.text,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                            ),
                          ),
                  ),
                  const AppSpacing(v: 30),
                  Text(
                    'Choose your bet',
                    style: TextStyle(
                      color: context.colors.textDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  const AppSpacing(v: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AppConstrainedButton(
                        text: 'Win',
                        borderRadius: AppBorderRadius.mediumAll,
                        color: context.colors.success,
                        textColor: Colors.white,
                        onPressed: () => controller.selectChoice('win'),
                        selected: controller.choice.value == 'win',
                      ),
                      AppConstrainedButton(
                        text: 'Draw',
                        borderRadius: AppBorderRadius.mediumAll,
                        color: context.colors.primary,
                        textColor: Colors.white,
                        onPressed: () => controller.selectChoice('draw'),
                        selected: controller.choice.value == 'draw',
                      ),
                      AppConstrainedButton(
                        text: 'Loss',
                        borderRadius: AppBorderRadius.mediumAll,
                        color: context.colors.error,
                        textColor: Colors.white,
                        onPressed: () => controller.selectChoice('loss'),
                        selected: controller.choice.value == 'loss',
                      )
                    ],
                  ),
                  const AppSpacing(v: 70),
                  AppButton(
                    onPressed: () async {
                      if (user.bonus != null &&
                          user.bonus! > controller.amount.value) {
                        // deduct from the bonus
                        bController.increaseDecreaseUserBonus(
                            'decrease', controller.amount.value);

                        controller.addNewBet(
                            context, lController.walletAddress.value, 'bonus');
                      } else {
                        final String? actualHash =
                            await lController.send(context);

                        if (actualHash != null) {
                          controller.addNewBet(
                            context,
                            lController.walletAddress.value,
                            actualHash,
                          );
                        }
                      }
                    },
                    enabled: controller.isValid && !lController.isLoading.value,
                    borderRadius: AppBorderRadius.largeAll,
                    child: Text(
                      'Create Bet'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const AppSpacing(v: 40),
                  Text(
                    'Betting is risky, addictive and can be psychological.\nBet depending on how much you can afford.\nNo limits on how many bets you can create.\nBet is finalized when opponent accepts bet request.',
                    style: TextStyle(
                      color: context.colors.textDark,
                      fontSize: 12,
                    ),
                  ),
                  const AppSpacing(v: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
