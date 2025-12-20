/// Blockchain-specific constants
///
/// Contains network-specific values and thresholds for different blockchain networks.
abstract class BlockchainConstants {
  BlockchainConstants._();

  /// Minimum SOL balance requirement (0.01 SOL)
  ///
  /// This is the minimum balance that should be maintained after transactions
  /// to ensure users can pay for future transaction fees and account rent.
  static const double minSolanaBalance = 0.01;

  /// Solana token decimals (9)
  static const int solanaDecimals = 9;

  /// Solana network identifier
  static const String networkSolana = 'solana';

  /// Minimum SOL balance in lamports (0.01 * 10^9 = 10,000,000)
  ///
  /// Used for atomic unit calculations to avoid floating-point precision issues.
  static const int minSolanaBalanceLamports = 10000000;
}
