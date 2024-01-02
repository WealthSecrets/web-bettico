// ignore_for_file: invalid_annotation_target
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

@freezed
class Report with _$Report {
  const factory Report({
    @JsonKey(name: '_id') required String id,
    required User reporter,
    required ReportOption optionId,
    User? userId,
    Post? postId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Report;

  const Report._();

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  factory Report.empty() => Report(reporter: User.empty(), id: '', optionId: ReportOption.empty());
}
