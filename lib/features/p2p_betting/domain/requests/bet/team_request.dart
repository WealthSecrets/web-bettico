// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_request.freezed.dart';
part 'team_request.g.dart';

@freezed
class TeamRequest with _$TeamRequest {
  const factory TeamRequest({
    required String name,
    required int teamId,
  }) = _TeamRequest;
  factory TeamRequest.fromJson(Map<String, dynamic> json) =>
      _$TeamRequestFromJson(json);
}
