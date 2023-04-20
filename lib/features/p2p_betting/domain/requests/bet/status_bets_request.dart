// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_bets_request.freezed.dart';
part 'status_bets_request.g.dart';

@freezed
class StatusBetsRequests with _$StatusBetsRequests {
  const factory StatusBetsRequests({
    required String status,
  }) = _StatusBetsRequests;
  factory StatusBetsRequests.fromJson(Map<String, dynamic> json) => _$StatusBetsRequestsFromJson(json);
}
