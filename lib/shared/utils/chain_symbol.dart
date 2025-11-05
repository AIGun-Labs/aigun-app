class ChainSymbolUtils {
  static String? getSymbolByNetwork(String network) {
    switch (network) {
      case "solana":
        return "SOL";
      case "eth":
        return "ETH";
      case "base":
        return "ETH";
      case 'bsc':
        return "BNB";
      default:
        return "";
    }
  }
}
