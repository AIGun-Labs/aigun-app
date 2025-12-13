import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/value_object/network.dart';

part 'get_candlestick_params.freezed.dart';

@freezed
sealed class GetCandlestickParams with _$GetCandlestickParams {
  const factory GetCandlestickParams({
    required ChainNetwork? network,
    required String? tokenContractAddress,
    required String? bar,
    required int? limit,
    required int? from,
    required int? to,
  }) = _GetCandlestickParams;
}
