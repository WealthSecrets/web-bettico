// import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_web3/flutter_web3.dart';

Future<Contract> loadContract(String name, String address, dynamic provider) async {
  final String jsonText = await rootBundle.loadString('assets/json/$name.json');

  // final dynamic decodedText = json.decode(jsonText);
  return Contract(address, jsonText, provider);
}
