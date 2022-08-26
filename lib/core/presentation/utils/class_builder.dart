import 'package:betticos/features/betticos/presentation/referral/screens/referral_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/screens/new_livescore_screen.dart';
import '/features/betticos/presentation/bet_competition/screens/bet_competition_screen.dart';
import '/features/betticos/presentation/members/screens/members_screen.dart';
import '/features/betticos/presentation/oddsbox/screens/oddsbox_screen.dart';
import '/features/betticos/presentation/oddsters/screens/oddsters_screen.dart';
import '/features/betticos/presentation/payments/screens/payments_screen.dart';
import '/features/betticos/presentation/timeline/screens/timeline_screen.dart';
import '../../../features/settings/presentation/settings/screens/settings_screen.dart';

typedef Constructor<T> = T Function();

final Map<String, Constructor<Object>> _constructors =
    <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor as Constructor<Object>;
}

class ClassBuilder {
  static void registerClasses() {
    register<TimelineScreen>(() => TimelineScreen());
    register<MembersScreen>(() => MembersScreen());
    register<OddstersScreen>(() => OddstersScreen());
    register<OddsboxScreen>(() => OddsboxScreen());
    register<PaymentsScreen>(() => PaymentsScreen());
    register<BetCompetitionScreen>(() => BetCompetitionScreen());
    register<SettingsScreen>(() => SettingsScreen());
    register<ReferralScreen>(() => ReferralScreen());
    // register<LiveScoreScreen>(() => LiveScoreScreen());
    register<NewLiveScore>(() => NewLiveScore());
  }

  static dynamic fromString(String type) {
    if (_constructors[type] != null) {
      return _constructors[type]!();
    }
  }
}
