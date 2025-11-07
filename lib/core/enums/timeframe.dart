enum Timeframe {
  m1('1分钟', Duration(minutes: 1)),
  m5('5分钟', Duration(minutes: 5)),
  m10('10分钟', Duration(minutes: 10)),
  m15('15分钟', Duration(minutes: 15)),
  m30('30分钟', Duration(minutes: 30)),
  h1('1小时', Duration(hours: 1)),
  h4('4小时', Duration(hours: 4)),
  d1('1天', Duration(days: 1)),
  w1('1周', Duration(days: 7));

  final String label;
  final Duration duration;

  const Timeframe(this.label, this.duration);

  /// 获取适合该时间周期的日期格式
  String get dateFormat {
    switch (this) {
      case Timeframe.m1:
      case Timeframe.m5:
      case Timeframe.m10:
      case Timeframe.m15:
      case Timeframe.m30:
        return 'MM/dd HH:mm';
      case Timeframe.h1:
      case Timeframe.h4:
        return 'MM/dd HH:mm';
      case Timeframe.d1:
        return 'MM/dd';
      case Timeframe.w1:
        return 'yyyy/MM/dd';
    }
  }

  /// 获取适合该时间周期的数据点数量
  int get defaultDataCount {
    switch (this) {
      case Timeframe.m1:
      case Timeframe.m5:
      case Timeframe.m10:
      case Timeframe.m15:
      case Timeframe.m30:
        return 200; // 短时间周期显示更多数据点
      case Timeframe.h1:
      case Timeframe.h4:
        return 150;
      case Timeframe.d1:
        return 100;
      case Timeframe.w1:
        return 52; // 一年的周数
    }
  }
}
