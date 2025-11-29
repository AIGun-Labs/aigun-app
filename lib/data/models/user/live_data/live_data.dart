import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_data.freezed.dart';
part 'live_data.g.dart';

@freezed
sealed class TradeLiveData with _$TradeLiveData {
  const factory TradeLiveData({
    @JsonKey(name: 'priority_fee') String? priorityFee,
    @JsonKey(name: 'tip_fee') String? tipFee,
    @JsonKey(name: 'gas_price') String? gasPrice,
  }) = _TradeLiveData;

  factory TradeLiveData.fromJson(Map<String, dynamic> json) =>
      _$TradeLiveDataFromJson(json);
}
