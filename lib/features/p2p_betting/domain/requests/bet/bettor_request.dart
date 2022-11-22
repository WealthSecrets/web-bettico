// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bettor_request.freezed.dart';
part 'bettor_request.g.dart';

@freezed
class BettorRequest with _$BettorRequest {
  const factory BettorRequest({
    required String user,
    required String team,
    required int teamId,
    required String choice,
    required String wallet,
    required String txthash,
  }) = _BettorRequest;
  factory BettorRequest.fromJson(Map<String, dynamic> json) =>
      _$BettorRequestFromJson(json);
}
