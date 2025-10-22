import 'package:freezed_annotation/freezed_annotation.dart';

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
