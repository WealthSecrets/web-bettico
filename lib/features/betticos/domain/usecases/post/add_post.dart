import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';
import '/features/betticos/domain/requests/post/add_post_request.dart';

class AddPost implements UseCase<Post, AddPostRequest> {
  AddPost({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Post>> call(AddPostRequest params) {
    return betticosRepository.addPost(
      files: params.files,
      onSendProgress: params.onSendProgress,
      text: params.text,
      isOddbox: params.isOddbox,
      slipCode: params.slipCode,
      isReply: params.isReply,
      postId: params.postId,
    );
  }
}
