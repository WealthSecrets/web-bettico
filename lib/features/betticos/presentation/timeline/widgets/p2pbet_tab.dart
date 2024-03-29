import 'package:betticos/common/common.dart';
import 'package:betticos/controllers/controllers.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rxdart/rxdart.dart';

class P2pBetTab extends StatefulWidget {
  const P2pBetTab({super.key});

  @override
  State<P2pBetTab> createState() => _P2pBetTabState();
}

class _P2pBetTabState extends State<P2pBetTab> with AutomaticKeepAliveClientMixin {
  final P2PBetController _p2pBetController = Get.find<P2PBetController>();
  final LiveScoreController lController = Get.find<LiveScoreController>();
  final WalletController wController = Get.find<WalletController>();
  final PublishSubject<String> subject = PublishSubject<String>();

  late final TextEditingController _controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '');
    subject.stream.debounce((_) => TimerStream<bool>(true, const Duration(milliseconds: 1000))).listen(
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
    super.build(context);
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
                  ..._p2pBetController.buttonTexts.map(
                    (String text) => Obx(
                      () => AppConstrainedButton(
                        text: StringUtils.capitalizeFirst(text),
                        borderRadius: AppBorderRadius.largeAll,
                        color: context.colors.primary,
                        textColor: Colors.white,
                        onPressed: () => _p2pBetController.setButtonSelected(context, text.toLowerCase()),
                        selected: _p2pBetController.selectedButton.value == text.toLowerCase(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _p2pBetController.bets.isEmpty
                  ? AppEmptyScreen(
                      message: _p2pBetController.isFiltering
                          ? 'Sorry, we couldn’t find any results for this search.'
                          : 'All ${_p2pBetController.selectedButton.value} P2P bets will show up here.',
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ..._p2pBetController.bets.map((Bet bet) {
                            return P2PBettingHistoryCard(
                              key: ObjectKey(
                                bet.id,
                              ),
                              bet: bet,
                              isMyBets: false,
                              onPressed: () {
                                if (bet.status == BetStatus.awaiting || bet.opponent != null) {
                                  if (!wController.isConnected) {
                                    if (Ethereum.isSupported) {
                                      wController.walletInit((_) => navigateToBetDetailsScreen(bet));
                                    } else {
                                      wController.walletInit((_) {
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
                          }),
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  void navigateToBetDetailsScreen(Bet bet) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (BuildContext context) => P2PBettingDetailsScreen(bet: bet)),
    );
  }

  void showBetDetailsModalBottomSheet(Bet bet) {
    showMaterialModalBottomSheet<bool?>(
      bounce: true,
      useRootNavigator: true,
      animationCurve: Curves.fastLinearToSlowEaseIn,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      builder: (BuildContext modalContext) => P2PBettingBottomSheet(bet: bet),
      context: context,
    );
  }
}
