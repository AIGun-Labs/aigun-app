import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/sound_effect/sound_effect_cubit.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/cubits/trade_setting/trade_setting_state.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/widgets/swap/widgets/token_swap_card.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/sheet/token_selector_sheet.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_aigun/widgets/lotties/index.dart';
import 'package:flutter_aigun/widgets/setting/trade_row.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/constants.dart';

class TradeSwap extends StatefulWidget {
  const TradeSwap({super.key, this.buyToken = false});

  final bool buyToken;

  @override
  State<TradeSwap> createState() => _TradeSwapState();
}

class _TradeSwapState extends State<TradeSwap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 选择来源代币
  Future<void> _handleSelectSourceToken(List<Token> availableTokens) async {
    context.read<QueryTokenCubit>().reset();

    //  选择来源代币
    final selectedToken = await showTokenSelectorSheet(context, availableTokens,
        title: S.of(context).selectSellToken,
        isSearch: true,
        isShowRight: true);

    if (selectedToken != null && mounted) {
      final tradeCubit = context.read<TradeCubit>();
      tradeCubit.updateFromToken(_mapToToken(selectedToken));
      tradeCubit.clear();
    }
  }

  /// 选择目标代币
  Future<void> _handleSelectTargetToken(List<Token> targetTokens) async {
    final tradeCubit = context.read<TradeCubit>();

    final selectedToken = await showTokenSelectorSheet(context, targetTokens,
        title: S.of(context).selectReceiveToken,
        isSearch: true,
        isShowRight: true);

    if (selectedToken != null && mounted) {
      tradeCubit.updateToToken(_mapToToken(selectedToken));
    }

    if (!mounted) return;
    context.read<QueryTokenCubit>().reset();
    await tradeCubit.getNativeTokens();
  }

  TradeToken _mapToToken(Token token) {
    final tradeToken = TradeToken(
        chainId: token.chainId,
        chainLogo: token.chainLogo,
        tokenAvatar: token.tokenAvatar,
        tokenName: token.tokenName,
        decimals: token.decimals,
        address: token.address,
        balance: token.balance,
        chainName: token.chainName,
        symbol: token.symbol,
        network: token.network,
        tokenPrice: double.tryParse(token.tokenPrice) ?? 0);
    return tradeToken;
  }

  ToastController? _toastController;

  Future<void> _showTraingToast() async {
    _toastController = TradeStatusToastUtils.showTrainingToast(context);
  }

  void _closeToast() {
    _toastController?.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildBalanceRow(context),
        const SizedBox(height: 4),
        _buildTradeSwap(context),
        const SizedBox(height: 24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: _buildTradeButton(context),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: const SettingTradeRow(),
        ),
        const SizedBox(height: 16),
        // const CustomTooltip(content: Text("123"), child: TokenItem())
      ],
    );
  }

  Widget _buildBalanceRow(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(builder: (context, state) {
      return Padding(
        padding: EdgeInsets.only(
          left: 25.w,
          right: 25.w,
          top: 15.w,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                context.pushNamed(RouteNames.receiveAddress, extra: {
                  "chainName": state.fromToken?.chainName ?? "",
                  "chainId": state.fromChainId,
                  "address": state.fromToken?.address ?? "",
                });
              },
              child: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 10.w,
                  child: Icon(
                    Icons.add,
                    color: AppColors.background(context),
                    size: 16.w,
                  )),
            ),
            SizedBox(
              width: 4.w,
            ),
            Row(
              children: [
                Text(
                  "${S.of(context).balance}: ",
                  style: TextStyle(
                      fontSize: 16.sp, color: AppColors.textSecondary(context)),
                ),
                Text(
                    CurrencyFormatter.abbreviateTokenPrice(
                      state.fromBalance ?? 0,
                    ),
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textSecondary(context))),
                SizedBox(width: 4.w),
                Text(state.fromToken?.symbol.toString() ?? "",
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textSecondary(context))),
              ],
            ),
            SizedBox(
              width: 6.w,
            ),
            GestureDetector(
                onTap: () {
                  context.read<TradeCubit>().updateAmountToMax();
                },
                child: Text(
                  S.of(context).max,
                  style: TextStyle(
                      fontSize: 16.sp, color: AppColors.textPrimary(context)),
                )),
            SizedBox(
              width: 4.w,
            ),
          ],
        ),
      );
    });
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

          final inAmount = ((double.tryParse(state.amount) ?? 0) *
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
                        state.availableTokens), // 需要卖出的代币

                    dollarValue:
                        state.quote?.inUsdValue?.toString() ?? inAmount,
                    isEditable: true,
                    onAmountChanged: (amount) {
                      context.read<TradeCubit>().updateAmount(amount);
                    },
                    token: TradeToken(
                        chainName: state.fromToken?.chainName ?? "",
                        chainId: state.fromChainId,
                        chainLogo: state.fromToken?.chainLogo ?? "",
                        tokenAvatar: state.fromToken?.tokenAvatar ?? "",
                        tokenName: state.fromToken?.symbol ?? "",
                        decimals: state.fromToken?.decimals ?? 18,
                        address: state.fromToken?.address ?? "",
                        balance: state.fromToken?.balance ?? "",
                        symbol: state.fromToken?.symbol ?? "",
                        tokenPrice: state.fromToken?.tokenPrice ?? 0),
                    isSourceToken: true,
                  ),
                  // const SizedBox(height: 10), // 为中间图标留出空间
                  const SwapTokenDivider(),
                  // Target Token
                  TokenSwapCard(
                    onSelectToken: () =>
                        _handleSelectTargetToken(state.nativeTokens), // 需要买进的代币
                    amount: outAmount,

                    dollarValue: state.quote?.outUsdValue?.toString() ?? "",
                    isEditable: false,
                    token: TradeToken(
                        chainName: state.toToken?.chainName ?? "",
                        chainId: state.toToken?.chainId ?? 0,
                        chainLogo: state.toToken?.chainLogo ?? "",
                        tokenAvatar: state.toToken?.tokenAvatar ?? "",
                        tokenName: state.toToken?.symbol ?? "",
                        decimals: state.toToken?.decimals ?? 18,
                        address: state.toToken?.address ?? "",
                        balance: state.toToken?.balance ?? "",
                        symbol: state.toToken?.symbol ?? "",
                        tokenPrice: state.toToken?.tokenPrice ?? 0),
                    isSourceToken: false,
                  ),
                ],
              ),
            ],
          );
        });
  }

  Widget _buildTradeButton(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(builder: (context, state) {
      final isLoading =
          state.status.maybeWhen(loading: () => true, orElse: () => false);
      final isValid = state.paramsStatus.mapOrNull(
              failure: (_) => false,
              success: (_) => true,
              loading: (_) => true,
              initial: (_) => true) ??
          false;

      final isQuoteLoading =
          state.quoteStatus.maybeMap(orElse: () => false, loading: (_) => true);

      final isTradeLoading =
          state.status.maybeMap(orElse: () => false, loading: (_) => true);

// 余额不足情况
      final isValidBalance = context
          .read<TradeCubit>()
          .checkAmount(state.amount, state.fromBalance.toString());

      final buttonText =
          widget.buyToken ? S.of(context).buyNow : S.of(context).tradeNow;

      final buttonTextContent = isValidBalance
          ? buttonText
          : "${state.fromToken?.symbol} ${S.of(context).balanceNotEnough}";

      final backgroundColor = isQuoteLoading ||
              isTradeLoading ||
              (!isValid ||
                  !state.amount.isNotEmptyAndZeroValue ||
                  !isValidBalance)
          ? AppColors.quinary
          : AppColors.buttonPrimary(context);

      final labelColor = isQuoteLoading ||
              isTradeLoading ||
              (!isValid ||
                  !state.amount.isNotEmptyAndZeroValue ||
                  !isValidBalance)
          ? AppColors.textTertiary(context)
          : Colors.black;

      final iconColor = isTradeLoading ||
              !isValid ||
              !state.amount.isNotEmptyAndZeroValue ||
              !isValidBalance
          ? AppColors.textTertiary(context)
          : Colors.black;

      final icon = state.quoteStatus.maybeMap(
          orElse: () => SvgPicture.asset(
                'assets/images/icons/aim-outline.svg',
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
          loading: (_) => null);

      final content = state.quoteStatus.maybeMap(
          orElse: () => Text(buttonTextContent,
              style: TextStyle(fontWeight: FontWeight.bold, color: labelColor)),
          loading: (_) => LottieAsset(
                'assets/lottie/aim.lottie',
                config: LottieConfig(
                  width: 24.w,
                  height: 24.h,
                  repeat: true,
                  animate: true,
                ),
              ));

      return PrimaryButton(
        disabledBackgroundColor: backgroundColor,
        onPressed: isValid && isValidBalance && !isLoading
            ? () async {
                context.read<SoundEffectCubit>().playGunLoad();
                await context.read<TradeCubit>().swap(
                      context,
                      showToast: _showTraingToast,
                      closeToast: _closeToast,
                    );
              }
            : null,

        borderRadius:
            widget.buyToken ? BorderRadius.circular(50) : BorderRadius.zero,
        // isLoading: isLoading,
        width: double.infinity,
        height: 50.h,
        cutSize: widget.buyToken ? 0 : 20.0,
        backgroundColor: backgroundColor,
        textColor: Colors.black,
        fontSize: 16.sp,
        icon: icon,
        label: content,
      );
    });
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
              ? "assets/images/icons/lightning-outline.svg"
              : state.mode == TradeMode.normal
                  ? "assets/images/icons/coffee-outline.svg"
                  : "assets/images/icons/tool-outline.svg";

          return SvgPicture.asset(
            width: 13.w,
            height: 13.w,
            colorFilter: ColorFilter.mode(
                AppColors.textSecondary(context), BlendMode.srcIn),
            path,
          );
        });
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
      return Text(mode,
          style: TextStyle(
              fontSize: 14.sp, color: AppColors.textSecondary(context)));
    });
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
            child: Divider(
              height: 1,
              color: AppColors.border(context),
            )),
        Center(
          child: Container(
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: AppColors.card(context),
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [
                AppColors.buttonGradientStart,
                AppColors.buttonGradientEnd
              ]),
            ),
            child: IconButton(
              onPressed: () {
                context.read<TradeCubit>().swapToken();
              },
              icon: SvgPicture.asset(
                'assets/images/icons/swap-outline.svg',
                height: 16.w,
                width: 16.w,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
