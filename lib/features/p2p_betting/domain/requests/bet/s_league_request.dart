// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 's_league_request.freezed.dart';
part 's_league_request.g.dart';

@freezed
class SLeagueRequest with _$SLeagueRequest {
  const factory SLeagueRequest({
    required int leagueId,
  }) = _SLeagueRequest;
  factory SLeagueRequest.fromJson(Map<String, dynamic> json) => _$SLeagueRequestFromJson(json);
}
