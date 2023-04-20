// ignore_for_file: invalid_annotation_target

import 'package:betticos/features/p2p_betting/domain/requests/bet/bettor_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bet_update_request.freezed.dart';
part 'bet_update_request.g.dart';

@freezed
class BetUpdateRequest with _$BetUpdateRequest {
  const factory BetUpdateRequest({
    required BettorRequest opponent,
    required String status,
  }) = _BetUpdateRequest;
  factory BetUpdateRequest.fromJson(Map<String, dynamic> json) => _$BetUpdateRequestFromJson(json);
}
