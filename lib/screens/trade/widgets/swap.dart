import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/cubits/trade_setting/trade_setting_state.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/trade/widgets/token_swap_card.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/utils/numeric_utils.dart';
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

class TradeSwap extends StatefulWidget {
  const TradeSwap({super.key});

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
    context.read<SearchTokenCubit>().clear();

    ///  选择来源代币
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
        tokenPrice: double.tryParse(token.tokenPrice) ?? 0);
    return tradeToken;
  }

  ToastController? _toastController;

  void _showTraingToast() {
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
      ],
    );
  }

  Widget _buildBalanceRow(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(builder: (context, state) {
// final balance = state.wallets.first.addresses

      final balanceStr =
          "余额: ${CurrencyFormatter.formatWithFourDecimals(double.tryParse(state.fromToken?.balance ?? "0") ?? 0)} ${state.fromToken?.symbol ?? ""}";
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
                context.push(Routes.receiveAddress, extra: {
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
            Text(balanceStr,
                style: TextStyle(
                    fontSize: 16.sp, color: AppColors.textSecondary(context))),
            SizedBox(
              width: 6.w,
            ),
            GestureDetector(
                onTap: () {
                  context.read<TradeCubit>().updateAmountToMax();
                },
                child: Text(
                  "最大",
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
          final outAmount = NumericUtils.convertFromAtomicUnits(
              state.quote?.outAmount ?? "", state.toToken?.decimals ?? 18);

          final inAmount = ((double.tryParse(state.amount) ?? 0) *
                  (state.fromToken?.tokenPrice ?? 0))
              .toString();

          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Source Token Swap Card
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
                        tokenName: state.fromToken?.tokenName ?? "",
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
                        chainId: state.toChainId,
                        chainLogo: state.toToken?.chainLogo ?? "",
                        tokenAvatar: state.toToken?.tokenAvatar ?? "",
                        tokenName: state.toToken?.tokenName ?? "",
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
          .checkAmount(state.amount, state.fromToken?.balance ?? "0");

      final buttonText = isValidBalance
          ? S.of(context).tradeNow
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
          : AppColors.black;

      final iconColor = isTradeLoading ||
              !isValid ||
              !state.amount.isNotEmptyAndZeroValue ||
              !isValidBalance
          ? AppColors.textTertiary(context)
          : AppColors.black;

      final icon = state.quoteStatus.maybeMap(
          orElse: () => SvgPicture.asset(
                'assets/images/icons/aim-outline.svg',
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
          loading: (_) => null);

      final content = state.quoteStatus.maybeMap(
          orElse: () => Text(buttonText,
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
        onPressed: () async {
          if (isValid && isValidBalance && !isLoading) {
            await context.read<TradeCubit>().swap(
                  context,
                  showToast: _showTraingToast,
                  closeToast: _closeToast,
                );
          }
          return;
        },
        borderRadius: BorderRadius.zero,
        // isLoading: isLoading,
        width: double.infinity,
        height: 50.h,
        cutSize: 20.0,
        backgroundColor: backgroundColor,
        textColor: AppColors.black,
        fontSize: 16.sp,
        icon: icon,
        label: content,
      );
    });
  }

  Widget _buildTradeDefailsRow(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(builder: (context, state) {
      final gasFee = formatPrice(state.quote?.gasFee ?? 0);
      // final tradeSetting = context.read<TradeSettingCubit>().state;

      return BlocBuilder<TradeSettingCubit, TradeSettingState>(
          builder: (context, tradeSetting) {
        final setting = tradeSetting.customSettings[state.fromChainId];

        return GestureDetector(
          onTap: () {
            context.push(Routes.tradeSetting);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SettingModeIcon(),
              const SizedBox(
                width: 4,
              ),
              const SettingModeText(),
              Icon(
                Icons.keyboard_arrow_right,
                size: 16.w,
                color: AppColors.textSecondary(context),
              ),
              const Spacer(),
              Row(
                spacing: 4.w,
                children: [
                  SvgPicture.asset(
                    "assets/images/icons/slippage.svg",
                    width: 13.w,
                    height: 13.w,
                  ),
                  Text("${setting?.slippage ?? 0}%",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textPrimary(context))),
                ],
              ),
              const SizedBox(width: 10),
              Row(
                spacing: 4.w,
                children: [
                  SvgPicture.asset(
                    "assets/images/icons/gas-fee.svg",
                    width: 12.w,
                    height: 12.w,
                  ),
                  Text("\$$gasFee",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textPrimary(context))),
                ],
              ),
              const SizedBox(width: 10),
              Row(
                spacing: 4.w,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/icons/shield.svg",
                    width: 10.w,
                    height: 12.w,
                  ),
                  Text(
                      setting?.mevProtect ?? false
                          ? S.of(context).open
                          : S.of(context).close,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary(context))),
                ],
              )
            ],
          ),
        );
      });
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
  const SwapTokenDivider({super.key});

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
              // icon: Icon(
              //   // Icons.swap_vert,
              //   color: AppColors.textPrimary(context),
              //   size: 24,
              // ),
              icon: SvgPicture.asset(
                'assets/images/icons/swap-outline.svg',
                height: 16.w,
                width: 16.w,
                colorFilter:
                    const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
