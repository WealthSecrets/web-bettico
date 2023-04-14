// ignore_for_file: invalid_annotation_target
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/data/models/post/hashtag_model.dart';
import 'package:betticos/features/betticos/data/models/post/post_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_response.freezed.dart';
part 'search_response.g.dart';

@freezed
class SearchResponse with _$SearchResponse {
  const factory SearchResponse({
    @JsonKey(name: 'top') required List<Post> top,
    @JsonKey(name: 'users') required List<User> users,
    @JsonKey(name: 'latest') required List<Post> latest,
    @JsonKey(name: 'images') required List<Post> images,
    @JsonKey(name: 'hashtags') required List<Hashtag> hashtags,
  }) = _SearchResponse;
  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
}
