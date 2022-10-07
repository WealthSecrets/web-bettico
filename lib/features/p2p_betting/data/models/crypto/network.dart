// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network.freezed.dart';
part 'network.g.dart';

@freezed
class Network with _$Network {
  const factory Network({
    @JsonKey(name: '_id') required String id,
    required String name,
    required int chainId,
    required String image,
    required String currency,
    required double percentage,
  }) = _Network;

  const Network._();

  factory Network.fromJson(Map<String, dynamic> json) => _$NetworkFromJson(json);

  factory Network.empty() => const Network(
        id: '',
        name: '',
        chainId: 1,
        image: '',
        currency: '',
        percentage: 2.0,
      );
}
