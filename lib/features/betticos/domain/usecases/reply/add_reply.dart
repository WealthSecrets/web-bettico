import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class AddReply implements UseCase<Reply, ReplyRequest> {
  AddReply({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Reply>> call(ReplyRequest params) {
    return betticosRepository.addReply(commentId: params.commentId, text: params.text);
  }
}
