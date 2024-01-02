import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class AddFeeling implements UseCase<Feeling, FeelingRequest> {
  AddFeeling({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Feeling>> call(FeelingRequest params) {
    return betticosRepository.addFeeling(postId: params.postId, type: params.type);
  }
}
