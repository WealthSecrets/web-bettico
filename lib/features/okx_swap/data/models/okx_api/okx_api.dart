// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'okx_api.freezed.dart';
part 'okx_api.g.dart';

@freezed
class OkxApi with _$OkxApi {
  const factory OkxApi({
    @JsonKey(name: 'apiKey') required String apiKey,
    @JsonKey(name: 'ip') required String ip,
    @JsonKey(name: 'perm') required String perm,
    @JsonKey(name: 'ts') String? timeStamp,
  }) = _OkxApi;

  const OkxApi._();

  factory OkxApi.fromJson(Map<String, dynamic> json) => _$OkxApiFromJson(json);

  factory OkxApi.mock() => const OkxApi(
      apiKey: '0xff028909d090f0298839',
      ip: '000.000.000.000',
      perm: 'withdrawal,trade');

  factory OkxApi.empty() => const OkxApi(apiKey: '', ip: '', perm: '');
}
