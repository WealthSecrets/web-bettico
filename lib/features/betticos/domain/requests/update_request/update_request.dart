import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_request.freezed.dart';
part 'update_request.g.dart';

@freezed
class UpdateRequest with _$UpdateRequest {
  const factory UpdateRequest({
    String? firstName,
    String? lastName,
    String? phone,
    String? username,
    String? walletAddress,
    String? country,
  }) = _UpdateRequest;
  factory UpdateRequest.fromJson(Map<String, dynamic> json) => _$UpdateRequestFromJson(json);
}
