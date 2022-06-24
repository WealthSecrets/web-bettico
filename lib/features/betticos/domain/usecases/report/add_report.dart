import 'package:betticos/features/betticos/domain/requests/report/report_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class AddReport implements UseCase<void, ReportRequest> {
  AddReport({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, void>> call(ReportRequest params) {
    return betticosRepository.addReport(
      postId: params.postId,
      type: params.type,
      optionId: params.optionId,
      userId: params.userId,
    );
  }
}
