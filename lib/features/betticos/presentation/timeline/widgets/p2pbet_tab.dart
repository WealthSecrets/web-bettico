import 'package:betticos/core/core.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_bettting_details.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/betting_modal.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/p2p_betting_history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rxdart/rxdart.dart';
import '/core/presentation/widgets/search_field.dart';

class P2pBetTab extends StatefulWidget {
  const P2pBetTab({Key? key}) : super(key: key);

  @override
  State<P2pBetTab> createState() => _P2pBetTabState();
}

class _P2pBetTabState extends State<P2pBetTab> {
  // getx controllers
  final P2PBetController _p2pBetController = Get.find<P2PBetController>();
  final LiveScoreController lController = Get.find<LiveScoreController>();

  final PublishSubject<String> subject = PublishSubject<String>();

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '');
    subject.stream
        .debounce(
            (_) => TimerStream<bool>(true, const Duration(milliseconds: 1000)))
        .listen(
      (String txt) {
        _p2pBetController.title.value = txt;
        if (txt.isNotEmpty) {
          _p2pBetController.filterBets();
        }
      },
    );
  }

  @override
  void dispose() {
    subject.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScrollView(
        slivers: <Widget>[
          if (_p2pBetController.awaitingBets.isNotEmpty ||
              _p2pBetController.ongoingBets.isNotEmpty ||
              _p2pBetController.completedBets.isNotEmpty)
            SliverPadding(
              padding: AppPaddings.homeH,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                    if (index == 0) {
                      return Column(
                        children: <Widget>[
                          SearchField(
                            onChanged: (String value) {
                              if (_p2pBetController.title.value != value) {
                                subject.add(value);
                              }
                            },
                            showSortBy: true,
                            isLoading: false,
                            controller: _controller,
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    }
                    if (index == 1) {
                      return SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ..._p2pBetController.buttonTexts
                                .map(
                                  (String text) => Obx(
                                    () => AppConstrainedButton(
                                      text: StringUtils.capitalizeFirst(text),
                                      borderRadius: AppBorderRadius.largeAll,
                                      color: context.colors.primary,
                                      textColor: Colors.white,
                                      onPressed: () =>
                                          _p2pBetController.setButtonSelected(
                                              text.toLowerCase()),
                                      selected: _p2pBetController
                                              .selectedButton.value ==
                                          text.toLowerCase(),
                                    ),
                                  ),
                                )
                                .toList()
                          ],
                        ),
                      );
                    }
                    return P2PBettingHistoryCard(
                      key: ObjectKey(
                        _p2pBetController.selectedButton.value == 'ongoing'
                            ? _p2pBetController.ongoingBets[index - 1].id
                            : _p2pBetController.selectedButton.value ==
                                    'completed'
                                ? _p2pBetController.completedBets[index - 1]
                                : _p2pBetController.awaitingBets[index - 1].id,
                      ),
                      bet: _p2pBetController.selectedButton.value == 'ongoing'
                          ? _p2pBetController.ongoingBets[index - 1]
                          : _p2pBetController.selectedButton.value ==
                                  'completed'
                              ? _p2pBetController.completedBets[index - 1]
                              : _p2pBetController.awaitingBets[index - 1],
                      onPressed: () {
                        if (_p2pBetController.selectedButton.value ==
                            'awaiting') {
                          if (!lController.isConnected) {
                            if (Ethereum.isSupported) {
                              lController.initiateWalletConnect(
                                () {
                                  Navigator.of(context).push<void>(
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          P2PBettingDetailsScreen(
                                        bet: _p2pBetController
                                                    .selectedButton.value ==
                                                'ongoing'
                                            ? _p2pBetController
                                                .ongoingBets[index - 1]
                                            : _p2pBetController
                                                        .selectedButton.value ==
                                                    'completed'
                                                ? _p2pBetController
                                                    .completedBets[index - 1]
                                                : _p2pBetController
                                                    .awaitingBets[index - 1],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              lController.connectWC().then((_) {
                                if (lController.walletAddress.isNotEmpty) {
                                  Navigator.of(context).push<void>(
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          P2PBettingDetailsScreen(
                                        bet: _p2pBetController
                                                    .selectedButton.value ==
                                                'ongoing'
                                            ? _p2pBetController
                                                .ongoingBets[index - 1]
                                            : _p2pBetController
                                                        .selectedButton.value ==
                                                    'completed'
                                                ? _p2pBetController
                                                    .completedBets[index - 1]
                                                : _p2pBetController
                                                    .awaitingBets[index - 1],
                                      ),
                                    ),
                                  );
                                }
                              });
                            }
                          } else {
                            Navigator.of(context).push<void>(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    P2PBettingDetailsScreen(
                                  bet: _p2pBetController.selectedButton.value ==
                                          'ongoing'
                                      ? _p2pBetController.ongoingBets[index - 1]
                                      : _p2pBetController
                                                  .selectedButton.value ==
                                              'completed'
                                          ? _p2pBetController
                                              .completedBets[index - 1]
                                          : _p2pBetController
                                              .awaitingBets[index - 1],
                                ),
                              ),
                            );
                          }
                        } else {
                          showMaterialModalBottomSheet<bool?>(
                            bounce: true,
                            useRootNavigator: true,
                            animationCurve: Curves.fastLinearToSlowEaseIn,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            )),
                            builder: (BuildContext modalContext) {
                              return P2PBettingBottomSheet(
                                bet: _p2pBetController.selectedButton.value ==
                                        'ongoing'
                                    ? _p2pBetController.ongoingBets[index - 1]
                                    : _p2pBetController.selectedButton.value ==
                                            'completed'
                                        ? _p2pBetController
                                            .completedBets[index - 1]
                                        : _p2pBetController
                                            .awaitingBets[index - 1],
                              );
                            },
                            context: context,
                          );
                        }
                      },
                    );
                  },
                  childCount: _p2pBetController.selectedButton.value ==
                          'ongoing'
                      ? _p2pBetController.ongoingBets.length + 2
                      : _p2pBetController.selectedButton.value == 'completed'
                          ? _p2pBetController.completedBets.length + 2
                          : _p2pBetController.awaitingBets.length + 2,
                ),
              ),
            ),
          if ((_p2pBetController.awaitingBets.isEmpty &&
                  _p2pBetController.selectedButton.value == 'awaiting') ||
              (_p2pBetController.ongoingBets.isEmpty &&
                  _p2pBetController.selectedButton.value == 'ongoing') ||
              (_p2pBetController.completedBets.isEmpty &&
                  _p2pBetController.selectedButton.value == 'completed'))
            SliverFillRemaining(
              child: Padding(
                padding: AppPaddings.bodyH,
                child: AppAnimatedColumn(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const AppSpacing(v: 30),
                      SvgPicture.asset(
                        AssetSVGs.emptyState.path,
                        height: 300,
                      ),
                      const AppSpacing(v: 10),
                      Text(
                        'Nothing to See Here',
                        style: TextStyle(
                          color: context.colors.textDark,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const AppSpacing(v: 10),
                      Text(
                        'All ${_p2pBetController.selectedButton.value} P2P bets will show up here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.colors.text,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ]),
              ),
            ),
        ],
      ),
    );
  }
}
