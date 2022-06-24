// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// import '../../data/models/wallet/wallet.dart';

// class WalletStore {
//   const WalletStore();

//   Future<List<Wallet>> load() async {
//     final File walletFile = await DefaultCacheManager()
//         .getSingleFile('https://registry.walletconnect.org/data/wallets.json');
//     final dynamic walletData = json.decode(await walletFile.readAsString());

//     final dynamic value = walletData.entries
//         .map<Wallet>((dynamic data) =>
//             Wallet.fromJson(data.value as Map<String, dynamic>))
//         .toList();
//     return value as List<Wallet>;
//   }
// }
