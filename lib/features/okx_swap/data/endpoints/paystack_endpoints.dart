class PaystackEndpoints {
  static String methodList(String currency, String? type) =>
      'paystack/bank?currency=$currency${type != null ? '&type=$type' : ''}';
  static String resolveAccount(String accNumber, String bankCode) =>
      'paystack/bank/resolve?account_number=$accNumber&bank_code=$bankCode';
  static String createRecipient = 'paystack/transferrecipient';
  static String initiateTransfer = 'paystack/transfer';
  static String finalizeTransfer = 'paystack/transfer/finalize_transfer';
  static String verifyTransfer(String reference) => 'paystack/transfer/verify/$reference';
}
