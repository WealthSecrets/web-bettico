// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user_stats.freezed.dart';
part 'user_stats.g.dart';

@freezed
class UserStats with _$UserStats {
  const factory UserStats({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'totalAmount') required double totalAmount,
  }) = _UserStats;

  const UserStats._();

  factory UserStats.fromJson(Map<String, dynamic> json) =>
      _$UserStatsFromJson(json);

  factory UserStats.mock() => UserStats(
        id: const Uuid().v1(),
        totalAmount: 0.0,
      );

  factory UserStats.empty() => UserStats(
        id: const Uuid().v1(),
        totalAmount: 0.0,
      );
}
