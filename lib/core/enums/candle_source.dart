import 'timeframe.dart';

enum CandleSource {
  okx('okx'),
  cmc('cmc');

  const CandleSource(this.value);

  List<Timeframe> get supportedTimeframes {
    switch (this) {
      case CandleSource.cmc:
        return Timeframe.values
            .where((t) => t != Timeframe.m1 && t != Timeframe.m5)
            .toList();
      case CandleSource.okx:
        return Timeframe.values.toList();
    }
  }

  // 添加：获取该 source 的默认 timeframe
  Timeframe get defaultTimeframe {
    switch (this) {
      case CandleSource.cmc:
        return Timeframe.m15;
      case CandleSource.okx:
        return Timeframe.m5;
    }
  }

  factory CandleSource.fromString(String value) {
    return CandleSource.values.firstWhere(
      (e) => e.value == value,
      orElse: () => CandleSource.okx,
    );
  }

  final String value;
}
