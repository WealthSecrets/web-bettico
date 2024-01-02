// ignore_for_file: invalid_annotation_target
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_model.freezed.dart';
part 'business_model.g.dart';

@freezed
class Business with _$Business {
  const factory Business({
    @JsonKey(name: '_id') required String id,
    required User user,
    required BusinessCategoryType category,
    @JsonKey(name: 'bustype') required BusinessType type,
    String? email,
    String? phone,
    String? bio,
    String? location,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Business;

  const Business._();

  factory Business.fromJson(Map<String, dynamic> json) => _$BusinessFromJson(json);

  factory Business.empty() => Business(
        id: '',
        user: User.empty(),
        category: BusinessCategoryType.values.first,
        type: BusinessType.creator,
        email: '',
        location: 'Ghana',
        phone: '',
        bio: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  factory Business.mock() => Business(
        id: '625e06f392dad8843a4d30c6',
        user: User.mock(),
        category: BusinessCategoryType.blogger,
        type: BusinessType.creator,
        email: Faker().internet.email(),
        location: 'Ghana',
        phone: '0247656959',
        bio: Faker().lorem.sentence(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}
