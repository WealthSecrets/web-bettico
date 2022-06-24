// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'option_model.freezed.dart';
part 'option_model.g.dart';

@freezed
class ReportOption with _$ReportOption {
  const factory ReportOption({
    @JsonKey(name: '_id') required String id,
    required String title,
    required String type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ReportOption;

  const ReportOption._();

  factory ReportOption.fromJson(Map<String, dynamic> json) =>
      _$ReportOptionFromJson(json);

  factory ReportOption.empty() =>
      const ReportOption(id: '', title: '', type: '');
}
