import 'package:betticos/features/auth/data/models/responses/twilio/twilio_response.dart';
import 'package:betticos/features/auth/domain/requests/sms/send_sms_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class SendSms implements UseCase<TwilioResponse, SendSmsRequest> {
  SendSms({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, TwilioResponse>> call(SendSmsRequest params) {
    return authRepository.sendSms(params);
  }
}
