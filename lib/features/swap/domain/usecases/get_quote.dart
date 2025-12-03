import '../../../../core/types/result.dart';
import '../entities/quote_entity.dart';
import '../repositories/swap_repository.dart';

class GetQuote {
  final SwapRepository _repository;

  GetQuote(this._repository);

  Future<Result<QuoteEntity>> call({
    required String network,
    required String fromChainId,
    required String toChainId,
    required String inputMint,
    required String outputMint,
    required String amount,
    required Map<String, dynamic> options,
    required String mode,
    required int decimals,
  }) {
    return _repository.getQuote(
      network: network,
      fromChainId: fromChainId,
      toChainId: toChainId,
      inputMint: inputMint,
      outputMint: outputMint,
      amount: amount,
      options: options,
      mode: mode,
      decimals: decimals,
    );
  }
}
