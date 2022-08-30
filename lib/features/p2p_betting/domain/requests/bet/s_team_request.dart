// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 's_team_request.freezed.dart';
part 's_team_request.g.dart';

@freezed
class STeamRequest with _$STeamRequest {
  const factory STeamRequest({
    required int teamId,
  }) = _STeamRequest;
  factory STeamRequest.fromJson(Map<String, dynamic> json) =>
      _$STeamRequestFromJson(json);
}
