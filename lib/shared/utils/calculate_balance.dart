class CalculateBalance {
  
  /// tipFee + priorityFee + transactionSol < solBalance
  static bool hasEnoughSolForTransaction({
    required String tipFee,
    required String priorityFee,
    required String transactionSol,
    required String solBalance,
  }) {
    try {
      final tipFeeAmount = double.tryParse(tipFee) ?? 0.0;
      final priorityFeeAmount = double.tryParse(priorityFee) ?? 0.0;
      final transactionSolAmount = double.tryParse(transactionSol) ?? 0.0;
      final solBalanceAmount = double.tryParse(solBalance) ?? 0.0;

      final totalFees = tipFeeAmount + priorityFeeAmount + transactionSolAmount;

      return solBalanceAmount >= totalFees;
    } catch (e) {
      return false;
    }
  }

  
  static double calculateTotalTransactionFees({
    required String tipFee,
    required String priorityFee,
    required String transactionSol,
  }) {
    final tipFeeAmount = double.tryParse(tipFee) ?? 0.0;
    final priorityFeeAmount = double.tryParse(priorityFee) ?? 0.0;
    final transactionSolAmount = double.tryParse(transactionSol) ?? 0.0;

    return tipFeeAmount + priorityFeeAmount + transactionSolAmount;
  }

  static bool hasEnoughTokenForTransaction({
    required String tipFee,
    required String priorityFee,
    required String transactionSol,
    required String solBalance,
    required String network,
  }) {
    if (network == "solana") {
      return hasEnoughSolForTransaction(
        tipFee: tipFee,
        priorityFee: priorityFee,
        transactionSol: transactionSol,
        solBalance: solBalance,
      );
    }
    return true;
  }
}
