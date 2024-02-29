import 'package:betticos/features/betticos/data/models/post/post_model.dart';

class AddPostCommentArgument {
  const AddPostCommentArgument({required this.post, required this.isReply});
  final Post post;
  final bool isReply;
}
