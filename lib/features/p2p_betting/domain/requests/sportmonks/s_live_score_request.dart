// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 's_live_score_request.freezed.dart';
part 's_live_score_request.g.dart';

@freezed
class SLiveScoreRequest with _$SLiveScoreRequest {
  const factory SLiveScoreRequest({
    required int leagueId,
  }) = _SLiveScoreRequest;
  factory SLiveScoreRequest.fromJson(Map<String, dynamic> json) =>
      _$SLiveScoreRequestFromJson(json);
}
