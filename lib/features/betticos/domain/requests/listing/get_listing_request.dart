// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_listing_request.freezed.dart';
part 'get_listing_request.g.dart';

@freezed
class GetListingRequest with _$GetListingRequest {
  const factory GetListingRequest({
    required String symbol,
  }) = _GetListingRequest;
  factory GetListingRequest.fromJson(Map<String, dynamic> json) =>
      _$GetListingRequestFromJson(json);
}
