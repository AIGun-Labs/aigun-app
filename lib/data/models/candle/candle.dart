import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:k_chart/flutter_k_chart.dart';

part 'candle.freezed.dart';
part 'candle.g.dart';

@freezed
class Candle with _$Candle {
  const factory Candle({
    @JsonKey(name: "time") required String time,
    @JsonKey(name: "open") required String open,
    @JsonKey(name: "high") required String high,
    @JsonKey(name: "low") required String low,
    @JsonKey(name: "close") required String close,
    @JsonKey(name: "volume") required String volume,
  }) = _Candle;

  factory Candle.fromJson(Map<String, dynamic> json) => _$CandleFromJson(json);
}

extension CandleExtension on Candle {
  KLineEntity toKLineEntity() => KLineEntity.fromCustom(
        time: int.tryParse(time) ?? 0,
        open: double.tryParse(open) ?? 0.0,
        high: double.tryParse(high) ?? 0.0,
        low: double.tryParse(low) ?? 0.0,
        close: double.tryParse(close) ?? 0.0,
        vol: double.tryParse(volume) ?? 0.0,
      );
}
