import 'dart:convert';

import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/live_score/get_fixtures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import '/features/p2p_betting/domain/usecases/live_score/get_live_matches.dart';
import '../../../domain/requests/live_score/live_scores_request.dart';

class LiveScoreController extends GetxController {
  LiveScoreController({
    required this.getLiveMatches,
    required this.getFixtures,
  });

  final GetLiveMatches getLiveMatches;
  final GetFixtures getFixtures;

  RxList<SoccerMatch> matches = <SoccerMatch>[].obs;
  RxList<Fixture> fixtures = <Fixture>[].obs;
  RxList<SoccerMatch> sMatches = <SoccerMatch>[].obs;
  RxList<Fixture> sFixtures = <Fixture>[].obs;
  RxList<SoccerMatch> finishedMatches = <SoccerMatch>[].obs;
  RxList<SoccerMatch> notStartedMatches = <SoccerMatch>[].obs;
  RxList<SoccerMatch> inPlayMatches = <SoccerMatch>[].obs;
  RxString apiKey = ''.obs;
  RxString secretKey = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isSearching = false.obs;

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
