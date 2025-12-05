extension IntX on int {
  /// 将整数转换为至少2位的字符串，不足2位左侧补0
  String two() => toString().padLeft(2, '0');
}
