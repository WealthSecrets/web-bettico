// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_competition_request.freezed.dart';
part 'live_competition_request.g.dart';

@freezed
class LiveCompetitionRequest with _$LiveCompetitionRequest {
  const factory LiveCompetitionRequest({
    required String apiKey,
    required String secretKey,
    required int competitionId,
    required int teamId,
  }) = _LiveCompetitionRequest;
  factory LiveCompetitionRequest.fromJson(Map<String, dynamic> json) => _$LiveCompetitionRequestFromJson(json);
}
