import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

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
