// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_request.freezed.dart';
part 'report_request.g.dart';

@freezed
class ReportRequest with _$ReportRequest {
  const factory ReportRequest({
    required String type,
    required String optionId,
    String? postId,
    String? userId,
  }) = _ReportRequest;
  factory ReportRequest.fromJson(Map<String, dynamic> json) => _$ReportRequestFromJson(json);
}
