import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/data/models/swap/index.dart';
import 'package:flutter_aigun/data/models/wallet/index.dart';
import 'package:flutter_aigun/data/services/index.dart';

class WalletTransactionApi {
  final DioClient _dioClient = getIt<DioClient>();

  static const String _basePath = '/api/v1/wallet_tx';
  Future<SwapQuote> getQuote(
      {required String fromChainId,
      required String toChainId,
      required String inputMint,
      required String outputMint,
      required int amount,
      required int slippage}) async {
    final response = await _dioClient.get(
      '$_basePath/quote',
      queryParameters: {
        'from_chain_id': fromChainId,
        'to_chain_id': toChainId,
        'input_mint': inputMint,
        'amount': amount,
        'slippage': slippage,
        'output_mint': outputMint,
      },
    );

    return SwapQuote.fromJson(response);
  }

  Future<SwapTransaction> swap({
    required String fromChainId,
    required String toChainId,
    required String inputMint,
    required String outputMint,
    required String amount,
    required int slippage,
    required String walletId,
    required String priorityFee,
    // required String paymentPin
  }) async {
    final response = await _dioClient.post(
      '$_basePath/swap',
      data: {
        'from_chain_id': fromChainId,
        'to_chain_id': toChainId,
        'input_mint': inputMint,
        'amount': amount,
        'slippage': slippage,
        'output_mint': outputMint,
        'wallet_id': walletId,
        'priority_fee': priorityFee,
        // 'payment_pin': paymentPin,
      },
    );
    return SwapTransaction.fromJson(response);
  }

  /// 获取交易状态
  Future<WalletTransactionStatus> getTrasactionStatus(
      {required String txHash, required String chainId}) async {
    final response =
        await _dioClient.get("$_basePath/status", queryParameters: {
      "tx_hash": txHash,
      "chain_id": chainId,
    });

    return WalletTransactionStatus.fromJson(response);
  }
}
