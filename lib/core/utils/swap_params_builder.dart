/// Swap API 参数构建器
///
/// 用于封装和构建 swap API 调用所需的参数
/// 遵循 Builder 模式,提供清晰的参数构建接口
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

  /// 从 QuickTradeState 和 TradeSetting 构建 Buy 模式参数
  ///
  /// [state] - QuickTradeState 包含交易状态
  /// [settingOptions] - 交易设置选项
  /// [settingMode] - 交易模式
  /// [amount] - 已转换为原子单位的金额
  /// [walletId] - 钱包 ID
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

  /// 从 QuickTradeState 和 TradeSetting 构建 Sell 模式参数
  ///
  /// [state] - QuickTradeState 包含交易状态
  /// [settingOptions] - 交易设置选项
  /// [settingMode] - 交易模式
  /// [amount] - 已转换为原子单位的金额
  /// [walletId] - 钱包 ID
  /// [outputMint] - 输出代币地址 (通过 getOutputMint 获取)
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

  /// 将参数转换为 Map,便于直接传递给 API
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

  /// 验证参数是否有效
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
