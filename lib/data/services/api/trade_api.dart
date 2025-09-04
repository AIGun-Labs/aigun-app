import 'package:flutter_aigun/data/models/transfer/index.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';
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
    required int slippage,
    required String priorityFee,
    required String walletId,
  }) async {
    final Map<String, dynamic> response =
        await _dioClient.post<Map<String, dynamic>>("$_basePath/swap", data: {
      "from_chain_id": fromChainId,
      "to_chain_id": toChainId,
      "input_mint": inputMint,
      "output_mint": outputMint,
      "amount": amount,
      "wallet_id": walletId,
      "priority_fee": priorityFee,
      "slippage": slippage,
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
        "slippage": 100
      },
    );

    print("fromChainid: ${fromChainId}");
    print("toChainId: ${toChainId}");
    print("inputMint: ${inputMint}");
    print("outputMint: ${outputMint}");
    print("amount: ${amount}");
    print("slippage: ${slippage}");

    return TransferQuote.fromJson(resposne);
  }
}
