import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class GetSetup implements UseCase<Setup, NoParams> {
  GetSetup({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Setup>> call(NoParams params) {
    return betticosRepository.getSetup();
  }
}
