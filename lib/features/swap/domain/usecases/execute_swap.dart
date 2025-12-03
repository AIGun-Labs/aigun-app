import '../../../../core/types/result.dart';
import '../../../../data/models/trade/setting/trade_custom_setting.dart';
import '../../../../enums/trade_mode.dart';
import '../entities/swap_result_entity.dart';
import '../repositories/swap_repository.dart';

class ExecuteSwap {
  final SwapRepository _repository;

  ExecuteSwap(this._repository);

  Future<Result<SwapResultEntity>> call({
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
    return _repository.executeSwap(
      network: network,
      fromChainId: fromChainId,
      toChainId: toChainId,
      inputMint: inputMint,
      outputMint: outputMint,
      amount: amount,
      walletId: walletId,
      options: options,
      mode: mode,
      decimals: decimals,
    );
  }
}
