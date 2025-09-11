class TradeValidator {
  static bool isChainIdEmpty(String sourceId, String targetId) {
    if (sourceId.isEmpty && targetId.isEmpty) {
      return true;
    }
    return false;
  }

  static bool equalsAddress(String sourceId, String targetId) {
    if (sourceId == targetId) {
      return true;
    }
    return false;
  }
}
