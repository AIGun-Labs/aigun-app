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

  /// Sanitizes a string by removing invalid UTF-16 characters
  ///
  /// This fixes "Invalid argument(s): string is not well-formed UTF-16" errors
  /// by filtering out invalid Unicode code points and replacement characters.
  static String sanitizeUtf16(String? input) {
    if (input == null || input.isEmpty) return '';

    try {
      // Use runes to properly handle surrogate pairs and filter invalid characters
      final validRunes = input.runes.where((rune) {
        // Remove Unicode replacement character (U+FFFD) which indicates invalid sequences
        if (rune == 0xFFFD) return false;
        // Remove control characters except common whitespace
        if (rune < 0x20 && rune != 0x09 && rune != 0x0A && rune != 0x0D)
          return false;
        return true;
      });

      return String.fromCharCodes(validRunes);
    } catch (e) {
      // If sanitization fails, return empty string to prevent crashes
      return '';
    }
  }
}
