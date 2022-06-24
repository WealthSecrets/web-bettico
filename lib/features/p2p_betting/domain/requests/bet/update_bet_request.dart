// ignore_for_file: invalid_annotation_target

import 'package:betticos/features/p2p_betting/domain/requests/bet/bettor_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_bet_request.freezed.dart';
part 'update_bet_request.g.dart';

@freezed
class UpdateBetRequest with _$UpdateBetRequest {
  const factory UpdateBetRequest({
    required String betId,
    required BettorRequest opponent,
    required String status,
  }) = _UpdateBetRequest;
  factory UpdateBetRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateBetRequestFromJson(json);
}
