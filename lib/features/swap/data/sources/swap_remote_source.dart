import '../../../../core/enums/network.dart';
import '../../../../data/models/trade/setting/trade_custom_setting.dart';
import '../../../../enums/trade_mode.dart';
import '../../../../infrastructure/network/dio_client.dart';
import '../../../../utils/numeric_utils.dart';
import '../models/quote_model.dart';
import '../models/transaction_model.dart';
import '../models/transaction_status_model.dart';

class SwapRemoteSource {
  SwapRemoteSource(this._dioClient);
  static const String _basePath = '/api/v1/wallet_tx';

  final DioClient _dioClient;

  Future<TransactionModel> swap({
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
    final newOptions = <String, dynamic>{'swap_mode': mode.value.toUpperCase()};

    final newSlippage = NumericUtils.multiply(options.slippage, 100);
    final newPriorityFee = NumericUtils.multiplyByDecimalPower(
      options.priorityFee ?? '',
      decimals,
    ).toString();
    final newTipFee = NumericUtils.multiplyByDecimalPower(
      options.tipFee ?? '',
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
      newOptions['priority_fee'] = newPriorityFee;
      newOptions['tip_fee'] = newTipFee;
      newOptions.remove('gas_price');
    }
    final path = '$_basePath/$network/swap';

    final Map<String, dynamic>? response = await _dioClient
        .post<Map<String, dynamic>>(
          path,
          data: {
            'from_chain_id': fromChainId,
            'to_chain_id': toChainId,
            'input_mint': inputMint,
            'output_mint': outputMint,
            'amount': amount,
            'wallet_id': walletId,
            'option': newOptions,
          },
        );

    if (response == null) {
      throw Exception('Response is null');
    }

    return TransactionModel.fromJson(response);
  }

  Future<QuoteModel> getQuote({
    required String network,
    required String fromChainId,
    required String toChainId,
    required String inputMint,
    required String outputMint,
    required String amount,
    required TradeCustomSetting options,
    required String mode,
    required int decimals,
  }) async {
    // Convert String mode to TradeMode enum
    final tradeMode = TradeMode.values.firstWhere(
      (e) => e.value == mode.toUpperCase() || e.name == mode.toLowerCase(),
      orElse: () => TradeMode.fast,
    );
    final queryParameters = <String, dynamic>{
      'swap_mode': tradeMode.value.toUpperCase(),
      'from_chain_id': fromChainId,
      'to_chain_id': toChainId,
      'input_mint': inputMint,
      'output_mint': outputMint,
      'amount': amount,
    };

    // final newSlippage = NumericUtils.multiply(options.slippage, 100);
    final newPriorityFee = NumericUtils.multiplyByDecimalPower(
      options.priorityFee ?? '',
      decimals,
    ).toString();
    final newTipFee = NumericUtils.multiplyByDecimalPower(
      options.tipFee ?? '',
      decimals,
    ).toString();

    if (tradeMode == TradeMode.custom) {
      // queryParameters['slippage'] = newSlippage;
      queryParameters['gas_price'] = options.gasPrice;
    }

    if (network == Network.solana.value &&
        options.gasPrice != null &&
        tradeMode == TradeMode.custom) {
      // 只有solana 自定义模式才需要设置优先费和贿赂费
      queryParameters['priority_fee'] = newPriorityFee;
      queryParameters['tip_fee'] = newTipFee;
      queryParameters.remove('gas_price');
    }
    final path = '$_basePath/$network/quote';

    final Map<String, dynamic>? resposne = await _dioClient
        .get<Map<String, dynamic>>(path, queryParameters: queryParameters);

    if (resposne == null) {
      throw Exception('Response is null');
    }

    return QuoteModel.fromJson(resposne);
  }

  /// 获取交易状态
  Future<TransactionStatusModel> getTransactionStatus({
    required String txHash,
    required String chainId,
    required String network,
  }) async {
    final path = '$_basePath/$network/status/$chainId/$txHash';

    final response = await _dioClient.get(path);

    return TransactionStatusModel.fromJson(response);
  }
}
