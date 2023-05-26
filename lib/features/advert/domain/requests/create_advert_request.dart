// ignore_for_file: invalid_annotation_target
import 'package:betticos/features/advert/data/models/advert_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_advert_request.freezed.dart';
part 'create_advert_request.g.dart';

@freezed
class CreateAdvertRequest with _$CreateAdvertRequest {
  const factory CreateAdvertRequest({
    required String post,
    required Category category,
    required Target target,
    required Gender gender,
    required int budget,
    required String location,
    required AgeRange ageRange,
    required int duration,
  }) = _CreateAdvertRequest;
  factory CreateAdvertRequest.fromJson(Map<String, dynamic> json) => _$CreateAdvertRequestFromJson(json);
}
