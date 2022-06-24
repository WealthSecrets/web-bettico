import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/data/models/soccer_match/soccer_match.dart';

class LiveScoreArguments {
  const LiveScoreArguments({
    this.match,
    this.fixture,
  });
  final SoccerMatch? match;
  final Fixture? fixture;
}
