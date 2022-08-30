// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'steam.freezed.dart';
part 'steam.g.dart';

@freezed
class Steam with _$Steam {
  const factory Steam({
    @JsonKey(name: 'data') required SteamData data,
  }) = _Steam;

  const Steam._();

  factory Steam.fromJson(Map<String, dynamic> json) => _$SteamFromJson(json);

  factory Steam.empty() => Steam(
        data: SteamData.empty(),
      );
}

@freezed
class SteamData with _$SteamData {
  const factory SteamData({
    required int id,
    @JsonKey(name: 'legacy_id') int? legacyId,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'logo_path') required String logo,
    @JsonKey(name: 'short_code') String? shortCode,
    @JsonKey(name: 'country_id') int? countryId,
    @JsonKey(name: 'national_team') required bool nationalTeam,
    @JsonKey(name: 'founded') int? founded,
  }) = _SteamData;

  factory SteamData.fromJson(Map<String, dynamic> json) =>
      _$SteamDataFromJson(json);

  factory SteamData.empty() => const SteamData(
        id: 0,
        name: '',
        logo: '',
        nationalTeam: false,
      );
}
