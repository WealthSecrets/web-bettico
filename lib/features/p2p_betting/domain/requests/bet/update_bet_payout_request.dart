// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_bet_payout_request.freezed.dart';
part 'update_bet_payout_request.g.dart';

@freezed
class UpdateBetPayoutRequest with _$UpdateBetPayoutRequest {
  const factory UpdateBetPayoutRequest({
    required String betId,
    required String status,
    required bool payout,
    required String txthash,
  }) = _UpdateBetPayoutRequest;
  factory UpdateBetPayoutRequest.fromJson(Map<String, dynamic> json) => _$UpdateBetPayoutRequestFromJson(json);
}
