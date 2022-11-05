import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/p2p_betting/data/models/bet/bet.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_bettting_details.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/betting_modal.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/p2p_betting_history_card.dart';
import 'package:flutter/material.dart';
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
        } else {
          if (_p2pBetController.searchStatus.isEmpty &&
              _p2pBetController.from.isEmpty &&
              _p2pBetController.to.isEmpty) {
            _p2pBetController.clearFilter(context);
          }
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
      () => AppLoadingBox(
        loading: _p2pBetController.isFetchingBets.value,
        child: Column(
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
            SizedBox(
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
                            onPressed: () => _p2pBetController
                                .setButtonSelected(context, text.toLowerCase()),
                            selected: _p2pBetController.selectedButton.value ==
                                text.toLowerCase(),
                          ),
                        ),
                      )
                      .toList()
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _p2pBetController.bets.isEmpty
                  ? AppEmptyScreen(
                      message: _p2pBetController.isFiltering
                          ? 'Sorry, we couldn’t find any results for this search.'
                          : 'All ${_p2pBetController.selectedButton.value} P2P bets will show up here.')
                  : ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        final Bet bet = _p2pBetController.bets[index];
                        return P2PBettingHistoryCard(
                          key: ObjectKey(
                            bet.id,
                          ),
                          bet: bet,
                          onPressed: () {
                            if (bet.status == BetStatus.awaiting) {
                              if (!lController.isConnected) {
                                if (Ethereum.isSupported) {
                                  lController.initiateWalletConnect(
                                    (_) => navigateToBetDetailsScreen(bet),
                                  );
                                } else {
                                  lController.connectWC().then((_) {
                                    if (lController.walletAddress.isNotEmpty) {
                                      navigateToBetDetailsScreen(bet);
                                    }
                                  });
                                }
                              } else {
                                navigateToBetDetailsScreen(bet);
                              }
                            } else {
                              showBetDetailsModalBottomSheet(bet);
                            }
                          },
                        );
                      },
                      itemCount: _p2pBetController.bets.length,
                    ),
            )
          ],
        ),
        // child: CustomScrollView(
        //   slivers: <Widget>[
        //     if (_p2pBetController.bets.length + 2 > 2)
        //       SliverPadding(
        //         padding: AppPaddings.homeH,
        //         sliver: SliverList(
        //           delegate: SliverChildBuilderDelegate(
        //             (_, int index) {
        //               print('checking index: $index');

        //               if (index == 0) {
        //                 return Column(
        //                   children: <Widget>[
        //                     SearchField(
        //                       onChanged: (String value) {
        //                         if (_p2pBetController.title.value != value) {
        //                           subject.add(value);
        //                         }
        //                       },
        //                       showSortBy: true,
        //                       isLoading: false,
        //                       controller: _controller,
        //                     ),
        //                     const SizedBox(height: 16),
        //                   ],
        //                 );
        //               }
        //               if (index == 1) {
        //                 return SizedBox(
        //                   height: 30,
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                     children: <Widget>[
        //                       ..._p2pBetController.buttonTexts
        //                           .map(
        //                             (String text) => Obx(
        //                               () => AppConstrainedButton(
        //                                 text: StringUtils.capitalizeFirst(text),
        //                                 borderRadius: AppBorderRadius.largeAll,
        //                                 color: context.colors.primary,
        //                                 textColor: Colors.white,
        //                                 onPressed: () =>
        //                                     _p2pBetController.setButtonSelected(
        //                                         context, text.toLowerCase()),
        //                                 selected: _p2pBetController
        //                                         .selectedButton.value ==
        //                                     text.toLowerCase(),
        //                               ),
        //                             ),
        //                           )
        //                           .toList()
        //                     ],
        //                   ),
        //                 );
        //               }

        //               final Bet bet = _p2pBetController.bets[index - 2];
        //               return P2PBettingHistoryCard(
        //                 key: ObjectKey(
        //                   bet.id,
        //                 ),
        //                 bet: bet,
        //                 onPressed: () {
        //                   if (bet.status == BetStatus.awaiting) {
        //                     if (!lController.isConnected) {
        //                       if (Ethereum.isSupported) {
        //                         lController.initiateWalletConnect(
        //                           () => navigateToBetDetailsScreen(bet),
        //                         );
        //                       } else {
        //                         lController.connectWC().then((_) {
        //                           if (lController.walletAddress.isNotEmpty) {
        //                             navigateToBetDetailsScreen(bet);
        //                           }
        //                         });
        //                       }
        //                     } else {
        //                       navigateToBetDetailsScreen(bet);
        //                     }
        //                   } else {
        //                     showBetDetailsModalBottomSheet(bet);
        //                   }
        //                 },
        //               );
        //             },
        //             childCount: _p2pBetController.bets.length + 2,
        //           ),
        //         ),
        //       ),
        //     if (_p2pBetController.bets.isEmpty)
        //       SliverFillRemaining(
        //         child: Padding(
        //           padding: AppPaddings.bodyH,
        //           child: AppAnimatedColumn(
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: <Widget>[
        //                 const AppSpacing(v: 30),
        //                 SvgPicture.asset(
        //                   AssetSVGs.emptyState.path,
        //                   height: 300,
        //                 ),
        //                 const AppSpacing(v: 10),
        //                 Text(
        //                   'Nothing to See Here',
        //                   style: TextStyle(
        //                     color: context.colors.textDark,
        //                     fontWeight: FontWeight.w700,
        //                     fontSize: 16,
        //                   ),
        //                 ),
        //                 const AppSpacing(v: 10),
        //                 Text(
        //                   'All ${_p2pBetController.selectedButton.value} P2P bets will show up here.',
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(
        //                     color: context.colors.text,
        //                     fontWeight: FontWeight.w400,
        //                     fontSize: 12,
        //                   ),
        //                 ),
        //               ]),
        //         ),
        //       ),
        //   ],
        // ),
      ),
    );
  }

  void navigateToBetDetailsScreen(Bet bet) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => P2PBettingDetailsScreen(
          bet: bet,
        ),
      ),
    );
  }

  void showBetDetailsModalBottomSheet(Bet bet) {
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
          bet: bet,
        );
      },
      context: context,
    );
  }
}
