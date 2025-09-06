class StringFormatter {
  static String splitText(String text, {int splitLength = 10}) {
    if (text.length <= splitLength) {
      return text;
    }
    return '${text.substring(text.length - splitLength)}...';
  }
}
