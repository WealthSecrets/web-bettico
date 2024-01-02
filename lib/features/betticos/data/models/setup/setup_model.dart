// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'setup_model.freezed.dart';
part 'setup_model.g.dart';

@freezed
class Setup with _$Setup {
  const factory Setup({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'xRate') required double xviralRate,
    @JsonKey(name: 'xTarget') required double xviralTarget,
    @JsonKey(name: 'xDepositAddress') required String xviralDepositAddress,
    @JsonKey(name: 'vCost') required double viewCost,
    @JsonKey(name: 'vExpected') required int expectedViews,
    @JsonKey(name: 'vPeriod') required int viewPeriod,
    @JsonKey(name: 'cCost') required double clickCost,
    @JsonKey(name: 'cExpected') required int expectedClicks,
    @JsonKey(name: 'cPeriod') required int clickPeriod,
    @JsonKey(name: 'eCost') required double engagementCost,
    @JsonKey(name: 'eExpected') required int expectedEngagement,
    @JsonKey(name: 'ePeriod') required int engagementPeriod,
  }) = _Setup;

  const Setup._();

  factory Setup.fromJson(Map<String, dynamic> json) => _$SetupFromJson(json);

  factory Setup.empty() => const Setup(
        id: '',
        xviralRate: 0.0,
        xviralTarget: 0.0,
        xviralDepositAddress: '',
        viewCost: 10,
        expectedViews: 1500,
        viewPeriod: 3,
        clickCost: 10,
        expectedClicks: 800,
        clickPeriod: 3,
        engagementCost: 10,
        expectedEngagement: 500,
        engagementPeriod: 3,
      );
}
