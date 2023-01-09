class TransactionEndpoints {
  static const String transactions = 'transactions';
  static String updateTransaction(String hash) => 'transactions/$hash';
  static String userTransactions(String userId) => 'users/$userId/transactions';
  static String userDeposits(String userId) =>
      'transactions/user/$userId/deposits';
  static String userWithdrawals(String userId) =>
      'transactions/user/$userId/withdrawals';
}
