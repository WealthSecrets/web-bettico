// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'identification_request.freezed.dart';
part 'identification_request.g.dart';

@freezed
class IdentificationRequest with _$IdentificationRequest {
  const factory IdentificationRequest({
    required String identificationType,
    required String identificationNumber,
    required DateTime expiryDate,
    required List<int> file,
  }) = _IdentificationRequest;
  factory IdentificationRequest.fromJson(Map<String, dynamic> json) =>
      _$IdentificationRequestFromJson(json);
}
