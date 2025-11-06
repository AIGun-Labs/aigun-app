import 'package:flutter_aigun/core/enums/network.dart';
import 'package:flutter_aigun/data/models/trade/setting/trade_custom_setting.dart';

class TradeConfigUtils {
  Map<String, dynamic> getConfigByNetwork(
      String network, TradeCustomSetting tradeConfig) {
    if (network == Network.solana.value) {
      return {
        "mev": tradeConfig.mevProtect,
        "tip_fee": tradeConfig.tipFee,
        "slippage": tradeConfig.slippage,
        "priority_fee": tradeConfig.priorityFee
      };
    } else {
      return {
        "mev": tradeConfig.mevProtect,
        "gas_price": tradeConfig.tipFee,
        "slippage": tradeConfig.slippage,
      };
    }
  }
}
