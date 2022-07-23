import 'dart:typed_data';

import 'package:betticos/features/p2p_betting/data/models/crypto/network.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/utils/i_connector.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/qr_code_modal/wallet_connect_qr_code_modal.dart';

class WalletConnectEthereumCredentials extends CustomTransactionSender {
  WalletConnectEthereumCredentials({required this.provider});

  final EthereumWalletConnectProvider provider;

  @override
  Future<EthereumAddress> extractAddress() {
    // TODO: implement extractAddress
    throw UnimplementedError();
  }

  @override
  Future<String> sendTransaction(Transaction transaction) async {
    final String hash = await provider.sendTransaction(
      from: transaction.from!.hex,
      to: transaction.to?.hex,
      data: transaction.data,
      gas: transaction.maxGas,
      gasPrice: transaction.gasPrice?.getInWei,
      value: transaction.value?.getInWei,
      nonce: transaction.nonce,
    );

    return hash;
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToSignature
    throw UnimplementedError();
  }
}

class EthereumConnector implements IConnector {
  EthereumConnector({
    WalletConnectSecureStorage? sessionStorage,
    WalletConnectSession? session,
    this.network,
  }) {
    _connector = WalletConnectQrCodeModal(
      connector: WalletConnect(
        session: session,
        sessionStorage: sessionStorage,
        bridge: 'https://bridge.walletconnect.org',
        clientMeta: const PeerMeta(
          name: 'Bettico',
          description:
              'Bettico wants to connect to your wallet to perform transaction.',
          url: 'https://wealthsecrets.io',
          icons: <String>[
            'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ],
        ),
      ),
    );

    _provider = EthereumWalletConnectProvider(
      _connector.connector,
      chainId: network != null ? network!.chainId : 1,
    );
  }

  final Network? network;

  @override
  Future<SessionStatus?> connect(BuildContext context) {
    return _connector.connect(
      context,
      chainId: network != null ? network!.chainId : 1,
    );
  }

  @override
  void registerListeners(
    OnConnectRequest? onConnect,
    OnSessionUpdate? onSessionUpdate,
    OnDisconnect? onDisconnect,
  ) =>
      _connector.registerListeners(
        onConnect: onConnect,
        onSessionUpdate: onSessionUpdate,
        onDisconnect: onDisconnect,
      );

  @override
  Future<String?> deductCharges({
    required String toAddress,
    required String fromAddress,
    required double amount,
    required Network network,
  }) async {
    final EthereumAddress sender = EthereumAddress.fromHex(fromAddress);
    final EthereumAddress recipient = EthereumAddress.fromHex(toAddress);

    final double chargesAmount = (network.percentage / 100) * amount;

    final EtherAmount etherAmount = EtherAmount.fromUnitAndValue(
      EtherUnit.szabo,
      (chargesAmount * 1000 * 1000).toInt(),
    );

    final Transaction transaction = Transaction(
      to: recipient,
      from: sender,
      value: etherAmount,
      gasPrice: EtherAmount.inWei(BigInt.one),
      maxGas: 100000,
    );

    final WalletConnectEthereumCredentials credentials =
        WalletConnectEthereumCredentials(provider: _provider);

    // Sign the transaction
    try {
      final String txBytes =
          await _ethereum.sendTransaction(credentials, transaction);
      return txBytes;
    } catch (e) {
      // await _connector.killSession();
      return null;
    }
  }

  @override
  Future<String?> sendBettingAmount({
    required String toAddress,
    required String fromAddress,
    required double amount,
    required Network network,
  }) async {
    final EthereumAddress sender = EthereumAddress.fromHex(fromAddress);
    final EthereumAddress recipient = EthereumAddress.fromHex(toAddress);

    final double actualAmount = ((100 - network.percentage) / 100) * amount;

    final EtherAmount etherAmount = EtherAmount.fromUnitAndValue(
      EtherUnit.szabo,
      (actualAmount * 1000 * 1000).toInt(),
    );

    final Transaction transaction = Transaction(
      to: recipient,
      from: sender,
      gasPrice: EtherAmount.inWei(BigInt.one),
      maxGas: 100000,
      value: etherAmount,
    );

    final WalletConnectEthereumCredentials credentials =
        WalletConnectEthereumCredentials(provider: _provider);

    // Sign the transaction
    try {
      final String txBytes =
          await _ethereum.sendTransaction(credentials, transaction);
      return txBytes;
    } catch (e) {
      debugPrint('Error: $e');
      // await _connector.killSession();
      return null;
    }
  }

  @override
  Future<void> openWalletApp() => _connector.openWalletApp();

  @override
  Future<double> getBalance() async {
    final EthereumAddress address =
        EthereumAddress.fromHex(_connector.connector.session.accounts[0]);
    final EtherAmount amount = await _ethereum.getBalance(address);
    return amount.getValueInUnit(EtherUnit.ether).toDouble();
  }

  @override
  bool validateAddress({required String address}) {
    try {
      EthereumAddress.fromHex(address);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  String get faucetUrl => 'https://faucet.dimensions.network/';

  @override
  String get address => _connector.connector.session.accounts[0];

  @override
  String get coinName => 'Eth';

  late final WalletConnectQrCodeModal _connector;
  late final EthereumWalletConnectProvider _provider;
  final Web3Client _ethereum = Web3Client(
    'https://mainnet.infura.io/v3/bb4655ef625d44a695abd5b7d1403519',
    Client(),
  );

  @override
  Future<void> killSession({String? sessionError}) {
    return _connector.connector.killSession();
  }
}
