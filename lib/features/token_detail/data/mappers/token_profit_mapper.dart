import '../../domain/entity/token_profit_entity.dart';
import '../models/token_profit_model.dart';

extension TokenProfitToEntityMapper on TokenProfitModel {
  TokenProfitEntity toEntity() {
    return TokenProfitEntity(
      balance: balance,
      value: value,
      profit: profit,
      riseFall: riseFall,
    );
  }
}
