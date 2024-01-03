// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'subscription_model.freezed.dart';
part 'subscription_model.g.dart';

@freezed
class Subscription with _$Subscription {
  const factory Subscription({
    @JsonKey(name: '_id') required String id,
    required String subscriberId,
    required String userId,
    required bool premium,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Subscription;

  const Subscription._();

  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);

  factory Subscription.empty() => Subscription(
        id: '',
        userId: '',
        subscriberId: '',
        premium: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}
