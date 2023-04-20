// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 's_fixture_request.freezed.dart';
part 's_fixture_request.g.dart';

@freezed
class SFixtureRequest with _$SFixtureRequest {
  const factory SFixtureRequest({
    required int fixtureId,
  }) = _SFixtureRequest;
  factory SFixtureRequest.fromJson(Map<String, dynamic> json) => _$SFixtureRequestFromJson(json);
}
