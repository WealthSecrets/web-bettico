import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'PAYSTACK_KEY', obfuscate: true)
  static final String paystackKey = _Env.paystackKey;
  @EnviedField(varName: 'WALLET_PHRASE', obfuscate: true)
  static final String walletPhrase = _Env.walletPhrase;
  @EnviedField(varName: 'WSC_CONTRACT_ADDRESS', obfuscate: true)
  static final String wscContractAddress = _Env.wscContractAddress;
  @EnviedField(varName: 'RECEIVE_ADDRESS', obfuscate: true)
  static final String receiveAddress = _Env.receiveAddress;
  @EnviedField(varName: 'USDT_CONTRACT_ADDRESS', obfuscate: true)
  static final String usdtContractAddress = _Env.usdtContractAddress;
}
