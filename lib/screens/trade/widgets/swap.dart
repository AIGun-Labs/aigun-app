import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/cubits/trade_setting/trade_setting_state.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/trade/widgets/token_swap_card.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/utils/numeric_utils.dart';
import 'package:flutter_aigun/utils/sheet/token_selector_sheet.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_aigun/widgets/loading_indicator/index.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TradeSwap extends StatefulWidget {
  const TradeSwap({super.key});

  @override
  _TradeSwapState createState() => _TradeSwapState();
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

    if (selectedToken != null) {
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
        isShowRight: false);

    if (selectedToken != null) {
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
        symbol: token.symbol);
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
    final tradeState = context.read<TradeCubit>().state;
    return BlocSelector<TradeCubit, TradeState, TradeStatusMessage>(
        selector: (state) => state.status,
        builder: (context, state) {
          state.whenOrNull(
              failure: (failure) {},
              success: (success) {
                showTransferSuccessToast(context, tradeState.amount ?? "",
                    tradeState.fromToken?.symbol ?? "", success.txHash ?? "");
              });
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
                child: _buildTradeDefailsRow(context),
              ),
              const SizedBox(height: 16),
            ],
          );
        });
  }

  Widget _buildBalanceRow(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(builder: (context, state) {
// final balance = state.wallets.first.addresses

      final balanceStr =
          "余额: ${formatPrice(state.fromToken?.balance)} ${state.fromToken?.symbol ?? ""}";

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
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
            TextButton(
                onPressed: () {
                  context
                      .read<TradeCubit>()
                      .updateAmount(state.fromToken?.balance ?? "0");
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

                    dollarValue: state.quote?.inUsdValue?.toString() ?? "0.0",
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
                        symbol: state.fromToken?.symbol ?? ""),
                    isSourceToken: true,
                  ),
                  // const SizedBox(height: 10), // 为中间图标留出空间
                  const SwapTokenDivider(),
                  // Target Token
                  TokenSwapCard(
                    onSelectToken: () => _handleSelectTargetToken(
                        state.nativeTokens ?? []), // 需要买进的代币
                    amount: outAmount,
                    dollarValue: state.quote?.outUsdValue?.toString() ?? "",
                    isEditable: false,
                    token: TradeToken(
                        chainName: state.toToken?.chainName ?? "",
                        chainId: state.toChainId ?? 0,
                        chainLogo: state.toToken?.chainLogo ?? "",
                        tokenAvatar: state.toToken?.tokenAvatar ?? "",
                        tokenName: state.toToken?.tokenName ?? "",
                        decimals: state.toToken?.decimals ?? 18,
                        address: state.toToken?.address ?? "",
                        balance: state.toToken?.balance ?? "",
                        symbol: state.toToken?.symbol ?? ""),
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
      final isLoading = state.status.whenOrNull(loading: () => true);
      final isValid = state.paramsStatus.mapOrNull(
              failure: (_) => false,
              success: (_) => true,
              loading: (_) => true,
              initial: (_) => true) ??
          false;

// 余额不足情况
      final isValidBalance = context
          .read<TradeCubit>()
          .checkAmount(state.amount, state.fromToken?.balance ?? "0");

      final buttonText = isValidBalance
          ? S.of(context).tradeNow
          : "${state.fromToken?.symbol} ${S.of(context).balanceNotEnough}";

      return PrimaryButton(
        onPressed: () {
          if (isValid && isValidBalance) {
            context.read<TradeCubit>().swap();
          }
          return;
        },
        borderRadius: BorderRadius.zero,
        // isLoading: isLoading,
        width: double.infinity,
        backgroundColor: !isValid || state.amount.isEmpty || !isValidBalance
            ? AppColors.quinary
            : AppColors.buttonPrimary(context),
        textColor: AppColors.black,
        fontSize: 16.sp,
        icon: isValidBalance
            ? (isLoading ?? false
                ? LoadingIndicator(color: AppColors.black, size: 16.w)
                : SvgPicture.asset(
                    'assets/images/icons/aim-outline.svg',
                    colorFilter: ColorFilter.mode(
                        !isValid || state.amount.isEmpty || !isValidBalance
                            ? AppColors.textTertiary(context)
                            : AppColors.black,
                        BlendMode.srcIn),
                  ))
            : null,
        label: Text(
          buttonText,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: !isValid || state.amount.isEmpty || !isValidBalance
                  ? AppColors.textTertiary(context)
                  : AppColors.black),
        ),
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
        final mode = tradeSetting.mode == TradeMode.fast
            ? S.of(context).fastMode
            : S.of(context).normalMode;
        return GestureDetector(
          onTap: () {
            context.push(Routes.tradeSetting);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                width: 13.w,
                height: 13.w,
                colorFilter: ColorFilter.mode(
                    AppColors.textSecondary(context), BlendMode.srcIn),
                "assets/images/icons/lightning-outline.svg",
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                mode,
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.textSecondary(context)),
              ),
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
