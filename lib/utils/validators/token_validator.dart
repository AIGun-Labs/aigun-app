class TokenValidator {
  static const Set<String> nativeTokenAddresses = {
    '0x2::sui::SUI',

    '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',

    'So11111111111111111111111111111111111111112',

    'BTC',

    'EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9c',

    'STRK',

    'T9yD14Nj9j7xAB4dbGeiX9h8unkKHxuWwb',

    '11111111111111111111111111111111',
  };

  static const List<String> nativeTokenAddressesByNetwork = ['unknown'];

  @Deprecated('， isNative ')
  static bool isNativeToken(String? contractAddress, {String? network}) {
    if (contractAddress == null || contractAddress.isEmpty) {
      return true;
    }

    if (network != null &&
        network.isNotEmpty &&
        nativeTokenAddressesByNetwork.contains(network)) {
      return true;
    }

    return nativeTokenAddresses.contains(contractAddress);
  }

  ///

  @Deprecated('')
  static bool isNotNativeToken(String? contractAddress) {
    return !isNativeToken(contractAddress);
  }

  static Set<String> getNativeTokenAddresses() {
    return Set<String>.from(nativeTokenAddresses);
  }

  static bool isNative(bool isNative) => isNative ? true : false;

  static bool isUnknown(String? network) => network == 'unknown' ? true : false;

  ///

  static bool shouldShowChainInfo(bool isNativeToken, String network) {
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
