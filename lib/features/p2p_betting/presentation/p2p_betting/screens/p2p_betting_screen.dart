import 'package:betticos/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/features/p2p_betting/presentation/p2p_betting/widgets/p2p_betting_card.dart';
import '../../../data/models/fixture/fixture.dart';
import '../../livescore/getx/live_score_controllers.dart';

enum ConnectionState {
  disconnected,
  connecting,
  connected,
  connectionFailed,
  connectionCancelled,
}

class P2PBettingScreen extends StatefulWidget {
  const P2PBettingScreen({Key? key, this.fixture, this.match})
      : super(key: key);

  final Fixture? fixture;
  final SoccerMatch? match;

  @override
  State<StatefulWidget> createState() => _P2PBettingScreenState();
}

class _P2PBettingScreenState extends State<P2PBettingScreen> {
  final P2PBetController controller = Get.find<P2PBetController>();
  final LiveScoreController lController = Get.find<LiveScoreController>();
  // final LiveScoreArguments? args = Get.arguments as LiveScoreArguments?;

  @override
  void initState() {
    super.initState();

    if (widget.match != null) {
      controller.setCompetitionId(widget.match!.competitionId);
      controller.setMatch(widget.match!);
    } else if (widget.fixture != null) {
      controller.setCompetitionId(widget.fixture!.competitionId);
      controller.setFixture(widget.fixture!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            loading: controller.isAddingBet.value,
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
                    child: widget.match != null
                        ? P2PBettingCard(
                            homeTeam: Team(
                              name: widget.match!.homeName,
                              teamId: widget.match!.homeId,
                            ),
                            awayTeam: Team(
                              name: widget.match!.awayName,
                              teamId: widget.match!.awayId,
                            ),
                            score: widget.match!.score ?? '? - ?',
                            time: widget.match!.time,
                            onAwayPressed: () => controller.selectTeam(
                              widget.match!.awayName,
                              widget.match!.awayId,
                            ),
                            onHomePressed: () => controller.selectTeam(
                              widget.match!.homeName,
                              widget.match!.homeId,
                            ),
                          )
                        : widget.fixture != null
                            ? P2PBettingCard(
                                homeTeam: Team(
                                  name: widget.fixture!.homeName,
                                  teamId: widget.fixture!.homeId,
                                ),
                                awayTeam: Team(
                                  name: widget.fixture!.awayName,
                                  teamId: widget.fixture!.awayId,
                                ),
                                score: '? - ?',
                                time: widget.fixture!.time,
                                date: widget.fixture!.date,
                                onAwayPressed: () => controller.selectTeam(
                                  widget.fixture!.awayName,
                                  widget.fixture!.awayId,
                                ),
                                onHomePressed: () => controller.selectTeam(
                                  widget.fixture!.homeName,
                                  widget.fixture!.homeId,
                                ),
                              )
                            : const SizedBox.shrink(),
                  ),
                  const AppSpacing(v: 30),
                  Text(
                    'How much do you want to bet ?',
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
                      controller.onAmountInputChanged(value);
                      final double? amount = double.tryParse(value);
                      if (amount != null) {
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
                      final String? actualHash =
                          await lController.send(context);

                      if (actualHash != null) {
                        controller.addNewBet(
                          context,
                          isFixture: widget.fixture != null,
                        );
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

  // String _transactionStateToString({required ConnectionState state}) {
  //   switch (state) {
  //     case ConnectionState.disconnected:
  //       return 'Connect!';
  //     case ConnectionState.connecting:
  //       return 'Connecting';
  //     case ConnectionState.connected:
  //       return 'Session connected';
  //     case ConnectionState.connectionFailed:
  //       return 'Connection failed';
  //     case ConnectionState.connectionCancelled:
  //       return 'Connection cancelled';
  //   }
  // }

  // void _openWalletPage() {
  //   Navigator.of(context).push<void>(
  //     MaterialPageRoute<void>(
  //       builder: (BuildContext context) => WalletScreen(connector: connector),
  //     ),
  //   );
  // }

//   VoidCallback? _transactionStateToAction(BuildContext context,
//       {required ConnectionState state}) {
//     print('State: ${_transactionStateToString(state: state)}');
//     switch (state) {
//       // Progress, action disabled
//       case ConnectionState.connecting:
//         return null;
//       case ConnectionState.connected:
//         // Open new page
//         return () => _openWalletPage();

//       // Initiate the connection
//       case ConnectionState.disconnected:
//       case ConnectionState.connectionCancelled:
//       case ConnectionState.connectionFailed:
//         return () async {
//           setState(() => _state = ConnectionState.connecting);
//           try {
//             final SessionStatus? session = await connector.connect(context);
//             if (session != null) {
//               setState(() => _state = ConnectionState.connected);
//               Future<void>.delayed(Duration.zero, () => _openWalletPage());
//             } else {
//               setState(() => _state = ConnectionState.connectionCancelled);
//             }
//           } catch (e) {
//             print('WC exception occured: $e');
//             setState(() => _state = ConnectionState.connectionFailed);
//           }
//         };
//     }
//   }

//   void _changeNetwork(String? network) {
//     if (network == null || _networkName == network) {
//       return;
//     }

//     final int index = _networks.indexOf(network);
//     // update connector
//     switch (index) {
//       case 0:
//         connector = EthereumTestConnector();
//         break;
//       case 1:
//         connector = AlgorandTestConnector();
//         break;
//     }

//     setState(
//       () {
//         _networkName = network;
//         _state = ConnectionState.disconnected;
//       },
//     );
//   }
}
