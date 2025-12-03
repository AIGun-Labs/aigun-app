import 'package:flutter/material.dart';

/// Token 卡片配置
///
/// 封装 Token 显示所需的所有数据
class TokenCardConfig {
  /// Token 符号
  final String symbol;

  /// Token 名称
  final String tokenName;

  /// Token 头像 URL
  final String tokenAvatar;

  /// 链 Logo URL
  final String chainLogo;

  /// 链名称
  final String chainName;

  /// 美元价值
  final String dollarValue;

  /// 金额（用于显示）
  final String? amount;

  /// 小数位数
  final int decimals;

  /// 是否为原生代币
  final bool isNative;

  const TokenCardConfig({
    required this.symbol,
    required this.tokenName,
    required this.tokenAvatar,
    required this.chainLogo,
    required this.chainName,
    required this.dollarValue,
    required this.decimals,
    required this.isNative,
    this.amount,
  });

  /// 是否已选择 Token
  bool get hasSelectedToken => tokenName.isNotEmpty;

  /// 创建空配置
  factory TokenCardConfig.empty() => const TokenCardConfig(
        symbol: '',
        tokenName: '',
        tokenAvatar: '',
        chainLogo: '',
        chainName: '',
        dollarValue: '',
        decimals: 0,
        isNative: false,
      );
}

/// Token 卡片交互配置
class TokenCardInteraction {
  /// 是否可编辑金额
  final bool isEditable;

  /// 是否为源 Token（用于同步状态）
  final bool isSourceToken;

  /// 选择 Token 回调
  final VoidCallback? onSelectToken;

  /// 金额变化回调
  final ValueChanged<String>? onAmountChanged;

  /// 外部控制器（可选）
  final TextEditingController? amountController;

  const TokenCardInteraction({
    this.isEditable = false,
    this.isSourceToken = false,
    this.onSelectToken,
    this.onAmountChanged,
    this.amountController,
  });
}
