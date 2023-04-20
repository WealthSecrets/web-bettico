// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_team_request.freezed.dart';
part 'live_team_request.g.dart';

@freezed
class LiveTeamRequest with _$LiveTeamRequest {
  const factory LiveTeamRequest({
    required String apiKey,
    required String secretKey,
    required int teamId,
    required int competitionId,
    required String date,
  }) = _LiveTeamRequest;
  factory LiveTeamRequest.fromJson(Map<String, dynamic> json) => _$LiveTeamRequestFromJson(json);
}
