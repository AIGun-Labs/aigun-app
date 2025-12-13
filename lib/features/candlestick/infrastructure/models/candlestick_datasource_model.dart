import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/candlestick_datasource_entity.dart';
import 'candlestick_model.dart';

part 'candlestick_datasource_model.freezed.dart';
part 'candlestick_datasource_model.g.dart';

@freezed
sealed class CandlestickDataSourceModel with _$CandlestickDataSourceModel {
  const CandlestickDataSourceModel._();
  const factory CandlestickDataSourceModel({
    @JsonKey(name: 'quotes') required List<CandlestickModel> candles,
    @JsonKey(name: 'source') required String source,
  }) = _CandlestickDataSourceModel;

  factory CandlestickDataSourceModel.fromJson(Map<String, dynamic> json) =>
      _$CandlestickDataSourceModelFromJson(json);
}
