import 'package:betticos/core/core.dart';
import 'package:betticos/env/env.dart';
import 'package:betticos/features/p2p_betting/data/models/crypto/volume.dart';
import 'package:betticos/features/p2p_betting/domain/requests/crypto/convert_amount_request.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/crypto/convert_amount_to_currency.dart';
import 'package:betticos/features/shares/data/abi.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

const int weiMultiplier = 1000000000000000000;

class WalletController extends GetxController {
  WalletController({required this.convertAmountToCurrency});

  final ConvertAmountToCurrency convertAmountToCurrency;

  static const int operatingChain = 56;

  final WalletConnectProvider wc = WalletConnectProvider.binance();

  Web3Provider? web3wc;
  Contract? contract;

  RxString selectedCurrency = 'wsc'.obs;
  RxDouble convertedAmount = 0.0.obs;
  RxInt currentChain = (-1).obs;
  RxString randomMessage = ''.obs;
  RxString valuesChecker = ''.obs;
  RxString walletAddress = ''.obs;
  RxString walletBalance = ''.obs;
  RxString creatorBalance = '4.00'.obs;
  RxBool isConnectingWallet = false.obs;
  RxBool wcConnected = false.obs;
  RxBool isMakingPayment = false.obs;
  RxBool showLoadingLogo = false.obs;
  RxBool isLoading = false.obs;

  RxBool isCreatingSale = false.obs;

  @override
  void onInit() {
    listenToEvents();
    super.onInit();
  }

  void listenToEvents() {
    if (contract != null) {
      contract?.on('SaleCreated',
          (saleId, creator, targetAmount, startTime, endTime, sharePrice, subscriptionPrice, saleType) {
        randomMessage('Sales has been created successfully: $saleId, $creator, $targetAmount, $startTime ');
      });
    }
  }

  Future<void> connectProvider([Function(String wallet)? func]) async {
    if (ethereum != null) {
      try {
        final List<String> accs = await ethereum!.requestAccount();
        if (accs.isNotEmpty) {
          web3wc = Web3Provider.fromEthereum(ethereum!);
          walletAddress.value = accs.first;
          currentChain.value = await ethereum!.getChainId();
          final BigInt balance = await web3wc!.getBalance(accs.first);
          final double etherBalance = balance.toInt() / weiMultiplier;
          walletBalance(etherBalance.toStringAsFixed(2));
          contract = Contract('0x1dd825509AEf0Dc4b1F78426B860afD9DC014a2b', Interface(jsonAbi), web3wc!.getSigner());
          func?.call(accs.first);
          listenToEvents();
        }
      } catch (e) {
        randomMessage.value = '$e';
      }
    }
  }

  Future<void> connectWallet([Function(String wallet)? func]) async {
    isConnectingWallet.value = true;
    try {
      await wc.connect();

      if (wc.connected) {
        walletAddress.value = wc.accounts.first;
        currentChain.value = 56;
        web3wc = Web3Provider.fromWalletConnect(wc);
        final BigInt balance = await web3wc!.getBalance(wc.accounts.first);
        final double etherBalance = balance.toInt() / weiMultiplier;
        walletBalance(etherBalance.toStringAsFixed(2));
        contract = Contract('0x1dd825509AEf0Dc4b1F78426B860afD9DC014a2b', Interface(jsonAbi), web3wc!.getSigner());
        wcConnected.value = true;
      }
      func?.call(wc.accounts.first);
      randomMessage.value = 'Successfull connected: ${wc.accounts.first}';
      isConnectingWallet.value = false;
    } catch (error) {
      debugPrint('An error has occurred: $error');
      isConnectingWallet.value = false;
    }
  }

  void walletInit([Function(String wallet)? func]) async {
    isConnectingWallet.value = true;
    if (Ethereum.isSupported) {
      await connectProvider(func);

      ethereum!.onAccountsChanged((List<String> accs) {
        disconnect();
      });

      ethereum!.onChainChanged((int chain) {
        disconnect();
      });
      isConnectingWallet.value = false;
    } else {
      await connectWallet(func);
      isConnectingWallet.value = false;
    }
  }

  Future<dynamic> getContractBalance() async {
    final dynamic value = await contract?.call('getContractBalance');
    return value;
  }

  Future<dynamic> getCreatorBalance() async {
    try {
      if (contract != null) {
        final BigInt balance = await contract!.call<BigInt>('getCreatorBalance', []);
        final double etherBalance = balance.toInt() / weiMultiplier;
        creatorBalance.value = etherBalance.toStringAsFixed(2);
        randomMessage.value = 'getCreatorBalance called: ${etherBalance.toString()}';
      }
    } catch (e) {
      randomMessage.value = 'Error occurrred whiles getting creator balance: $e';
    }
  }

// double targetAmount, int duration, int startTime, double sharePrice, double subcriptionPrice
  void createSale(
    String targetAmount,
    String duration,
    String startTime,
    String sharePrice,
    String subcriptionPrice,
  ) async {
    randomMessage.value = 'creating sales....';
    isCreatingSale(true);
    try {
      if (contract != null) {
        randomMessage.value = 'Inside the contract';
        valuesChecker.value =
            'Target Amount: $targetAmount, Duration: $duration, startTime: $startTime, sharePrice: $sharePrice, subscriptionPrice $subcriptionPrice';
        final TransactionResponse tx = await contract!.send(
          'createSale',
          <String>[targetAmount, duration, startTime, sharePrice, subcriptionPrice, '2'],
        );

        final String hash = tx.hash; // 0xbar

        final TransactionReceipt receipt = await tx.wait(); // Wait until transaction complete

        randomMessage.value = 'hash: $hash\nfromAddress:${receipt.from}';
        isCreatingSale(false);
      }
    } catch (e) {
      randomMessage.value = 'Error occurrred whiles creating sale: $e';
      isCreatingSale(false);
    }
  }

  void getAllSales() async {
    try {
      if (contract != null) {
        final response = await contract!.call('getAllSales', []);
        randomMessage.value = 'getAllSales: $response';
      }
    } catch (e) {
      randomMessage.value = 'Error occurrred whiles getting creator balance: $e';
    }
  }

  Future<TransactionResponse?> send(
    BuildContext context, {
    required double amt,
    required String depositAddress,
    required ContractERC20 token,
  }) async {
    showLoadingLogo.value = true;

    final double amount = amt * 1000000000 * 1000000000;

    try {
      await AppSnacks.show(
        context,
        message: 'Please check you wallet app to confirm payment',
        backgroundColor: context.colors.success,
        duration: const Duration(seconds: 5),
        leadingIcon: const Icon(Ionicons.checkmark_circle_sharp, size: 20, color: Colors.white),
      );

      final TransactionResponse response = await token.transfer(
        depositAddress,
        BigInt.from(amount.round()),
      );

      showLoadingLogo.value = false;
      return response;
    } catch (e) {
      showLoadingLogo.value = false;
      await AppSnacks.show(context, message: 'Couldn\'t make payment, please check your wallet balance');
      return null;
    }
  }

  Future<TransactionResponse?> sendWsc(BuildContext context, double amount) async {
    try {
      final ContractERC20 token = ContractERC20(Env.wscContractAddress, web3wc!.getSigner());

      final TransactionResponse? response =
          await send(context, amt: amount, token: token, depositAddress: Env.receiveAddress);
      return response;
    } catch (e) {
      await AppSnacks.show(context, message: 'Something went wrong!');
      return null;
    }
  }

  Future<TransactionResponse?> sendUsdt(BuildContext context, double amount, String depositAddress) async {
    isMakingPayment(true);
    try {
      final ContractERC20 token = ContractERC20(Env.usdtContractAddress, web3wc!.getSigner());

      final TransactionResponse? response =
          await send(context, amt: amount, token: token, depositAddress: depositAddress);
      isMakingPayment(false);
      return response;
    } catch (e) {
      isMakingPayment(false);
      await AppSnacks.show(context, message: '$e');
      return null;
    }
  }

  Future<TransactionResponse?> payout(
    BuildContext context,
    String winningAddress,
    double payoutAmount,
    String betId,
  ) async {
    showLoadingLogo.value = true;

    final double amount = convertedAmount * 1000000000 * 1000000000;

    final Wallet wallet = Wallet.fromMnemonic(Env.walletPhrase);

    final JsonRpcProvider jsonRpcProvider = JsonRpcProvider('https://bsc-dataseed.binance.org/');
    final Wallet walletProvider = wallet.connect(jsonRpcProvider);

    final ContractERC20 token = ContractERC20(Env.wscContractAddress, walletProvider);

    try {
      final TransactionResponse response = await token.transfer(
        winningAddress,
        BigInt.from(amount.round()),
      );

      showLoadingLogo.value = false;
      return response;
    } catch (e) {
      showLoadingLogo.value = false;
      await AppSnacks.show(context, message: 'Sorry, cashout failed');
      return null;
    }
  }

  void setSelectedCurrency(String currency) {
    selectedCurrency.value = currency.toLowerCase();
  }

  void convertAmount(
    BuildContext context,
    String currency,
    double amount, {
    void Function()? failureCallback,
    void Function(double amount)? successCallback,
    String? betId,
  }) async {
    isLoading(true);

    setSelectedCurrency(currency);

    final Either<Failure, Volume> failureOrVolume =
        await convertAmountToCurrency(ConvertAmountRequest(amount: amount, currency: currency));

    failureOrVolume.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
        failureCallback?.call();
      },
      (Volume vol) {
        isLoading(false);
        convertedAmount.value = vol.convertedAmount;
        successCallback?.call(vol.convertedAmount);
      },
    );
  }

  bool get isInOperatingChain => currentChain.value == operatingChain;

  bool get isConnected => walletAddress.value.isNotEmpty;

  void disconnect() {
    wc.disconnect();
    walletAddress.value = '';
    currentChain.value = -1;
    wcConnected.value = false;
    web3wc = null;
  }

  void setRandomMessage(String value) {
    randomMessage(value);
  }
}
