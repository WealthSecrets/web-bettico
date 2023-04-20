import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_request.freezed.dart';
part 'reset_request.g.dart';

@freezed
class ResetRequest with _$ResetRequest {
  const factory ResetRequest({
    required String password,
    required String confirmPassword,
    required String email,
  }) = _ResetRequest;
  factory ResetRequest.fromJson(Map<String, dynamic> json) => _$ResetRequestFromJson(json);
}
