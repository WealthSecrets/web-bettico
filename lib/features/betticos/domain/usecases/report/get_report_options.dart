import 'package:betticos/features/betticos/data/models/option/option_model.dart';
import 'package:betticos/features/betticos/domain/requests/report/get_report_options_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class GetReportOptions implements UseCase<List<ReportOption>, GetReportOptionsRequest> {
  GetReportOptions({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<ReportOption>>> call(GetReportOptionsRequest params) {
    return betticosRepository.getReportOptions(params.type);
  }
}
