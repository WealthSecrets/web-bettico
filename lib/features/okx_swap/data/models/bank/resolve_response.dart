// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'resolve_response.freezed.dart';
part 'resolve_response.g.dart';

@freezed
class ResolveResponse with _$ResolveResponse {
  const factory ResolveResponse({
    @JsonKey(name: 'account_number') required String accountNumber,
    @JsonKey(name: 'account_name') required String accountName,
    @JsonKey(name: 'bank_id') required int bankId,
  }) = _ResolveResponse;
  factory ResolveResponse.fromJson(Map<String, dynamic> json) => _$ResolveResponseFromJson(json);
}
