// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_request.freezed.dart';
part 'bank_request.g.dart';

@freezed
class BankRequest with _$BankRequest {
  const factory BankRequest({
    @JsonKey(name: 'currency') required String currency,
    @JsonKey(name: 'type') String? type,
  }) = _BankRequest;
  factory BankRequest.fromJson(Map<String, dynamic> json) => _$BankRequestFromJson(json);
}
