// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_bet_status_score_request.freezed.dart';
part 'update_bet_status_score_request.g.dart';

@freezed
class UpdateBetStatusScoreRequest with _$UpdateBetStatusScoreRequest {
  const factory UpdateBetStatusScoreRequest({
    required String betId,
    required String status,
    required String score,
    String? winner,
  }) = _UpdateBetStatusScoreRequest;
  factory UpdateBetStatusScoreRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateBetStatusScoreRequestFromJson(json);
}
