import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:k_chart/flutter_k_chart.dart';

part 'candle.freezed.dart';
part 'candle.g.dart';

@freezed
sealed class Candle with _$Candle {
  const factory Candle({
    @JsonKey(name: 'time') required String time,
    @JsonKey(name: 'open') required String open,
    @JsonKey(name: 'high') required String high,
    @JsonKey(name: 'low') required String low,
    @JsonKey(name: 'close') required String close,
    @JsonKey(name: 'volume') required String volume,
  }) = _Candle;

  factory Candle.fromJson(Map<String, dynamic> json) => _$CandleFromJson(json);
}

extension CandleExtension on Candle {
  KLineEntity toKLineEntity() {
    final parsedTime = int.tryParse(time) ?? 0;
    final parsedOpen = double.tryParse(open) ?? 0.0;
    final parsedHigh = double.tryParse(high) ?? 0.0;
    final parsedLow = double.tryParse(low) ?? 0.0;
    final parsedClose = double.tryParse(close) ?? 0.0;
    final parsedVol = double.tryParse(volume) ?? 0.0;

    if (parsedOpen == 0.0 &&
        parsedHigh == 0.0 &&
        parsedLow == 0.0 &&
        parsedClose == 0.0) {
      print('⚠️ : K0!');
      print(
        ' - time: $time, open: $open, high: $high, low: $low, close: $close, volume: $volume',
      );
    }

    return KLineEntity.fromCustom(
      time: parsedTime,
      open: parsedOpen,
      high: parsedHigh,
      low: parsedLow,
      close: parsedClose,
      vol: parsedVol,
    );
  }
}
