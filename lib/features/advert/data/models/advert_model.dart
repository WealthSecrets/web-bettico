// ignore_for_file: invalid_annotation_target

import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'advert_model.freezed.dart';
part 'advert_model.g.dart';

enum Gender { both, male, female }

enum Category { credit, politics, social, employment, housing, election, other }

enum Target { views, clicks, engagements }

@freezed
class Advert with _$Advert {
  const factory Advert({
    @JsonKey(name: '_id') required String id,
    required Post post,
    required User user,
    required Category category,
    required Target target,
    required Gender gender,
    required int budget,
    required String location,
    required AgeRange ageRange,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Advert;

  const Advert._();

  factory Advert.fromJson(Map<String, dynamic> json) => _$AdvertFromJson(json);

  factory Advert.empty() => Advert(
        id: '',
        user: User.empty(),
        post: Post.empty(),
        category: Category.values.first,
        target: Target.views,
        gender: Gender.both,
        budget: 1,
        location: 'Ghana',
        ageRange: const AgeRange(maximum: 45, minimum: 18),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  factory Advert.mock() => Advert(
        id: '625e06f392dad8843a4d30c6',
        user: User.mock(),
        post: Post.mock(),
        category: Category.social,
        target: Target.clicks,
        gender: Gender.both,
        budget: 10,
        location: 'Ghana',
        ageRange: const AgeRange(maximum: 65, minimum: 18),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}

@freezed
class AgeRange with _$AgeRange {
  const factory AgeRange({
    @JsonKey(name: 'min') required int minimum,
    @JsonKey(name: 'max') required int maximum,
  }) = _AgeRange;

  factory AgeRange.fromJson(Map<String, dynamic> json) => _$AgeRangeFromJson(json);
}
