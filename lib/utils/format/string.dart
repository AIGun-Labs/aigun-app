class StringFormatter {
  static String splitText(String text, {int splitLength = 10}) {
    if (text.length <= splitLength) {
      return text;
    }
    return '${text.substring(text.length - splitLength)}...';
  }

  static String truncateWithEllipsis(String text) {
    bool hasChinese = text.contains(RegExp(r'[\u4e00-\u9fa5]'));

    if (hasChinese) {
      if (text.length > 2) {
        return '${text.substring(0, 2)}...';
      }
    } else {
      if (text.length > 4) {
        return '${text.substring(0, 4)}...';
      }
    }

    return text;
  }
}
