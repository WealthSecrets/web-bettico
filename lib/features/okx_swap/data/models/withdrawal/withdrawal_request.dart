// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'withdrawal_request.freezed.dart';
part 'withdrawal_request.g.dart';

@freezed
class WithdrawalRequest with _$WithdrawalRequest {
  const factory WithdrawalRequest({
    @JsonKey(name: 'amt') required String amount,
    @JsonKey(name: 'fee') required String fee,
    @JsonKey(name: 'dest') required String method,
    @JsonKey(name: 'ccy') required String currency,
    @JsonKey(name: 'chain') required String chain,
    @JsonKey(name: 'toAddr') required String toAddress,
  }) = _WithdrawalRequest;

  const WithdrawalRequest._();

  factory WithdrawalRequest.fromJson(Map<String, dynamic> json) => _$WithdrawalRequestFromJson(json);

  factory WithdrawalRequest.mock() => const WithdrawalRequest(
        amount: '0.1',
        currency: 'BTC',
        chain: 'BTC-Bitcoin',
        fee: '0.0005',
        method: '4',
        toAddress: '17DKe3kkkkiiiiTvAKKi2vMPbm1Bz3CMKw',
      );

  factory WithdrawalRequest.empty() => const WithdrawalRequest(
        amount: '',
        currency: '',
        chain: '',
        fee: '',
        method: '',
        toAddress: '',
      );
}
