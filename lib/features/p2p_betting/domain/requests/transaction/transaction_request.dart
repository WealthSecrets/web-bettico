// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_request.freezed.dart';
part 'transaction_request.g.dart';

@freezed
class TransactionRequest with _$TransactionRequest {
  const factory TransactionRequest({
    @JsonKey(name: 'bet') String? betId,
    @JsonKey(name: 'user') required String userId,
    required String type,
    required String description,
    required double amount,
    required double convertedAmount,
    @JsonKey(name: 'hash') required String transactionHash,
    @JsonKey(name: 'wallet') required String walletAddress,
    required String token,
    required String convertedToken,
    DateTime? time,
    double? gas,
    required String status,
    String? provider,
  }) = _TransactionRequest;
  factory TransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$TransactionRequestFromJson(json);
}
