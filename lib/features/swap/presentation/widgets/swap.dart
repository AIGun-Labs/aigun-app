import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../cubits/query_token/query_token.dart';
import '../../../../cubits/sound_effect/sound_effect_cubit.dart';
import '../../../../cubits/trade_setting/trade_setting_cubit.dart';
import '../../../../cubits/trade_setting/trade_setting_state.dart';
import '../../../../enums/trade_mode.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/domain/entities/token_entity.dart';
import '../../../../shared/utils/token_purchase.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/extensions/string.dart';
import '../../../../utils/format/currency.dart';
import '../../../../utils/sheet/token_selector_sheet.dart';
import '../../../../widgets/setting/trade_row.dart';
import '../../../../widgets/token/models/token.dart';
import '../../domain/entities/transaction_entity.dart';
import '../cubit/swap/swap_cubit.dart';
import '../cubit/swap/swap_state.dart';
import 'swap_button/index.dart';
import 'token_card/index.dart';

/// Swap Widget - 主交换界面
///
/// 使用新的 SwapCubit 协调器架构
class SwapWidget extends StatefulWidget {
  const SwapWidget({super.key, this.buyToken = false});

  final bool buyToken;

  @override
  State<SwapWidget> createState() => _SwapWidgetState();
}

class _SwapWidgetState extends State<SwapWidget> {
  // 缓存 cubit 引用，用于 dispose 时访问
  SwapCubit? _swapCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 在 didChangeDependencies 中安全地获取 cubit 引用
    _swapCubit ??= context.read<SwapCubit>();
  }

  @override
  void dispose() {
    // 使用缓存的引用暂停定时器，防止内存泄漏
    _swapCubit?.pauseTimers();
    super.dispose();
  }

  /// 选择来源代币
  Future<void> _handleSelectSourceToken(List<Token> availableTokens) async {
    context.read<QueryTokenCubit>().reset();

    // 选择来源代币
    final selectedToken = await showTokenSelectorSheet(
      context,
      TokenPurchaseService.filterTokensWithBalance(availableTokens),
      title: S.of(context).selectSellToken,
      isSearch: true,
      isShowRight: true,
    );

    if (selectedToken != null && mounted) {
      final swapCubit = context.read<SwapCubit>();
      final transactionEntity = _tokenToTransactionEntity(selectedToken);
      swapCubit.clear();
      swapCubit.updateFromToken(transactionEntity);
    }
  }

  /// 选择目标代币
  Future<void> _handleSelectTargetToken(List<Token> availableTokens) async {
    final swapCubit = context.read<SwapCubit>();

    final selectedToken = await showTokenSelectorSheet(
      context,
      availableTokens,
      title: S.of(context).selectReceiveToken,
      isSearch: true,
      isShowRight: true,
    );

    if (selectedToken != null && mounted) {
      final transactionEntity = _tokenToTransactionEntity(selectedToken);
      swapCubit.updateToToken(transactionEntity);
    }

    if (!mounted) return;
    context.read<QueryTokenCubit>().reset();
    await swapCubit.getNativeTokens();
  }

  /// 将 Token 转换为 TransactionEntity
  TransactionEntity _tokenToTransactionEntity(Token token) {
    return TransactionEntity(
      isNative: token.isNativeToken,
      chainId: token.chainId,
      chainLogo: token.chainLogo,
      tokenAvatar: token.tokenAvatar,
      tokenName: token.tokenName,
      address: token.address,
      decimals: token.decimals,
      symbol: token.symbol,
      chainName: token.chainName,
      network: token.network,
      tokenPrice: double.tryParse(token.tokenPrice) ?? 0,
      balance: token.balance,
    );
  }

  /// 将 TransactionEntity 转换为 TokenCardConfig
  TokenCardConfig _entityToTokenCardConfig(
    TransactionEntity? entity, {
    String? amount,
    String? dollarValue,
  }) {
    if (entity == null) {
      return TokenCardConfig(
        symbol: '',
        tokenName: '',
        tokenAvatar: '',
        chainLogo: '',
        chainName: '',
        dollarValue: dollarValue ?? '',
        amount: amount,
        decimals: 18,
        isNative: false,
      );
    }
    return TokenCardConfig(
      symbol: entity.symbol,
      tokenName: entity.symbol,
      tokenAvatar: entity.tokenAvatar,
      chainLogo: entity.chainLogo,
      chainName: entity.chainName,
      dollarValue: dollarValue ?? '',
      amount: amount,
      decimals: entity.decimals,
      isNative: entity.isNative,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwapCubit, SwapState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              _buildBalanceRow(context),
              const SizedBox(height: 4),
              _buildTradeSwap(context),
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: _buildTradeButton(context, state),
              ),
              const SizedBox(height: 16),
              SettingTradeRow(
                gasFee: state.quote?.gasFee ?? '0',
                padding: EdgeInsets.symmetric(horizontal: 25.w),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBalanceRow(BuildContext context) {
    return BlocBuilder<SwapCubit, SwapState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  context.read<SwapCubit>().toReceivePage(
                    context,
                    state.fromToken,
                  );
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
                  context.read<SwapCubit>().toReceivePage(
                    context,
                    state.fromToken,
                  );
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
                      state.fromToken?.symbol ?? '',
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
                  context.read<SwapCubit>().updateAmountToMax();
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
    return BlocBuilder<SwapCubit, SwapState>(
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

        // 转换为 Token 列表用于选择器
        final availableTokens = state.availableTokens
            .map(_tokenEntityToToken)
            .toList();

        // 构建 TokenCard 配置
        final fromTokenConfig = _entityToTokenCardConfig(
          state.fromToken,
          dollarValue: state.quote?.inUsdValue?.toString() ?? inAmount,
        );

        final toTokenConfig = _entityToTokenCardConfig(
          state.toToken,
          amount: outAmount,
          dollarValue: state.quote?.outUsdValue?.toString() ?? '',
        );

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
                    onSelectToken: () =>
                        _handleSelectSourceToken(availableTokens),
                    onAmountChanged: (amount) {
                      context.read<SwapCubit>().updateAmount(amount);
                    },
                  ),
                ),
                const SwapTokenDivider(),
                // 目标代币卡片
                TokenCard(
                  config: toTokenConfig,
                  interaction: TokenCardInteraction(
                    isEditable: false,
                    isSourceToken: false,
                    onSelectToken: () =>
                        _handleSelectTargetToken(availableTokens),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// 构建交易按钮
  Widget _buildTradeButton(BuildContext context, SwapState state) {
    // 构建状态
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
      hasEnoughFee: context.read<SwapCubit>().isEnoughFee(),
      hasInputAmount: state.amount.isNotEmptyAndZeroValue,
      fromTokenSymbol: state.fromToken?.symbol,
    );

    // 构建配置
    final defaultText = widget.buyToken
        ? S.of(context).buyNow
        : S.of(context).tradeNow;

    final config = TradeButtonConfigExtension.fromStateBuilder(
      stateBuilder: stateBuilder,
      defaultText: defaultText,
      balanceNotEnoughText: S.of(context).balanceNotEnough,
      feeNotEnoughText: S.of(context).feeNotEnough,
      isBuyMode: widget.buyToken,
      onPressed: () async {
        context.read<SoundEffectCubit>().playGunLoad();
        await context.read<SwapCubit>().swap(context);
      },
    );

    return TradeButton(config: config);
  }

  /// 检查余额是否足够
  bool _checkBalance(String amount, String balance) {
    final amountValue = double.tryParse(amount) ?? 0;
    final balanceValue = double.tryParse(balance) ?? 0;
    return amountValue <= balanceValue;
  }

  /// 将 TokenEntity 转换为 Token (用于选择器)
  Token _tokenEntityToToken(TokenEntity entity) {
    return Token(
      isNative: entity.isNative,
      chainId: entity.chainId,
      chainLogo: entity.chainLogo,
      chainName: entity.chainName,
      tokenAvatar: entity.tokenLogo,
      tokenName: entity.tokenName,
      address: entity.address,
      tokenPrice: entity.tokenPrice,
      rawBalance: entity.rawBalance,
      balance: entity.balance,
      decimals: entity.decimals,
      symbol: entity.symbol,
      network: entity.network,
      priceChange24h: double.tryParse(entity.priceChange24h),
      marketCap: double.tryParse(entity.marketCap),
    );
  }
}

class SettingModeIcon extends StatelessWidget {
  const SettingModeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeSettingCubit, TradeSettingState>(
      buildWhen: (previous, current) => previous.mode != current.mode,
      builder: (context, state) {
        final path = state.mode == TradeMode.fast
            ? 'assets/images/icons/lightning-outline.svg'
            : state.mode == TradeMode.normal
            ? 'assets/images/icons/coffee-outline.svg'
            : 'assets/images/icons/tool-outline.svg';

        return SvgPicture.asset(
          width: 13.w,
          height: 13.w,
          colorFilter: ColorFilter.mode(
            AppColors.textSecondary(context),
            BlendMode.srcIn,
          ),
          path,
        );
      },
    );
  }
}

class SettingModeText extends StatelessWidget {
  const SettingModeText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeSettingCubit, TradeSettingState>(
      builder: (context, state) {
        final mode = state.mode == TradeMode.fast
            ? S.of(context).fastMode
            : TradeMode.normal == state.mode
            ? S.of(context).normalMode
            : S.of(context).customMode;
        return Text(
          mode,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary(context),
          ),
        );
      },
    );
  }
}

class SwapTokenDivider extends StatelessWidget {
  const SwapTokenDivider({super.key, this.inAmount});
  final String? inAmount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: Divider(height: 1, color: AppColors.border(context)),
        ),
        Center(
          child: Container(
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: AppColors.card(context),
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  AppColors.buttonGradientStart,
                  AppColors.buttonGradientEnd,
                ],
              ),
            ),
            child: IconButton(
              onPressed: () {
                context.read<SwapCubit>().swapToken();
              },
              icon: SvgPicture.asset(
                'assets/images/icons/swap-outline.svg',
                height: 16.w,
                width: 16.w,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
