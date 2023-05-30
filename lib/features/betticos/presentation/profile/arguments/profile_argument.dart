import 'package:betticos/features/auth/data/models/user/user.dart';

class ProfileScreenArgument {
  const ProfileScreenArgument({required this.user, this.showBackButton = false});

  final User user;
  final bool? showBackButton;
}
