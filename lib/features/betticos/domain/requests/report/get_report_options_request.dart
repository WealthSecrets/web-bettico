// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_report_options_request.freezed.dart';
part 'get_report_options_request.g.dart';

@freezed
class GetReportOptionsRequest with _$GetReportOptionsRequest {
  const factory GetReportOptionsRequest({
    required String type,
  }) = _GetReportOptionsRequest;
  factory GetReportOptionsRequest.fromJson(Map<String, dynamic> json) => _$GetReportOptionsRequestFromJson(json);
}
