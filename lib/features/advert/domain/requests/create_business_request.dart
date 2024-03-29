// ignore_for_file: invalid_annotation_target
import 'package:betticos/features/presentation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'create_business_request.freezed.dart';
part 'create_business_request.g.dart';

@freezed
class CreateBusinessRequest with _$CreateBusinessRequest {
  const factory CreateBusinessRequest({
    required BusinessCategoryType category,
    @JsonKey(name: 'bustype') required BusinessType type,
    String? email,
    String? phone,
    String? bio,
    String? location,
    String? website,
  }) = _CreateBusinessRequest;
  factory CreateBusinessRequest.fromJson(Map<String, dynamic> json) => _$CreateBusinessRequestFromJson(json);
}
