import 'package:web3dart/web3dart.dart';
import 'package:solana_web3/solana_web3.dart' as solana;
// import 'package:bitcoin_base/bitcoin_base.dart' as btc;

enum ChainAddressType {
  evm, // Ethereum, BSC, etc
  solana,
  bitcoin,
  unknown
}

class Web3Address {
  /// 检查地址类型并返回规范化的地址
  static (ChainAddressType, String) checkAddress(String address) {
    if (address.isEmpty) {
      throw ArgumentError('地址不能为空');
    }

    // 按顺序检查各种地址类型
    final evmResult = _checkEvmAddress(address);
    if (evmResult != null) return evmResult;

    final solanaResult = _checkSolanaAddress(address);
    if (solanaResult != null) return solanaResult;

    // final btcResult = _checkBitcoinAddress(address);
    // if (btcResult != null) return btcResult;

    return (ChainAddressType.unknown, address);
  }

  /// 检查 EVM 地址
  static (ChainAddressType, String)? _checkEvmAddress(String address) {
    try {
      // 移除0x前缀（如果存在）
      final cleanAddress =
          address.startsWith('0x') ? address.substring(2) : address;

      // 基本长度检查
      if (cleanAddress.length != 40) return null;

      final evmAddress = EthereumAddress.fromHex(cleanAddress);
      return (ChainAddressType.evm, evmAddress.hexEip55);
    } catch (_) {
      return null;
    }
  }

  /// 检查 Solana 地址
  static (ChainAddressType, String)? _checkSolanaAddress(String address) {
    try {
      // 基本长度检查
      if (address.length < 32 || address.length > 44) return null;

      final solanaAddress = solana.Pubkey.fromBase58(address);
      return (ChainAddressType.solana, solanaAddress.toBase58());
    } catch (_) {
      return null;
    }
  }

  // /// 检查比特币地址
  // static (ChainAddressType, String)? _checkBitcoinAddress(String address) {
  //   try {
  //     final btcAddress = btc.BitcoinAddress.fromBaseAddress(address,
  //         network: btc.BitcoinNetwork.mainnet,);
  //     if (btcAddress.network == btc.BitcoinNetwork.mainnet) {
  //       return (ChainAddressType.bitcoin, address);
  //     }
  //     return null;
  //   } catch (_) {
  //     return null;
  //   }
  // }

  /// 检查地址是否有效
  static bool isValidAddress(String address) {
    try {
      final (type, _) = checkAddress(address);
      return type != ChainAddressType.unknown;
    } catch (_) {
      return false;
    }
  }

  static String desensitization(String? address) {
    if (address == null || address.isEmpty) {
      return '';
    }
    if (address.length <= 10) {
      return address;
    }
    final frist = address.substring(0, 6);
    final last = address.substring(address.length - 4);
    return '$frist...$last';
  }
}
