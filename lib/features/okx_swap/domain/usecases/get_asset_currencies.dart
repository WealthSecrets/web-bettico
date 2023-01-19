import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class GetAssetCurrencies implements UseCase<List<Currency>, NoParams> {
  GetAssetCurrencies({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, List<Currency>>> call(NoParams params) {
    return okxRepository.fetchAssetCurrencies();
  }
}
