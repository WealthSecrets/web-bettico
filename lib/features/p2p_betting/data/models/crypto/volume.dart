// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'volume.freezed.dart';
part 'volume.g.dart';

@freezed
class Volume with _$Volume {
  const factory Volume({
    required String fromCurrency,
    required String toCurrency,
    required double convertedAmount,
    required double price,
  }) = _Volume;

  const Volume._();

  factory Volume.fromJson(Map<String, dynamic> json) => _$VolumeFromJson(json);

  factory Volume.empty() => const Volume(
        fromCurrency: 'ETH',
        toCurrency: 'USD',
        convertedAmount: 99019,
        price: 122344,
      );
}
