// ignore_for_file: invalid_annotation_target
import 'dart:math';

import 'package:betticos/core/core.dart';
import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'bettor.freezed.dart';
part 'bettor.g.dart';

enum BettorChoice { win, draw, loss }

@freezed
class Bettor with _$Bettor {
  const factory Bettor({
    @JsonKey(name: '_id') required String id,
    required User user,
    required String team,
    required int teamId,
    required BettorChoice choice,
    required String wallet,
  }) = _Bettor;

  const Bettor._();

  factory Bettor.fromJson(Map<String, dynamic> json) => _$BettorFromJson(json);

  factory Bettor.mock() => Bettor(
        choice: Faker().randomGenerator.element(BettorChoice.values),
        id: const Uuid().v1(),
        team: Faker().person.name(),
        teamId: Random().nextInt(1000),
        user: User.empty(),
        wallet: '',
      );

  factory Bettor.empty() => Bettor(
        choice: Faker().randomGenerator.element(BettorChoice.values),
        user: User.empty(),
        team: '',
        teamId: 0,
        id: '',
        wallet: '',
      );
}

extension BettorChoiceX on BettorChoice {
  String get stringValue => toString().split('.').last;
}
