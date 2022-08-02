import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

import '../../../data/models/crypto/network.dart';

abstract class IConnector {
  Future<SessionStatus?> connect(BuildContext context);

  Future<String?> deductCharges({
    required String toAddress,
    required String fromAddress,
    required double amount,
    required Network network,
  });

  Future<String?> sendBettingAmount({
    required String toAddress,
    required String fromAddress,
    required double amount,
    required Network network,
  });

  Future<void> openWalletApp();

  Future<void> killSession({String? sessionError});

  Future<double> getBalance();

  bool validateAddress({required String address});

  String get faucetUrl;

  String get address;

  String get coinName;

  void registerListeners(
    OnConnectRequest? onConnect,
    OnSessionUpdate? onSessionUpdate,
    OnDisconnect? onDisconnect,
  );
}
