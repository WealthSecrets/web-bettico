// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'coin_quote_model.dart';

part 'listing_model.freezed.dart';
part 'listing_model.g.dart';

@freezed
class Listing with _$Listing {
  const factory Listing({
    required int id,
    required String name,
    required String symbol,
    String? slug,
    @JsonKey(name: 'num_market_pairs') int? numberMarketPairs,
    @JsonKey(name: 'circulating_supply') double? circulatingSupply,
    @JsonKey(name: 'total_supply') double? totalSupply,
    @JsonKey(name: 'quote') required CoinQuote quote,
    @JsonKey(name: 'cmc_rank') int? cmcRank,
    @JsonKey(name: 'last_updated') DateTime? lastUpdated,
    @JsonKey(name: 'date_added') DateTime? dateAdded,
  }) = _Listing;

  const Listing._();

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);

  factory Listing.empty() => Listing(
        id: 0,
        name: '',
        symbol: '',
        quote: CoinQuote.empty(),
      );
}
