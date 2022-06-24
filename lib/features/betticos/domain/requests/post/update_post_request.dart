class UpdatePostRequest {
  UpdatePostRequest({
    required this.postId,
    this.text,
    this.slipCode,
    this.isOddbox,
    this.likeUsers,
    this.dislikeUsers,
    this.shares,
  });
  final String postId;
  final bool? isOddbox;
  final String? slipCode;
  final String? text;
  final List<String>? likeUsers;
  final List<String>? dislikeUsers;
  final List<String>? shares;
}
