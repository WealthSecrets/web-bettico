// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nullable_livescore_request.freezed.dart';
part 'nullable_livescore_request.g.dart';

@freezed
class NullLiveScoreRequest with _$NullLiveScoreRequest {
  const factory NullLiveScoreRequest({
    int? leagueId,
  }) = _SNullLiveScoreRequest;
  factory NullLiveScoreRequest.fromJson(Map<String, dynamic> json) => _$NullLiveScoreRequestFromJson(json);
}
