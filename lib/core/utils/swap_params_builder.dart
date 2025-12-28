///
class SwapParamsBuilder {
  final String network;
  final String fromChainId;
  final String toChainId;
  final String inputMint;
  final String outputMint;
  final String amount;
  final String walletId;
  final Map<String, dynamic> options;
  final String mode;
  final int decimals;

  SwapParamsBuilder._({
    required this.network,
    required this.fromChainId,
    required this.toChainId,
    required this.inputMint,
    required this.outputMint,
    required this.amount,
    required this.walletId,
    required this.options,
    required this.mode,
    required this.decimals,
  });

  ///
  static SwapParamsBuilder fromBuyState({
    required dynamic state, // QuickTradeState
    required Map<String, dynamic> settingOptions,
    required String settingMode,
    required String amount,
    required String walletId,
  }) {
    return SwapParamsBuilder._(
      network: state.fromToken?.network ?? '',
      fromChainId: state.fromToken?.unique ?? '',
      toChainId: state.selectedToken?.unique ?? '',
      inputMint: state.fromToken!.address,
      outputMint: state.selectedToken!.address,
      amount: amount,
      walletId: walletId,
      options: settingOptions,
      mode: settingMode,
      decimals: state.fromToken!.decimals,
    );
  }

  ///
  static SwapParamsBuilder fromSellState({
    required dynamic state, // QuickTradeState
    required Map<String, dynamic> settingOptions,
    required String settingMode,
    required String amount,
    required String walletId,
    required String outputMint,
  }) {
    return SwapParamsBuilder._(
      network: state.fromToken?.network ?? '',
      fromChainId: state.selectedToken?.unique ?? '',
      toChainId: state.selectedToken?.unique ?? '',
      inputMint: state.selectedToken!.address,
      outputMint: outputMint,
      amount: amount,
      walletId: walletId,
      options: settingOptions,
      mode: settingMode,
      decimals: state.selectedToken!.decimals,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'network': network,
      'fromChainId': fromChainId,
      'toChainId': toChainId,
      'inputMint': inputMint,
      'outputMint': outputMint,
      'amount': amount,
      'walletId': walletId,
      'options': options,
      'mode': mode,
      'decimals': decimals,
    };
  }

  bool isValid() {
    return network.isNotEmpty &&
        fromChainId.isNotEmpty &&
        toChainId.isNotEmpty &&
        inputMint.isNotEmpty &&
        outputMint.isNotEmpty &&
        amount.isNotEmpty &&
        walletId.isNotEmpty;
  }

  @override
  String toString() {
    return 'SwapParams(network: $network, fromChainId: $fromChainId, '
        'toChainId: $toChainId, inputMint: $inputMint, '
        'outputMint: $outputMint, amount: $amount, walletId: $walletId, '
        'mode: $mode, decimals: $decimals)';
  }
}
