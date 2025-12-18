import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/service_locator.dart';
import '../../../cubits/index.dart';
import '../../../cubits/trade/trade_state.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/utils/token_purchase.dart';
import '../../../themes/themes.dart';
import '../../../utils/extensions/string.dart';
import '../../../utils/format/currency.dart';
import '../../../utils/sheet/token_selector_sheet.dart';
import '../../setting/trade_row.dart';
import '../../token/models/token.dart';
import 'swap_button.dart';
import 'swap_divider.dart';
import 'token_swap_card.dart';

class TradeSwap extends StatefulWidget {
  const TradeSwap({super.key, this.buyToken = false});

  final bool buyToken;

  @override
  State<TradeSwap> createState() => _TradeSwapState();
}

class _TradeSwapState extends State<TradeSwap> {
  // 缓存 cubit 引用，用于 dispose 时访问
  TradeCubit? _tradeCubit;

  @override
  void initState() {
    super.initState();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 在 didChangeDependencies 中安全地获取 cubit 引用
    _tradeCubit ??= context.read<TradeCubit>();
  }

  @override
  void dispose() {
    // 使用缓存的引用暂停定时器，防止内存泄漏
    _tradeCubit?.pauseTimers();
    super.dispose();
  }

  /// 选择来源代币
  Future<void> _handleSelectSourceToken(List<Token> availableTokens) async {
    context.read<QueryTokenCubit>().reset();

    //  选择来源代币
    final selectedToken = await showTokenSelectorSheet(
      context,
      TokenPurchaseService.filterTokensWithBalance(availableTokens),
      title: S.of(context).selectSellToken,
      isSearch: true,
      isShowRight: true,
    );

    if (selectedToken != null && mounted) {
      final tradeCubit = context.read<TradeCubit>();
      final tradeToken = TradeToken.fromToken(selectedToken);
      tradeCubit.clear();
      tradeCubit.updateFromToken(tradeToken);
    }
  }

  /// 选择目标代币
  Future<void> _handleSelectTargetToken(List<Token> targetTokens) async {
    final tradeCubit = context.read<TradeCubit>();

    final selectedToken = await showTokenSelectorSheet(
      context,
      targetTokens,
      title: S.of(context).selectReceiveToken,
      isSearch: true,
      isShowRight: true,
    );

    if (selectedToken != null && mounted) {
      final tradeToken = TradeToken.fromToken(selectedToken);
      tradeCubit.updateToToken(tradeToken);
    }

    if (!mounted) return;
    context.read<QueryTokenCubit>().reset();
    await tradeCubit.getNativeTokens();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              _buildBalanceRow(context),
              4.verticalSpace,
              _buildTradeSwap(context),
              24.verticalSpace,
              SwapButton(
                isBuyToken: widget.buyToken,
                padding: EdgeInsets.symmetric(horizontal: 25.w),
              ),
              16.verticalSpace,
              SettingTradeRow(
                gasFee: state.quote?.gasFee ?? '0',
                padding: EdgeInsets.symmetric(horizontal: 25.w),
              ),
              // 16.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  Widget _buildBalanceRow(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  getIt<TradeCubit>().toReceivePage(context, state.fromToken);
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 10.w,
                  child: Icon(
                    Icons.add,
                    color: AppColors.background(context),
                    size: 16.w,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  getIt<TradeCubit>().toReceivePage(context, state.fromToken);
                },
                child: Row(
                  children: [
                    Text(
                      '${S.of(context).balance}: ',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    Text(
                      CurrencyFormatter.abbreviateTokenPrice(
                        state.fromBalance ?? 0,
                        fixedDecimals: 4,
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      state.fromToken?.symbol.toString() ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 6.w),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  context.read<TradeCubit>().updateAmountToMax();
                },
                child: Text(
                  S.of(context).max,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textPrimary(context),
                  ),
                ),
              ),
              SizedBox(width: 4.w),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTradeSwap(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(
      buildWhen: (previous, current) =>
          previous.quote != current.quote ||
          previous.fromToken != current.fromToken ||
          previous.toToken != current.toToken ||
          previous.availableTokens != current.availableTokens ||
          previous.nativeTokens != current.nativeTokens,
      builder: (context, state) {
        final outAmount = state.quote?.outAmount
            .toString()
            .divideByDecimalPower(state.toToken?.decimals ?? 18);

        final inAmount =
            ((double.tryParse(state.amount) ?? 0) *
                    (state.fromToken?.tokenPrice ?? 0))
                .toString();

        return Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TokenSwapCard(
                  onSelectToken: () => _handleSelectSourceToken(
                    state.availableTokens,
                  ), // 需要卖出的代币

                  dollarValue: state.quote?.inUsdValue?.toString() ?? inAmount,
                  isEditable: true,
                  onAmountChanged: (amount) {
                    context.read<TradeCubit>().updateAmount(amount);
                  },
                  token: TradeToken(
                    isNative: state.fromToken?.isNative ?? false,
                    chainName: state.fromToken?.chainName ?? '',
                    chainId: state.fromToken?.chainId ?? '',
                    chainLogo: state.fromToken?.chainLogo ?? '',
                    tokenAvatar: state.fromToken?.tokenAvatar ?? '',
                    tokenName: state.fromToken?.symbol ?? '',
                    decimals: state.fromToken?.decimals ?? 18,
                    address: state.fromToken?.address ?? '',
                    balance: state.fromToken?.balance ?? '',
                    symbol: state.fromToken?.symbol ?? '',
                    tokenPrice: state.fromToken?.tokenPrice ?? 0,
                  ),
                  isSourceToken: true,
                ),
                const SwapTokenDivider(),
                TokenSwapCard(
                  onSelectToken: () => _handleSelectTargetToken(
                    state.availableTokens,
                  ), // 需要买进的代币
                  amount: outAmount,

                  dollarValue: state.quote?.outUsdValue?.toString() ?? '',
                  isEditable: false,
                  token: TradeToken(
                    isNative: state.toToken?.isNative ?? false,
                    chainName: state.toToken?.chainName ?? '',
                    chainId: state.toToken?.chainId ?? '',
                    chainLogo: state.toToken?.chainLogo ?? '',
                    tokenAvatar: state.toToken?.tokenAvatar ?? '',
                    tokenName: state.toToken?.symbol ?? '',
                    decimals: state.toToken?.decimals ?? 18,
                    address: state.toToken?.address ?? '',
                    balance: state.toToken?.balance ?? '',
                    symbol: state.toToken?.symbol ?? '',
                    tokenPrice: state.toToken?.tokenPrice ?? 0,
                  ),
                  isSourceToken: false,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
