// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.freezed.dart';
part 'team.g.dart';

@freezed
class Team with _$Team {
  const factory Team({
    required String name,
    required int teamId,
  }) = _Team;

  const Team._();

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  factory Team.mock() => const Team(
        name: 'Barcelona F.C',
        teamId: 0,
      );

  factory Team.empty() => const Team(
        name: '',
        teamId: 0,
      );
}
