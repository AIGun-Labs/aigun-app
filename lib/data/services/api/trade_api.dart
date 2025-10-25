import 'package:flutter_aigun/data/models/trade/setting/trade_custom_setting.dart';
import 'package:flutter_aigun/data/models/transfer/index.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:flutter_aigun/utils/numeric_utils.dart';
import 'package:get_it/get_it.dart';

// TradeMode JSON serialization map
const _tradeModeEnumMap = {
  TradeMode.fast: 'fast',
  TradeMode.normal: 'normal',
  TradeMode.custom: 'custom',
};

class TradeApi {
  static const String _basePath = "/api/v1/wallet_tx";

  final DioClient _dioClient = GetIt.instance<DioClient>();

  Future<TransferTransaction> swap({
    required String network,
    required String fromChainId,
    required String toChainId,
    required String inputMint,
    required String outputMint,
    required String amount,
    // required int slippage,
    // required String priorityFee,
    required String walletId,
    required TradeCustomSetting options,
    required TradeMode mode,
    required int decimals,
  }) async {
    final newOptions = <String, dynamic>{"swap_mode": mode.name.toUpperCase()};

    final newSlippage = NumericUtils.multiply(options.slippage, 100);
    final newPriorityFee = NumericUtils.multiplyByDecimalPower(
      options.priorityFee ?? "",
      decimals,
    ).toString();
    final newTipFee = NumericUtils.multiplyByDecimalPower(
      options.tipFee ?? "",
      decimals,
    ).toString();

    if (outputMint == "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee") {
      outputMint = "";
    }

    if (mode == TradeMode.custom) {
      newOptions['slippage'] = newSlippage;
      newOptions['gas_price'] = options.gasPrice;
      newOptions['mev'] = options.mevProtect;
    }

// solana 特殊处理
    if (network == "solana" &&
        options.gasPrice != null &&
        mode == TradeMode.custom) {
      // 只有solana 自定义模式才需要设置优先费和贿赂费
      newOptions['priority_fee'] = newPriorityFee;
      newOptions['tip_fee'] = newTipFee;
      newOptions.remove("gas_price");
    }
    final path = "$_basePath/$network/swap";

    final Map<String, dynamic> response =
        await _dioClient.post<Map<String, dynamic>>(path, data: {
      "from_chain_id": fromChainId,
      "to_chain_id": toChainId,
      "input_mint": inputMint,
      "output_mint": outputMint,
      "amount": amount,
      "wallet_id": walletId,
      
      // "priority_fee": priorityFee,
      // "slippage": slippage,
      "option": newOptions
    });

    return TransferTransaction.fromJson(response);
  }

  Future<TransferQuote> getQuote({
    required String network,
    required String fromChainId,
    required String toChainId,
    required String inputMint,
    required String outputMint,
    required String amount,
  }) async {
    final path = "$_basePath/$network/quote";

    final Map<String, dynamic> resposne =
        await _dioClient.get<Map<String, dynamic>>(
      path,
      queryParameters: {
        "from_chain_id": fromChainId,
        "to_chain_id": toChainId,
        "input_mint": inputMint,
        "output_mint": outputMint,
        "amount": amount,
      },
    );

    return TransferQuote.fromJson(resposne);
  }
}
