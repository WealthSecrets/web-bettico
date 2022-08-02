import 'dart:convert';

import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/live_score/get_fixtures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';

import '../../../data/models/crypto/volume.dart';
import '../../../domain/requests/crypto/convert_amount_request.dart';
import '../../../domain/usecases/crypto/convert_amount_to_currency.dart';
import '../../../domain/usecases/crypto/fetch_crypto_networks.dart';
import '/core/core.dart';
import '/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import '/features/p2p_betting/domain/usecases/live_score/get_live_matches.dart';
import '../../../data/models/crypto/network.dart';
import '../../../domain/requests/live_score/live_scores_request.dart';
import '../../p2p_betting/utils/ethereum_connector.dart';
import '../../p2p_betting/utils/i_connector.dart';

class LiveScoreController extends GetxController {
  LiveScoreController({
    required this.getLiveMatches,
    required this.getFixtures,
    required this.fetchCryptNetworks,
    required this.convertAmountToCurrency,
  });

  final GetLiveMatches getLiveMatches;
  final FetchCryptNetworks fetchCryptNetworks;
  final GetFixtures getFixtures;
  final ConvertAmountToCurrency convertAmountToCurrency;

  RxList<SoccerMatch> matches = <SoccerMatch>[].obs;
  RxList<Network> networks = <Network>[].obs;
  RxList<Fixture> fixtures = <Fixture>[].obs;
  RxList<SoccerMatch> sMatches = <SoccerMatch>[].obs;
  RxList<Fixture> sFixtures = <Fixture>[].obs;
  RxList<SoccerMatch> finishedMatches = <SoccerMatch>[].obs;
  RxList<SoccerMatch> notStartedMatches = <SoccerMatch>[].obs;
  RxList<SoccerMatch> inPlayMatches = <SoccerMatch>[].obs;

  RxDouble convertedAmount = 0.0.obs;
  RxString walletAddress = ''.obs;
  RxBool isWalletConnected = false.obs;
  RxString selectedCurrency = 'eth'.obs;

  RxString apiKey = ''.obs;
  RxString secretKey = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isSearching = false.obs;

  // Payments
  IConnector? connector;
  WalletConnectSession? session;

  Rx<Network?> selectedNetwork = Network.empty().obs;

  Future<void> initiateWalletConnect(BuildContext context) async {
    final WalletConnectSecureStorage sessionStorage =
        WalletConnectSecureStorage();
    session = await sessionStorage.getSession();
    if (session != null) {
      print('the session is not null');
      walletAddress.value = session!.accounts.first;
      isWalletConnected.value = true;
      setSelectedCurrencyFromChainId(session!.chainId);
    }
    connector = EthereumConnector(
      session: session,
      sessionStorage: sessionStorage,
      network: selectedNetwork.value,
    );

    if ((session == null || (session != null && !session!.connected)) &&
        connector != null) {
      // ignore: use_build_context_synchronously
      final SessionStatus? value = await connector!.connect(context);
      if (value != null) {
        walletAddress.value = value.accounts.first;
        isWalletConnected.value = true;
      }
    }
  }

  void resetEthereumNetwork({Network? network}) async {
    isWalletConnected.value = false;
    walletAddress.value = '';
    final WalletConnectSecureStorage sessionStorage =
        WalletConnectSecureStorage();
    session = await sessionStorage.getSession();
    connector = EthereumConnector(
      session: session,
      sessionStorage: sessionStorage,
      network: network,
    );
  }

  void setSelectedCurrencyFromChainId(int chainId) {
    final Network? net =
        networks.firstWhereOrNull((Network el) => el.chainId == chainId);
    if (net != null) {
      selectedCurrency.value = net.currency;
    } else {
      selectedCurrency.value = 'eth';
    }
  }

  void getAllLiveMatches(BuildContext context) async {
    isLoading(true);
    final String response =
        await rootBundle.loadString('assets/keys/live_score.json');
    final Map<String, dynamic> liveScoreKeys =
        await json.decode(response) as Map<String, dynamic>;
    final String apiKey = liveScoreKeys['api_key'] as String;
    final String secretKey = liveScoreKeys['secret_key'] as String;

    final Either<Failure, List<SoccerMatch>> failureOrMatches =
        await getLiveMatches(
      LiveScoreRequest(
        apiKey: apiKey,
        secretKey: secretKey,
      ),
    );

    failureOrMatches.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<SoccerMatch> value) {
        isLoading(false);
        matches(value);
        if (matches.isNotEmpty) {
          getFilteredMatches('IN PLAY');
          getFilteredMatches('NOT STARTED');
          getFilteredMatches('FINISHED');
        }
      },
    );
  }

  Future<void> getCryptoNetworks(BuildContext context) async {
    isLoading(true);

    final Either<Failure, List<Network>> failureOrNetworks =
        await fetchCryptNetworks(NoParams());

    failureOrNetworks.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<Network> value) {
        isLoading(false);
        networks(value);
        setSelectedNetwork(value[0]);
      },
    );
  }

  void setSelectedCurrency(String currency) {
    selectedCurrency.value = currency.toLowerCase();
  }

  void setSelectedNetwork(Network net) {
    selectedNetwork.value = net;
  }

  void convertAmount(
      BuildContext context, String currency, double amount) async {
    isLoading(true);

    final Either<Failure, Volume> failureOrVolume =
        await convertAmountToCurrency(
            ConvertAmountRequest(amount: amount, currency: currency));

    failureOrVolume.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (Volume vol) {
        isLoading(false);
        convertedAmount.value = vol.convertedAmount;
      },
    );
  }

  void getAllFixtures(BuildContext context) async {
    isLoading(true);

    final String response =
        await rootBundle.loadString('assets/keys/live_score.json');
    final Map<String, dynamic> liveScoreKeys =
        await json.decode(response) as Map<String, dynamic>;
    final String apiKey = liveScoreKeys['api_key'] as String;
    final String secretKey = liveScoreKeys['secret_key'] as String;

    final Either<Failure, List<Fixture>> failureOrFixtures = await getFixtures(
      LiveScoreRequest(
        apiKey: apiKey,
        secretKey: secretKey,
      ),
    );

    failureOrFixtures.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<Fixture> value) {
        isLoading(false);
        fixtures(value);
      },
    );
  }

  void getFilteredMatches(String filter) {
    final List<SoccerMatch> newMatches =
        matches.where((SoccerMatch match) => match.status == filter).toList();
    if (filter == 'FINISHED') {
      finishedMatches(newMatches);
    } else if (filter == 'IN PLAY') {
      inPlayMatches(newMatches);
    } else if (filter == 'NOT STARTED') {
      notStartedMatches(newMatches);
    }
  }

  void searchLiveMatchesAndFixtures(String query) async {
    isSearching(true);
    final List<SoccerMatch> ss = matches
        .where((SoccerMatch s) =>
            s.awayName.toLowerCase().contains(query) ||
            s.homeName.toLowerCase().contains(query))
        .toList();
    sMatches(ss);
    if (ss.isEmpty) {
      final List<Fixture> ff = fixtures
          .where((Fixture f) =>
              f.awayName.toLowerCase().contains(query) ||
              f.homeName.toLowerCase().contains(query))
          .toList();
      sFixtures(ff);
    }
  }
}
