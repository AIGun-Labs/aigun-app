class AddressFormatter {
  static String formatAddress(String address) {
    const int prefixLength = 6;
    const int suffixLength = 4;
    if (address.length <= prefixLength + suffixLength) {
      return address;
    }
    final String prefix = address.substring(0, prefixLength);
    final String suffix = address.substring(address.length - suffixLength);
    return '$prefix...$suffix';
  }
}
