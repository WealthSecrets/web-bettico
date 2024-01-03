import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';

abstract class AdvertRemoteDataSource {
  Future<Advert> createAdvert({required CreateAdvertRequest request});
  Future<Business> createBusiness({required CreateBusinessRequest request});
  Future<List<Advert>> fetchAdverts();
}

class AdvertRemoteDataSourceImpl implements AdvertRemoteDataSource {
  const AdvertRemoteDataSourceImpl({required AppHTTPClient client}) : _client = client;
  final AppHTTPClient _client;

  @override
  Future<Advert> createAdvert({required CreateAdvertRequest request}) async {
    final Map<String, dynamic> json = await _client.post(AdvertEndpoints.adverts, body: request.toJson());
    return Advert.fromJson(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<Business> createBusiness({required CreateBusinessRequest request}) async {
    final Map<String, dynamic> json = await _client.post(AdvertEndpoints.business, body: request.toJson());
    return Business.fromJson(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<List<Advert>> fetchAdverts() async {
    final Map<String, dynamic> json = await _client.get(AdvertEndpoints.adverts);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Advert>.from(
      items.map<Advert>((dynamic json) => Advert.fromJson(json as Map<String, dynamic>)),
    );
  }
}
