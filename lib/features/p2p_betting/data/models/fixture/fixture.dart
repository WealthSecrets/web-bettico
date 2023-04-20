// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fixture.freezed.dart';
part 'fixture.g.dart';

enum FixtureStatus {
  notStarted,
  inPlay,
  halfTimeBreak,
  addedTime,
  finished,
  insufficientData,
}

@freezed
class Fixture with _$Fixture {
  const factory Fixture({
    required int id,
    @JsonKey(name: 'competition_id') required int competitionId,
    required String location,
    required String date,
    @JsonKey(name: 'away_id') required int awayId,
    @JsonKey(name: 'away_name') required String awayName,
    @JsonKey(name: 'h2h') String? head2head,
    @JsonKey(name: 'home_id') required int homeId,
    @JsonKey(name: 'home_name') required String homeName,
    required String time,
    required String round,
  }) = _Fixture;

  const Fixture._();

  factory Fixture.fromJson(Map<String, dynamic> json) => _$FixtureFromJson(json);

  factory Fixture.empty() => const Fixture(
        awayId: 0,
        homeId: 0,
        awayName: '',
        homeName: '',
        competitionId: 0,
        id: 1,
        location: '',
        time: '',
        date: '15:00:00',
        round: '31',
        head2head: '',
      );
}
