// ignore_for_file: invalid_annotation_target
import 'dart:math';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'bet.freezed.dart';
part 'bet.g.dart';

enum BetStatus { awaiting, ongoing, completed, cancelled }

@freezed
class Bet with _$Bet {
  const factory Bet({
    @JsonKey(name: '_id') required String id,
    required int competitionId,
    required double amount,
    required BetStatus status,
    required Bettor creator,
    required Team awayTeam,
    required Team homeTeam,
    @JsonKey(name: 'winner') User? winner,
    Bettor? opponent,
    String? date,
    String? time,
    String? score,
    bool? isFixture,
    @JsonKey(name: 'payout') bool? payout,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Bet;

  const Bet._();

  factory Bet.fromJson(Map<String, dynamic> json) => _$BetFromJson(json);

  factory Bet.mock() => Bet(
        creator: Bettor.mock(),
        opponent: Bettor.mock(),
        status: Faker().randomGenerator.element(BetStatus.values),
        amount: Random().nextDouble(),
        competitionId: Random().nextInt(100),
        id: const Uuid().v1(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isFixture: false,
        awayTeam: Team.mock(),
        homeTeam: Team.mock(),
      );

  factory Bet.empty() => Bet(
        id: '',
        competitionId: 0,
        amount: 0,
        status: Faker().randomGenerator.element(BetStatus.values),
        opponent: Bettor.empty(),
        creator: Bettor.empty(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isFixture: false,
        awayTeam: Team.empty(),
        homeTeam: Team.empty(),
      );
}

extension BetStatusX on BetStatus {
  String get stringValue => toString().split('.').last;
}
