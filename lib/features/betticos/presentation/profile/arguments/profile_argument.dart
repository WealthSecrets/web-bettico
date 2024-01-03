import 'package:betticos/common/common.dart';

class ProfileScreenArgument {
  const ProfileScreenArgument({required this.user, this.showBackButton = false});

  final User user;
  final bool? showBackButton;
}
