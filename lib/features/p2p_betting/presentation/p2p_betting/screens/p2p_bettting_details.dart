import 'package:betticos/core/presentation/utils/app_endpoints.dart';
import 'package:betticos/core/presentation/widgets/payment_button.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/p2p_betting/data/models/bet/bet.dart';
import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '../widgets/p2p_betting_card.dart';

class P2PBettingDetailsScreen extends StatefulWidget {
  const P2PBettingDetailsScreen({
    Key? key,
    required this.bet,
  }) : super(key: key);
  final Bet bet;

  @override
  State<StatefulWidget> createState() => _P2PBettingDetailsScreenState();
}

class _P2PBettingDetailsScreenState extends State<P2PBettingDetailsScreen> {
  final P2PBetController controller = Get.find<P2PBetController>();
  final LiveScoreController lController = Get.find<LiveScoreController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  void initState() {
    lController.convertAmount(context, 'wsc', widget.bet.amount);
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
                '${StringUtils.capitalizeFirst(widget.bet.creator.user.firstName!)}\'s Bet',
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: context.colors.textDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Accept ${StringUtils.capitalizeFirst(widget.bet.creator.user.firstName!)}\'s bet to compete with him',
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
            loading: controller.isUpdatingBet.value ||
                bController.isUpdatingUserBonus.value,
            child: SingleChildScrollView(
              padding: AppPaddings.lA,
              child: AppAnimatedColumn(
                duration: const Duration(milliseconds: 1000),
                direction: Axis.horizontal,
                children: <Widget>[
                  P2PBettingCard(
                    awayTeam: Team(
                      name: widget.bet.awayTeam.name,
                      teamId: widget.bet.awayTeam.teamId,
                      logo: widget.bet.awayTeam.logo,
                    ),
                    homeTeam: Team(
                      name: widget.bet.homeTeam.name,
                      teamId: widget.bet.homeTeam.teamId,
                      logo: widget.bet.homeTeam.logo,
                    ),
                    localTeamScore: 0,
                    visitorTeamScore: 0,
                    onAwayPressed:
                        widget.bet.creator.teamId != widget.bet.awayTeam.teamId
                            ? () => controller.selectTeam(
                                  widget.bet.awayTeam.name,
                                  widget.bet.awayTeam.teamId,
                                )
                            : null,
                    onHomePressed:
                        widget.bet.creator.teamId != widget.bet.homeTeam.teamId
                            ? () => controller.selectTeam(
                                  widget.bet.homeTeam.name,
                                  widget.bet.homeTeam.teamId,
                                )
                            : null,
                    awayDisabled:
                        widget.bet.creator.teamId == widget.bet.awayTeam.teamId,
                    homeDisabled:
                        widget.bet.creator.teamId == widget.bet.homeTeam.teamId,
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
                  Obx(
                    () => Row(
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
                  ),
                  const AppSpacing(v: 30),
                  Text(
                    'Creator of Bet',
                    style: TextStyle(
                      color: context.colors.textDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  const AppSpacing(v: 8),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${AppEndpoints.userImages}/${widget.bet.creator.user.photo}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const AppSpacing(h: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${widget.bet.creator.user.firstName} ${widget.bet.creator.user.lastName}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '@${widget.bet.creator.user.username}',
                              style: TextStyle(
                                color: context.colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const AppSpacing(v: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const AppSpacing(v: 16),
                  Row(
                    children: <Widget>[
                      Text(
                        'Bet\'s Amount:',
                        style: TextStyle(
                          color: context.colors.textDark,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '\$${widget.bet.amount}',
                        style: TextStyle(
                          color: context.colors.success,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const AppSpacing(v: 16),
                  Text(
                    'Payment Type',
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
                      PaymentButton(
                        text: 'Bonus',
                        selected: controller.paymentType.value == 'bonus',
                        onPressed: () {
                          controller.paymentType.value = 'bonus';
                        },
                        tagValue: '\$${user.bonus}',
                      ),
                      PaymentButton(
                        text: 'Wallet',
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 32),
                        selected: controller.paymentType.value == 'wallet',
                        onPressed: () {
                          controller.paymentType.value = 'wallet';
                        },
                      ),
                    ],
                  ),
                  const AppSpacing(v: 70),
                  Obx(
                    () => AppButton(
                      onPressed: () async {
                        if (widget.bet.creator.user.id != user.id) {
                          if (controller.paymentType.value == 'bonus' &&
                              user.bonus != null &&
                              (user.bonus! >= widget.bet.amount)) {
                            // TODO(blankson): Consider adding opponent to bet when bonus is deducted.
                            bController.increaseDecreaseUserBonus(
                              context,
                              'decrease',
                              widget.bet.amount,
                              failureCallback: () async {
                                // TODO(blankson): Consider using .then() on futures (send)
                                final String? actualHash =
                                    await lController.send(context);
                                if (actualHash != null) {
                                  controller.addOpponentToBet(
                                    context,
                                    widget.bet,
                                    lController.walletAddress.value,
                                    actualHash,
                                  );
                                }
                              },
                              successCallback: () {
                                controller.addOpponentToBet(
                                  context,
                                  widget.bet,
                                  lController.walletAddress.value,
                                  'bonus',
                                );
                              },
                            );
                          } else if (controller.paymentType.value == 'wallet') {
                            final String? actualHash =
                                await lController.send(context);
                            if (actualHash != null) {
                              controller.addOpponentToBet(
                                context,
                                widget.bet,
                                lController.walletAddress.value,
                                actualHash,
                              );
                            }
                          } else {
                            await AppSnacks.show(
                              context,
                              message: 'Payment type not selected',
                              leadingIcon: Icon(
                                Ionicons.checkmark_circle,
                                size: 24,
                                color: context.colors.success,
                              ),
                              backgroundColor: context.colors.success,
                            );
                          }
                        } else {
                          await AppSnacks.show(context,
                              message: 'You cannot accept bets you created.');
                        }
                      },
                      enabled: controller.isDetailsValid,
                      borderRadius: AppBorderRadius.largeAll,
                      child: Text(
                        'Accept Bet Request'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const AppSpacing(v: 40),
                  Text(
                    'P2P Betting is risky.\nBet depending on how much you can afford.\nNo limits on how many bets you can create.\nBet is finalized when opponent accepts bet request.',
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
