// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'fixture_request.freezed.dart';
part 'fixture_request.g.dart';

@freezed
class FixtureRequest with _$FixtureRequest {
  const factory FixtureRequest({
    required String apiKey,
    required String secretKey,
    required int competitionId,
    required int teamId,
    required String date,
  }) = _FixtureRequest;
  factory FixtureRequest.fromJson(Map<String, dynamic> json) =>
      _$FixtureRequestFromJson(json);
}
