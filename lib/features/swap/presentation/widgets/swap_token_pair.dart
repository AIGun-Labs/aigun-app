import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/extensions/string.dart';
import '../../../../widgets/token/models/token.dart';
import '../cubit/swap/swap_cubit.dart';
import '../cubit/swap/swap_state.dart';
import 'swap_converters.dart';
import 'swap_divider.dart';
import 'token_card/index.dart';

/// 代币交换对组件
///
/// 显示来源代币和目标代币卡片，支持代币选择和金额输入
/// 遵循单一职责原则，只负责代币对的展示和交互
class SwapTokenPair extends StatelessWidget {
  const SwapTokenPair({
    super.key,
    required this.onSelectSourceToken,
    required this.onSelectTargetToken,
  });

  /// 选择来源代币回调
  final void Function(List<Token> availableTokens) onSelectSourceToken;

  /// 选择目标代币回调
  final void Function(List<Token> availableTokens) onSelectTargetToken;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwapCubit, SwapState>(
      buildWhen: _shouldRebuild,
      builder: (context, state) {
        final availableTokens = _buildAvailableTokens(state);
        final fromTokenConfig = _buildFromTokenConfig(state);
        final toTokenConfig = _buildToTokenConfig(state);

        return Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 来源代币卡片
                TokenCard(
                  config: fromTokenConfig,
                  interaction: TokenCardInteraction(
                    isEditable: true,
                    isSourceToken: true,
                    onSelectToken: () => onSelectSourceToken(availableTokens),
                    onAmountChanged: (amount) =>
                        context.read<SwapCubit>().updateAmount(amount),
                  ),
                ),
                const SwapTokenDivider(),
                // 目标代币卡片
                TokenCard(
                  config: toTokenConfig,
                  interaction: TokenCardInteraction(
                    isEditable: false,
                    isSourceToken: false,
                    onSelectToken: () => onSelectTargetToken(availableTokens),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// 判断是否需要重建
  bool _shouldRebuild(SwapState previous, SwapState current) {
    return previous.quote != current.quote ||
        previous.fromToken != current.fromToken ||
        previous.toToken != current.toToken ||
        previous.availableTokens != current.availableTokens ||
        previous.nativeTokens != current.nativeTokens;
  }

  /// 构建可用代币列表
  List<Token> _buildAvailableTokens(SwapState state) {
    return state.availableTokens.map((e) => e.toToken()).toList();
  }

  /// 构建来源代币配置
  TokenCardConfig _buildFromTokenConfig(SwapState state) {
    final inAmount =
        ((double.tryParse(state.amount) ?? 0) *
                (state.fromToken?.tokenPrice ?? 0))
            .toString();

    return state.fromToken.toTokenCardConfig(
      dollarValue: state.quote?.inUsdValue?.toString() ?? inAmount,
    );
  }

  /// 构建目标代币配置
  TokenCardConfig _buildToTokenConfig(SwapState state) {
    final outAmount = state.quote?.outAmount.toString().divideByDecimalPower(
      state.toToken?.decimals ?? 18,
    );

    return state.toToken.toTokenCardConfig(
      amount: outAmount,
      dollarValue: state.quote?.outUsdValue?.toString() ?? '',
    );
  }
}
