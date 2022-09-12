// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_bonus_request.freezed.dart';
part 'user_bonus_request.g.dart';

@freezed
class UserBonusRequest with _$UserBonusRequest {
  const factory UserBonusRequest({
    required String type,
    required double amount,
  }) = _UserBonusRequest;
  factory UserBonusRequest.fromJson(Map<String, dynamic> json) =>
      _$UserBonusRequestFromJson(json);
}
