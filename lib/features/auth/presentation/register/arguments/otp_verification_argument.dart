import 'package:betticos/features/auth/domain/enums/otp_receiver_type.dart';

import '/features/auth/data/models/user/user.dart';

class OTPVerificationArgument {
  const OTPVerificationArgument({required this.otpReceiverType, this.user});
  final OTPReceiverType otpReceiverType;
  final User? user;
}
