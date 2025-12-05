import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'value')
enum TradeMode {
  fast("FAST"),
  normal("NORMAL"),
  custom("CUSTOMER");

  final String value;

  const TradeMode(this.value);
}
