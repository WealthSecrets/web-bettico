// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'subscribe_request.freezed.dart';
part 'subscribe_request.g.dart';

@freezed
class SubscribeRequest with _$SubscribeRequest {
  const factory SubscribeRequest({
    required String userId,
  }) = _SubscribeRequest;
  factory SubscribeRequest.fromJson(Map<String, dynamic> json) => _$SubscribeRequestFromJson(json);
}
