/// 代币验证器
/// 负责处理代币相关的验证逻辑，特别是主币判断
class TokenValidator {
  /// 已知的主币合约地址集合
  /// 支持多条区块链的主币地址
  static const Set<String> nativeTokenAddresses = {
    // SUI 主币
    '0x2::sui::SUI',

    // ETH 等 EVM 链主币 (零地址表示原生代币)
    '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',

    // SOL 主币
    'So11111111111111111111111111111111111111112',

    // BTC (比特币没有合约地址，使用特殊标识)
    'BTC',

    // TON 主币
    'EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9c',

    // StarkNet 主币
    'STRK',

    // TRX 主币
    'T9yD14Nj9j7xAB4dbGeiX9h8unkKHxuWwb',

    // 其他可能的原生代币标识
    '11111111111111111111111111111111',
  };

  static const List<String> nativeTokenAddressesByNetwork = ['unknown'];

  @Deprecated('已废弃，请使用 isNative 方法')
  static bool isNativeToken(String? contractAddress, {String? network}) {
    // 如果合约地址为 null 或空，认为是主币
    if (contractAddress == null || contractAddress.isEmpty) {
      return true;
    }

    if (network != null &&
        network.isNotEmpty &&
        nativeTokenAddressesByNetwork.contains(network)) {
      return true;
    }

    // 检查合约地址是否在已知的主币地址列表中
    return nativeTokenAddresses.contains(contractAddress);
  }

  /// 判断给定的合约地址是否为非主币（普通代币）
  ///
  /// [contractAddress] 合约地址，可以为 null 或空字符串
  /// 返回 true 表示不是主币，false 表示是主币
  @Deprecated('已废弃')
  static bool isNotNativeToken(String? contractAddress) {
    return !isNativeToken(contractAddress);
  }

  /// 获取所有主币地址的副本
  static Set<String> getNativeTokenAddresses() {
    return Set<String>.from(nativeTokenAddresses);
  }

  static bool isNative(bool? isNative) => isNative ?? false ? true : false;

  static bool isUnknown(String? network) => network == 'unknown' ? true : false;

  /// 判断是否显示链信息（Logo 和地址）
  ///
  /// 结合了 [isNative] 和 [isUnknown] 的判断逻辑
  static bool shouldShowChainInfo(bool isNativeToken, String network) {
    // 如果是未知网络，不显示 ||  如果是原生代币，也不显示（通常原生代币没有合约地址）
    if (isUnknown(network) || isNative(isNativeToken)) return false;

    return true;
  }

  static bool shouldShowAddress(bool isNativeToken, String network) {
    return isUnknown(network) || isNative(isNativeToken) ? false : true;
  }

  static bool shouldShowChainLogo(String? network, String? logo) {
    if (logo?.isEmpty ?? true) return false;
    return isUnknown(network) ? false : true;
  }
}
