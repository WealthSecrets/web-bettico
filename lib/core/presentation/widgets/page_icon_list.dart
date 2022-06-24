import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '/features/betticos/presentation/bet_competition/screens/bet_competition_screen.dart';
import '/features/betticos/presentation/members/screens/members_screen.dart';
import '/features/betticos/presentation/oddsters/screens/oddsters_screen.dart';
// import '/features/betticos/presentation/profile/screens/user_profile_screen.dart';
import '/features/betticos/presentation/timeline/screens/timeline_screen.dart';

final List<Widget> pageList = <Widget>[
  TimelineScreen(),
  OddstersScreen(),
  MembersScreen(),
  BetCompetitionScreen(),
];

// flutter pacakge

final List<IconData> iconList = <IconData>[
  Ionicons.home_outline,
  Ionicons.trending_up_outline,
  Icons.supervised_user_circle_outlined,
  Ionicons.football_outline,
  Icons.account_circle_outlined,
];

final List<IconData> iconSharpList = <IconData>[
  Ionicons.home_sharp,
  Ionicons.trending_up_sharp,
  Icons.supervised_user_circle_sharp,
  Ionicons.football_sharp,
  Icons.account_circle_sharp,
];
