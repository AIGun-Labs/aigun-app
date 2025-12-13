import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/value_object/candlestick_datasource.dart';
import '../../infrastructure/models/candlestick_datasource_model.dart';
import 'candlestick_entity.dart';

part 'candlestick_datasource_entity.freezed.dart';

@freezed
sealed class CandlestickDataSourceEntity with _$CandlestickDataSourceEntity {
  const CandlestickDataSourceEntity._();
  const factory CandlestickDataSourceEntity({
    required List<CandlestickEntity> candles,
    required String source,
  }) = _CandlestickDatasourceEntity;

  factory CandlestickDataSourceEntity.fromModel(
    CandlestickDataSourceModel model,
  ) => CandlestickDataSourceEntity(
    candles: model.candles.map((e) => e.toEntity()).toList(),
    source: model.source,
  );
}
