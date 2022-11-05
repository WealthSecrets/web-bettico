// ignore_for_file: invalid_annotation_target
import 'package:betticos/features/auth/data/models/identification/identification.dart';
import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: '_id') required String id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    @JsonKey(name: 'dob') DateTime? dateOfBirth,
    String? photo,
    String? phone,
    String? role,
    String? status,
    String? passwordResetToken,
    Identification? identification,
    DateTime? phoneVerifiedAt,
    DateTime? emailVerifiedAt,
    DateTime? profileAt,
    String? code,
    String? walletAddress,
    String? referralCode,
    bool? oAuth,
    int? followers,
    int? following,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? referrals,
    @JsonKey(name: 'bonus') double? bonus,
  }) = _User;

  const User._();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.mock() => User(
        email: Faker().internet.email(),
        id: const Uuid().v1(),
        firstName: Faker().person.firstName(),
        lastName: Faker().person.lastName(),
        username: Faker().person.name(),
        dateOfBirth: Faker().date.dateTime(maxYear: 1998, minYear: 1960),
        phone:
            '+233024${Faker().randomGenerator.integer(9999999, min: 1000000)}',
        role: 'user',
        passwordResetToken: '',
        walletAddress: '',
        followers: Faker().randomGenerator.integer(999, min: 1000),
        following: Faker().randomGenerator.integer(999, min: 1000),
        referrals: Faker().randomGenerator.integer(999, min: 1000),
      );

  factory User.empty() => User(
        id: const Uuid().v1(),
        firstName: '',
        lastName: '',
        username: '',
        phone: '',
        email: '',
        role: '',
        walletAddress: '',
        dateOfBirth: DateTime.now(),
        passwordResetToken: '',
        followers: 0,
        following: 0,
        referrals: 0,
      );

  bool get isVerified => role == 'user'
      ? profileAt != null && emailVerifiedAt != null
      : (emailVerifiedAt != null &&
          profileAt != null &&
          identification != null &&
          photo != null);

  bool get isPersonalInfoProvided =>
      firstName != null &&
      lastName != null &&
      phone != null &&
      username != null &&
      dateOfBirth != null;

  bool get hasRole => role != null;

  bool get hasIdentification => identification != null;

  bool get hasProfileImage => photo != null;
}

enum AccountType { personal, oddster }
