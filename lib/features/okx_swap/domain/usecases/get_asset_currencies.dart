import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class GetAssetCurrencies implements UseCase<List<Currency>, NoParams> {
  GetAssetCurrencies({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, List<Currency>>> call(NoParams params) {
    return okxRepository.fetchAssetCurrencies();
  }
}
