import 'package:get_it/get_it.dart';

import '../../../core/enums/network.dart';
import '../../../enums/trade_mode.dart';
import '../../../shared/utils/calculate_balance.dart';
import '../../../utils/numeric_utils.dart';
import '../../models/trade/setting/trade_custom_setting.dart';
import '../../models/transfer/index.dart';
import '../http/dio_client.dart';

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
    final newOptions = <String, dynamic>{"swap_mode": mode.value.toUpperCase()};

    final newSlippage = NumericUtils.multiply(options.slippage, 100);
    final newPriorityFee = NumericUtils.multiplyByDecimalPower(
      options.priorityFee ?? "",
      decimals,
    ).toString();
    final newTipFee = NumericUtils.multiplyByDecimalPower(
      options.tipFee ?? "",
      decimals,
    ).toString();

    if (mode == TradeMode.custom) {
      newOptions['slippage'] = newSlippage;
      newOptions['gas_price'] = options.gasPrice;
      newOptions['is_mev'] = options.mevProtect;
    }

    if (network == Network.solana.value &&
        options.gasPrice != null &&
        mode == TradeMode.custom) {
      // 只有solana 自定义模式才需要设置优先费和贿赂费
      newOptions['priority_fee'] = newPriorityFee;
      newOptions['tip_fee'] = newTipFee;
      newOptions.remove("gas_price");
    }
    final path = "$_basePath/$network/swap";

    amount = CalculateBalance.calculateTotalTransactionFees(
            tipFee: newTipFee,
            priorityFee: newPriorityFee,
            transactionSol: amount)
        .toString();

    final Map<String, dynamic> response =
        await _dioClient.post<Map<String, dynamic>>(path, data: {
      "from_chain_id": fromChainId,
      "to_chain_id": toChainId,
      "input_mint": inputMint,
      "output_mint": outputMint,
      "amount": amount,
      "wallet_id": walletId,
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
    required TradeCustomSetting options,
    required TradeMode mode,
    required int decimals,
  }) async {
    final newOptions = <String, dynamic>{"swap_mode": mode.value.toUpperCase()};

    final newSlippage = NumericUtils.multiply(options.slippage, 100);
    final newPriorityFee = NumericUtils.multiplyByDecimalPower(
      options.priorityFee ?? "",
      decimals,
    ).toString();
    final newTipFee = NumericUtils.multiplyByDecimalPower(
      options.tipFee ?? "",
      decimals,
    ).toString();

    if (mode == TradeMode.custom) {
      newOptions['slippage'] = newSlippage;
      newOptions['gas_price'] = options.gasPrice;
      newOptions['is_mev'] = options.mevProtect;
    }

    if (network == Network.solana.value &&
        options.gasPrice != null &&
        mode == TradeMode.custom) {
      // 只有solana 自定义模式才需要设置优先费和贿赂费
      newOptions['priority_fee'] = newPriorityFee;
      newOptions['tip_fee'] = newTipFee;
      newOptions.remove("gas_price");
    }
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
        // "gas_price": options.gasPrice,
        // "swap_mode": mode.value.toUpperCase(),
      },
    );

    return TransferQuote.fromJson(resposne);
  }
}
