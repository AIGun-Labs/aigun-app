import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/token_handler.dart';
import '../../../../cubits/query_token/query_token_cubit.dart';
import '../../../../cubits/sound_effect/sound_effect_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/utils/token_purchase.dart';
import '../../../../utils/extensions/string.dart';
import '../../../../utils/sheet/token_selector_sheet.dart';
import '../../../../widgets/setting/trade_row.dart';
import '../../../../widgets/token/models/token.dart';
import '../../../chain/presentation/cubit/supported_chains_cubit.dart';
import '../cubit/swap/swap_cubit.dart';
import '../cubit/swap/swap_state.dart' hide TradeButtonConfig;
import 'balance_row.dart';
import 'swap_button/index.dart';
import 'swap_converters.dart';
import 'swap_token_pair.dart';

// 导出供外部使用
export 'setting_mode_widgets.dart';
export 'swap_divider.dart';

/// Swap Widget - 主交换界面
///
/// 使用新的 SwapCubit 协调器架构
/// 遵循单一职责原则，将子组件拆分到独立文件
class SwapWidget extends StatefulWidget {
  const SwapWidget({super.key, this.buyToken = false});

  final bool buyToken;

  @override
  State<SwapWidget> createState() => _SwapWidgetState();
}

class _SwapWidgetState extends State<SwapWidget> {
  late final SwapCubit _swapCubit;
  late final SupportedChainsCubit _supportedChainsCubit;
  late final List<String> _supportedChains;
  late final QueryTokenCubit _queryTokenCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _swapCubit = context.read<SwapCubit>();
    _supportedChainsCubit = context.read<SupportedChainsCubit>();
    _supportedChains = _supportedChainsCubit.state.networkIds;
    _queryTokenCubit = context.read<QueryTokenCubit>();
  }

  @override
  void dispose() {
    _swapCubit.pauseTimers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          BalanceRow(),
          4.verticalSpace,
          SwapTokenPair(
            onSelectSourceToken: _handleSelectSourceToken,
            onSelectTargetToken: _handleSelectTargetToken,
          ),
          24.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: _TradeButtonSection(
              swapCubit: _swapCubit,
              isBuyMode: widget.buyToken,
            ),
          ),
          16.verticalSpace,
          BlocSelector<SwapCubit, SwapState, String>(
            selector: (state) => state.quote?.gasFee ?? '0',
            builder: (context, gasFee) {
              return SettingTradeRow(
                gasFee: gasFee,
                padding: EdgeInsets.symmetric(horizontal: 25.w),
              );
            },
          ),
          // const SizedBox(height: 16),
          16.verticalSpace,
        ],
      ),
    );
  }

  /// 选择来源代币
  Future<void> _handleSelectSourceToken(List<Token> tokens) async {
    _queryTokenCubit.reset();

    final filteredTokens = TokenPurchaseService.filterTokensWithBalance(
      TokenHandler.excludeUnsupportedToken(tokens, _supportedChains),
    );

    final selectedToken = await showTokenSelectorSheet(
      context,
      filteredTokens,
      title: S.of(context).selectSellToken,
      isSearch: true,
      isShowRight: true,
    );

    if (selectedToken != null && mounted) {
      _swapCubit.clear();
      _swapCubit.updateFromToken(selectedToken.toTransactionEntity());
    }
  }

  /// 选择目标代币
  Future<void> _handleSelectTargetToken(List<Token> tokens) async {
    final filteredTokens = TokenPurchaseService.filterTokensWithBalance(
      TokenHandler.excludeUnsupportedToken(tokens, _supportedChains),
    );

    final selectedToken = await showTokenSelectorSheet(
      context,
      filteredTokens,
      title: S.of(context).selectReceiveToken,
      isSearch: true,
      isShowRight: true,
    );

    if (selectedToken != null && mounted) {
      _swapCubit.updateToToken(selectedToken.toTransactionEntity());
    }

    if (!mounted) return;
    _queryTokenCubit.reset();
    await _swapCubit.getNativeTokens();
  }
}

/// 交易按钮区域
///
/// 独立的 StatelessWidget，使用 BlocBuilder 监听状态变化
class _TradeButtonSection extends StatelessWidget {
  const _TradeButtonSection({required this.swapCubit, required this.isBuyMode});

  final SwapCubit swapCubit;
  final bool isBuyMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwapCubit, SwapState>(
      builder: (context, state) {
        final config = _buildButtonConfig(context, state);
        return TradeButton(config: config);
      },
    );
  }

  TradeButtonConfig _buildButtonConfig(BuildContext context, SwapState state) {
    final stateBuilder = TradeButtonStateBuilder(
      hasValidParams: state.paramsStatus.maybeMap(
        failure: (_) => false,
        orElse: () => true,
      ),
      hasValidQuote: state.quoteStatus.maybeMap(
        success: (_) => state.quote != null,
        orElse: () => false,
      ),
      isQuoteLoading: state.quoteStatus.maybeMap(
        loading: (_) => true,
        orElse: () => false,
      ),
      isTrading: state.swapStatus.maybeMap(
        trading: (_) => true,
        orElse: () => false,
      ),
      hasEnoughBalance:
          !state.amount.isNotEmptyAndZeroValue ||
          _checkBalance(state.amount, state.fromBalance?.toString() ?? '0'),
      hasEnoughFee: swapCubit.isEnoughFee(),
      hasInputAmount: state.amount.isNotEmptyAndZeroValue,
      fromTokenSymbol: state.fromToken?.symbol,
    );

    final defaultText = isBuyMode
        ? S.of(context).buyNow
        : S.of(context).tradeNow;

    return TradeButtonConfigExtension.fromStateBuilder(
      stateBuilder: stateBuilder,
      defaultText: defaultText,
      balanceNotEnoughText: S.of(context).balanceNotEnough,
      feeNotEnoughText: S.of(context).feeNotEnough,
      isBuyMode: isBuyMode,
      onPressed: () async {
        context.read<SoundEffectCubit>().playGunLoad();
        await swapCubit.swap(context);
      },
    );
  }

  bool _checkBalance(String amount, String balance) {
    final amountValue = double.tryParse(amount) ?? 0;
    final balanceValue = double.tryParse(balance) ?? 0;
    return amountValue <= balanceValue;
  }
}
