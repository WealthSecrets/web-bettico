class OkxEndpoints {
  static const String subAccount = 'okx/broker/create-subaccount';
  static String deleteSubAccount(String id) =>
      'okx/broker/delete-subaccount/$id';
  static const String getSubAccount = 'okx/broker/subaccount-info';
  static const String subAccountApiKey = 'okx/broker/subaccount/apikey';
  static const String depositAddress = 'okx/broker/subaccount-deposit-address';
  static const String depositHistory = 'okx/broker/subaccount-deposit-history';
  static const String withdrawalHistory =
      'okx/broker/subaccount-withdrawal-history';
  static const String currencies = 'okx/asset/convert/currencies';
  static String currencyPair(String fromCcy, String toCcy) =>
      'okx/asset/convert/currency-pair?fromCcy=$fromCcy&toCcy=$toCcy';
  static const String estimateQuote = 'okx/asset/convert/estimate-quote';
  static const String convertTrade = 'okx/asset/convert/trade';
  static const String convertHistory = 'okx/asset/convert/history';
  static const String assetCurrencies = 'okx/asset/currencies';
  static const String withdrawal = 'okx/asset/withdraw';
  static const String okxAccount = 'okx/user';
  static const String balances = 'okx/asset/balances';
}
