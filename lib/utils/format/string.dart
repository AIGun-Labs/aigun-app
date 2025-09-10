class StringFormatter {
  static String splitText(String text, {int splitLength = 10}) {
    if (text.length <= splitLength) {
      return text;
    }
    return '${text.substring(text.length - splitLength)}...';
  }

  static String truncateWithEllipsis(String text) {
    // 检测是否包含中文字符
    bool hasChinese = text.contains(RegExp(r'[\u4e00-\u9fa5]'));

    if (hasChinese) {
      // 中文字符处理 - 超过2个字符时截取前2个
      if (text.length > 2) {
        return '${text.substring(0, 2)}...';
      }
    } else {
      // 英文字符处理 - 超过4个字符时截取前4个
      if (text.length > 4) {
        return '${text.substring(0, 4)}...';
      }
    }

    return text;
  }
}
