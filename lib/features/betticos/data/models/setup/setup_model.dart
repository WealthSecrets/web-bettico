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
  }) = _Setup;

  const Setup._();

  factory Setup.fromJson(Map<String, dynamic> json) => _$SetupFromJson(json);

  factory Setup.empty() => const Setup(
        id: '',
        xviralRate: 0.0,
        xviralTarget: 0.0,
        xviralDepositAddress: '',
      );
}
