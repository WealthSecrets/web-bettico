// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_bet_request.freezed.dart';
part 'search_bet_request.g.dart';

@freezed
class SearchBetRequest with _$SearchBetRequest {
  const factory SearchBetRequest({
    required String title,
    String? status,
    String? from,
    String? to,
  }) = _SearchBetRequest;
  factory SearchBetRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchBetRequestFromJson(json);
}
