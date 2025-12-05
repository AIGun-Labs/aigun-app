import 'package:web3dart/web3dart.dart';

import '../logger.dart';

class GasCalculator {
  static EtherAmount calculateGasFee({
    required String gasPrice,
    String? gasLimit,
  }) {
    final gasPriceBigInt = _safeParseBigInt(gasPrice);

    if (gasPriceBigInt == null) {
      return EtherAmount.inWei(BigInt.zero);
    }

    return EtherAmount.inWei(gasPriceBigInt);
  }

  static BigInt? _safeParseBigInt(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return null;
    }

    try {
      return BigInt.parse(trimmedValue);
    } catch (e) {
      if (trimmedValue.contains('e') || trimmedValue.contains('E')) {
        try {
          final doubleValue = double.parse(trimmedValue);

          return BigInt.from(doubleValue * 1e18);
        } catch (e2) {
          Logger.error(
            'Failed to parse scientific notation: $trimmedValue, error: $e2',
          );
          return null;
        }
      }

      if (trimmedValue.contains('.')) {
        try {
          final doubleValue = double.parse(trimmedValue);

          return BigInt.from(doubleValue * 1e18);
        } catch (e2) {
          Logger.error('Failed to parse decimal: $trimmedValue, error: $e2');
          return null;
        }
      }

      Logger.error('Failed to parse BigInt: $trimmedValue, error: $e');
      return null;
    }
  }

  static String formatGasPrice({
    required String gasPrice,
    required int decimals,
  }) {
    final gasPriceBigInt = _safeParseBigInt(gasPrice);

    if (gasPriceBigInt == null) {
      return '0.0';
    }

    final divisor = BigInt.from(10).pow(decimals);
    final quotient = gasPriceBigInt ~/ divisor;
    final remainder = gasPriceBigInt % divisor;

    return '$quotient.${remainder.toString().padLeft(decimals, '0')}';
  }
}
