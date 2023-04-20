// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'feeling_request.freezed.dart';
part 'feeling_request.g.dart';

@freezed
class FeelingRequest with _$FeelingRequest {
  const factory FeelingRequest({
    required String type,
    required String postId,
  }) = _FeelingRequest;
  factory FeelingRequest.fromJson(Map<String, dynamic> json) => _$FeelingRequestFromJson(json);
}
