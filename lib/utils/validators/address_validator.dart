import 'package:flutter_aigun/utils/validators/index.dart';
import 'package:solana_web3/solana_web3.dart';
import 'package:web3dart/web3dart.dart';

class AddressValidator {
  static ValidationResult validateEvmAddress(String address) {
    if (address.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: '地址不能为空',
      );
    }

    try {
      EthereumAddress.fromHex(address);
    } catch (e) {
      return const ValidationResult(
        isValid: false,
        errorMessage: '地址格式不正确',
      );
    }

    return const ValidationResult(isValid: true);
  }

  static ValidationResult validateSolanaAddress(String address) {
    if (address.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: '地址不能为空',
      );
    }

    try {
      Pubkey.fromBase58(address);
    } catch (e) {
      return const ValidationResult(
        isValid: false,
        errorMessage: '地址格式不正确',
      );
    }

    return const ValidationResult(isValid: true);
  }

  static ValidationResult validationAddress(String address) {
    final evmResult = validateEvmAddress(address);

    final solanaResult = validateSolanaAddress(address);

    if (!evmResult.isValid && !solanaResult.isValid) {
      return const ValidationResult(isValid: false);
    }

    return const ValidationResult(isValid: true);
  }
}
