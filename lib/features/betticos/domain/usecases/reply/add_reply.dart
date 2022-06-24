import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/reply/reply_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';
import '/features/betticos/domain/requests/reply/reply_request.dart';

class AddReply implements UseCase<Reply, ReplyRequest> {
  AddReply({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Reply>> call(ReplyRequest params) {
    return betticosRepository.addReply(
      commentId: params.commentId,
      text: params.text,
    );
  }
}
