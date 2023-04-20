// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_scores_request.freezed.dart';
part 'live_scores_request.g.dart';

@freezed
class LiveScoreRequest with _$LiveScoreRequest {
  const factory LiveScoreRequest({
    required String apiKey,
    required String secretKey,
  }) = _LiveScoreRequest;
  factory LiveScoreRequest.fromJson(Map<String, dynamic> json) => _$LiveScoreRequestFromJson(json);
}
