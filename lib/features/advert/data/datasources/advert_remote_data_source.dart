import 'package:betticos/core/core.dart';
import 'package:betticos/features/advert/data/models/advert_model.dart';
import 'package:betticos/features/advert/domain/requests/create_advert_request.dart';

import '../endpoints/advert_endpoints.dart';

abstract class AdvertRemoteDataSource {
  Future<Advert> createAdvert({required CreateAdvertRequest request});
}

class AdvertRemoteDataSourceImpl implements AdvertRemoteDataSource {
  const AdvertRemoteDataSourceImpl({required AppHTTPClient client}) : _client = client;
  final AppHTTPClient _client;

  @override
  Future<Advert> createAdvert({required CreateAdvertRequest request}) async {
    final Map<String, dynamic> json = await _client.post(AdvertEndpoints.adverts, body: request.toJson());
    return Advert.fromJson(json);
  }
}
