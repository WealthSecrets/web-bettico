import 'package:freezed_annotation/freezed_annotation.dart';
part 'twilio_response.freezed.dart';
part 'twilio_response.g.dart';

@freezed
class TwilioResponse with _$TwilioResponse {
  const factory TwilioResponse({
    required String sid,
    required String serviceSid,
    required String accountSid,
    required String to,
    required String channel,
    required String status,
    required DateTime dateCreated,
    required DateTime dateUpdated,
    String? url,
  }) = _TwilioResponse;
  const TwilioResponse._();

  factory TwilioResponse.fromJson(Map<String, dynamic> json) => _$TwilioResponseFromJson(json);

  factory TwilioResponse.mock() => TwilioResponse(
        sid: '',
        serviceSid: '',
        accountSid: '',
        to: '',
        channel: '',
        status: '',
        dateCreated: DateTime.now(),
        dateUpdated: DateTime.now(),
        url: '',
      );
}
