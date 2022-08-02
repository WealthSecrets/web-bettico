import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/wallet.dart';

class WalletStore {
  const WalletStore();

  Future<List<Wallet>> load() async {
    final Uri url =
        Uri.parse('https://registry.walletconnect.org/data/wallets.json');
    final http.Response response = await http.get(url);
    print('the response body: ${response.body}');
    final Map<String, dynamic> walletData =
        json.decode(response.body) as Map<String, dynamic>;

    return walletData.entries
        .map<Wallet>((MapEntry<String, dynamic> data) =>
            Wallet.fromJson(data.value as Map<String, dynamic>))
        .toList();
  }
}
