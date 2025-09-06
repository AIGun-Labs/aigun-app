import 'package:flutter_aigun/data/models/trade/setting/trade_custom_setting.dart';
import 'package:flutter_aigun/data/models/transfer/index.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:flutter_aigun/utils/numeric_utils.dart';
import 'package:get_it/get_it.dart';

class TradeApi {
  static const String _basePath = "/api/v1/wallet_tx";

  final DioClient _dioClient = GetIt.instance<DioClient>();

  Future<TransferTransaction> swap({
    required int fromChainId,
    required int toChainId,
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
    final newSlippage = NumericUtils.multiply(options.slippage, 100);
    final newPriorityFee = NumericUtils.multiplyByDecimalPower(
      options.priorityFee ?? "",
      decimals,
    ).toString();
    final newTipFee = NumericUtils.multiplyByDecimalPower(
      options.tipFee ?? "",
      decimals,
    ).toString();

    final Map<String, dynamic> response =
        await _dioClient.post<Map<String, dynamic>>("$_basePath/swap", data: {
      "from_chain_id": fromChainId,
      "to_chain_id": toChainId,
      "input_mint": inputMint,
      "output_mint": outputMint,
      "amount": amount,
      "wallet_id": walletId,
      // "priority_fee": priorityFee,
      // "slippage": slippage,
      "options": {
        "mode": mode,
        "priority_fee": newPriorityFee,
        "slippage": newSlippage,
        "tip_fee": newTipFee,
        "gas_price": options.gasPrice,
        "mev": options.mevProtect,
      }
    });

    return TransferTransaction.fromJson(response);
  }

  Future<TransferQuote> getQuote({
    required int fromChainId,
    required int toChainId,
    required String inputMint,
    required String outputMint,
    required String amount,
    required int slippage,
    required TradeMode mode,
  }) async {
    final Map<String, dynamic> resposne =
        await _dioClient.get<Map<String, dynamic>>(
      "$_basePath/quote",
      queryParameters: {
        "from_chain_id": fromChainId,
        "to_chain_id": toChainId,
        "input_mint": inputMint,
        "output_mint": outputMint,
        "amount": amount,
        // "slippage": slippage,
        "slippage": 100,
        "mode": mode,
      },
    );

    return TransferQuote.fromJson(resposne);
  }
}
