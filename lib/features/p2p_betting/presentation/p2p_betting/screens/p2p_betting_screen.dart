import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
// import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:walletconnect_dart/walletconnect_dart.dart';

import '/core/core.dart';
import '/features/p2p_betting/presentation/livescore/arguments/livescore_arguments.dart';
import '/features/p2p_betting/presentation/p2p_betting/widgets/p2p_betting_card.dart';
// import '../widgets/algorand_connector.dart';
// import '../widgets/ethereum_connector.dart';
// import '../widgets/test_connector.dart';

enum ConnectionState {
  disconnected,
  connecting,
  connected,
  connectionFailed,
  connectionCancelled,
}

class P2PBettingScreen extends StatefulWidget {
  const P2PBettingScreen({Key? key}) : super(key: key);
  static const String route = '/p2p-betting';

  @override
  State<StatefulWidget> createState() => _P2PBettingScreenState();
}

class _P2PBettingScreenState extends State<P2PBettingScreen> {
  final P2PBetController controller = Get.find<P2PBetController>();
  final LiveScoreArguments? args = Get.arguments as LiveScoreArguments?;

  // TestConnector connector = EthereumTestConnector();

  // static const List<String> _networks = <String>[
  //   'Ethereum (Ropsten)',
  //   'Algorand (Testnet)'
  // ];

  // ConnectionState _state = ConnectionState.disconnected;
  // String? _networkName = _networks.first;

  @override
  void initState() {
    super.initState();
    if (args != null) {
      if (args!.match != null) {
        controller.setCompetitionId(args!.match!.competitionId);
        controller.setMatch(args!.match!);
      } else if (args!.fixture != null) {
        controller.setCompetitionId(args!.fixture!.competitionId);
        controller.setFixture(args!.fixture!);
      }
    }

    // connector.registerListeners(
    //     // connected
    //     (SessionStatus session) => print('Connected: $session'),
    //     // session updated
    //     (WCSessionUpdateResponse response) =>
    //         print('Session updated: $response'),
    //     // disconnected
    //     () {
    //   setState(() => _state = ConnectionState.disconnected);
    //   print('Disconnected');
    // });
    super.initState();
  }

  // WalletConnect _buildApp() {
  //   final WalletConnect connector = WalletConnect(
  //     bridge: 'https://bridge.walletconnect.org',
  //     clientMeta: const PeerMeta(
  //       name: 'WalletConnect',
  //       description: 'WalletConnect Developer App',
  //       url: 'https://walletconnect.org',
  //       icons: <String>[
  //         'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
  //       ],
  //     ),
  //   );

  //   connector.on('connect', (event) => print('Connected: $event'));

  //   connector.on('session_update', (payload) {
  //     print('Payload: $payload');
  //   });

  //   connector.on('disconnect', (event) {
  //     print('Disconnected');
  //   });

  //   connector.registerListeners(onSessionUpdate: (payload) {
  //     print(payload);
  //   });

  //   return connector;
  // }

  // void _connectWallet({required String uri}) {
  //   final WalletConnect connector = WalletConnect(
  //     uri: uri,
  //     clientMeta: const PeerMeta(
  //       name: 'Algorand Wallet',
  //       description: 'Unofficial Algorand wallet',
  //       url: 'https://www.algorand.com',
  //       icons: [
  //         'https://cdn-images-1.medium.com/max/1200/1*VDrnmUI_W3GeeRClkfRPfg.png'
  //       ],
  //     ),
  //   );

  //   // Subscribe to session requests
  //   connector.on('session_request', (payload) async {
  //     await connector.approveSession(chainId: 4160, accounts: ['test']);

  //     await connector
  //         .updateSession(SessionStatus(chainId: 4000, accounts: ['test2']));
  //   });

  //   connector.on('disconnect', (message) async {
  //     print('Wallet disconnected $message');
  //   });

  //   connector.on('session_update', (session) async {
  //     print('Session updated: $session');
  //   });
  // }

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
                style: context.body1.copyWith(
                  color: context.colors.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Here you can create your P2P Bet',
                textScaleFactor: 1.0,
                style: context.caption.copyWith(
                  color: context.colors.textDark,
                  fontWeight: FontWeight.w500,
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
                    style: context.caption.copyWith(
                      color: context.colors.textDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const AppSpacing(v: 8),
                  if (args != null)
                    SizedBox(
                      height: 141.h,
                      width: 1.sw,
                      child: args!.match != null
                          ? P2PBettingCard(
                              homeTeam: Team(
                                name: args!.match!.homeName,
                                teamId: args!.match!.homeId,
                              ),
                              awayTeam: Team(
                                name: args!.match!.awayName,
                                teamId: args!.match!.awayId,
                              ),
                              score: args!.match!.score ?? '? - ?',
                              time: args!.match!.time,
                              onAwayPressed: () => controller.selectTeam(
                                args!.match!.awayName,
                                args!.match!.awayId,
                              ),
                              onHomePressed: () => controller.selectTeam(
                                args!.match!.homeName,
                                args!.match!.homeId,
                              ),
                            )
                          : args!.fixture != null
                              ? P2PBettingCard(
                                  homeTeam: Team(
                                    name: args!.fixture!.homeName,
                                    teamId: args!.fixture!.homeId,
                                  ),
                                  awayTeam: Team(
                                    name: args!.fixture!.awayName,
                                    teamId: args!.fixture!.awayId,
                                  ),
                                  score: '? - ?',
                                  time: args!.fixture!.time,
                                  date: args!.fixture!.date,
                                  onAwayPressed: () => controller.selectTeam(
                                    args!.fixture!.awayName,
                                    args!.fixture!.awayId,
                                  ),
                                  onHomePressed: () => controller.selectTeam(
                                    args!.fixture!.homeName,
                                    args!.fixture!.homeId,
                                  ),
                                )
                              : const SizedBox.shrink(),
                    ),
                  const AppSpacing(v: 30),
                  Text(
                    'How much do you want to bet ?',
                    style: context.caption.copyWith(
                      color: context.colors.textDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const AppSpacing(v: 8),
                  AppTextInput(
                    labelText: 'AMOUNT (USD)',
                    textInputType: TextInputType.number,
                    onChanged: controller.onAmountInputChanged,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.deny(' '),
                    ],
                    backgroundColor: context.colors.primary.shade50,
                    validator: controller.validateAmount,
                  ),
                  const AppSpacing(v: 30),
                  Text(
                    'Choose your bet',
                    style: context.caption.copyWith(
                      color: context.colors.textDark,
                      fontWeight: FontWeight.w700,
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
                    onPressed: () {
                      // _transactionStateToAction(context, state: _state);
                      // controller.addNewBet(
                      //   context,
                      //   isFixture: args!.fixture != null,
                      // );
                    },
                    enabled: controller.isValid,
                    borderRadius: AppBorderRadius.largeAll,
                    child: Text(
                      'Create Bet'.toUpperCase(),
                      style: context.body2.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const AppSpacing(v: 40),
                  Text(
                    'Betting is risky, addictive and can be psychological.\nBet depending on how much you can afford.\nNo limits on how many bets you can create.\nBet is finalized when opponent accepts bet request.',
                    style: context.caption.copyWith(
                      color: context.colors.textDark,
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
