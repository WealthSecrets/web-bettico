class _AssetSVGs {
  _AssetSVGs._();
  static String logo = 'assets/svgs/logo.svg';
  static String emptyState = 'assets/svgs/empty_state.svg';
  static String follow = 'assets/svgs/follow.svg';
  static String slipCode = 'assets/svgs/slip_code.svg';
  static String win = 'assets/svgs/win.svg';
  static String referral = 'assets/svgs/referral.svg';
  static String followers = 'assets/svgs/followers.svg';
  static String goals = 'assets/svgs/goals.svg';
  static String messages = 'assets/svgs/messages.svg';
  static String realtime = 'assets/svgs/realtime.svg';
}

enum AssetSVGs {
  logo,
  emptyState,
  follow,
  slipCode,
  win,
  referral,
  followers,
  goals,
  messages,
  realtime,
}

extension X on AssetSVGs {
  String get path {
    switch (this) {
      case AssetSVGs.logo:
        return _AssetSVGs.logo;
      case AssetSVGs.emptyState:
        return _AssetSVGs.emptyState;
      case AssetSVGs.follow:
        return _AssetSVGs.follow;
      case AssetSVGs.slipCode:
        return _AssetSVGs.slipCode;
      case AssetSVGs.win:
        return _AssetSVGs.win;
      case AssetSVGs.referral:
        return _AssetSVGs.referral;
      case AssetSVGs.followers:
        return _AssetSVGs.followers;
      case AssetSVGs.goals:
        return _AssetSVGs.goals;
      case AssetSVGs.messages:
        return _AssetSVGs.messages;
      case AssetSVGs.realtime:
        return _AssetSVGs.realtime;
    }
  }
}
