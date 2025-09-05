import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/trade/widgets/token_swap_card.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
// import 'package:flutter_aigun/widgets/token/models/token.dart';

class TradeSwap extends StatefulWidget {
  TradeSwap({Key? key}) : super(key: key);

  @override
  _TradeSwapState createState() => _TradeSwapState();
}

class _TradeSwapState extends State<TradeSwap> {
  // final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // amountController.addListener(() {
    //   context.read<TradeCubit>().updateAmount(amountController.text);
    // });
  }

  @override
  void dispose() {
    // amountController.dispose();
    super.dispose();
  }

  /// 选择来源代币
  Future<void> _handleSelectSourceToken(List<Token> availableTokens) async {
    ///  选择来源代币
    final selectedToken = await showTokenSelectorSheet(
      context,
      availableTokens,
    );

    if (selectedToken != null) {
      context.read<TradeCubit>().updateFromToken(_mapToToken(selectedToken));
    }
  }

  /// 选择目标代币
  Future<void> _handleSelectTargetToken(List<Token> availableTokens) async {
    final selectedToken =
        await showTokenSelectorSheet(context, availableTokens);
    if (selectedToken != null) {
      context.read<TradeCubit>().updateToToken(_mapToToken(selectedToken));
    }
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
        symbol: token.symbol);
    return tradeToken;
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TradeCubit, TradeState, TradeStatusMessage>(
        selector: (state) => state.status,
        builder: (context, state) {
          state.whenOrNull(failure: (failure) {
            if (failure == TradeStatus.paramsInvalid) {
              Fluttertoast.showToast(
                  msg: "交易失败参数错误", gravity: ToastGravity.TOP);
            }
          });
          return Column(
            children: [
              _buildBalanceRow(context),
              const SizedBox(height: 4),
              _buildTradeSwap(context),
              const SizedBox(height: 24),
              _buildTradeButton(context),
              const SizedBox(height: 16),
              _buildTradeDefailsRow(context),
              const SizedBox(height: 16),
            ],
          );
        });
  }

  Widget _buildBalanceRow(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(builder: (context, state) {
// final balance = state.wallets.first.addresses

      final balanceStr =
          "${formatPrice(state.fromToken?.balance)} ${state.fromToken?.symbol ?? ""}";

      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon(
          //   Icons.wallet_rounded,
          //   color: AppColors.textSecondary(context),
          //   size: 20.w,
          // ),
          SvgPicture.asset(
            "assets/images/icons/wallet-outline.svg",
            colorFilter: ColorFilter.mode(
                AppColors.textSecondary(context), BlendMode.srcIn),
            width: 15.w,
            height: 15.w,
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(balanceStr,
              style: TextStyle(
                  fontSize: 16.sp, color: AppColors.textSecondary(context))),
          SizedBox(
            width: 4.w,
          ),
          CircleAvatar(
              backgroundColor: AppColors.card(context),
              radius: 10.w,
              child: Icon(
                Icons.add,
                color: AppColors.textSecondary(context),
                size: 20.w,
              )),
          // Spacer(),
          // IconButton(
          //     onPressed: () {
          //       context.push(Routes.tradeSetting);
          //     },
          //     icon: const Icon(Icons.settings))
        ],
      );
    });
  }

  Widget _buildTradeSwap(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(
        buildWhen: (previous, current) =>
            previous.quote != current.quote ||
            previous.fromToken != current.fromToken ||
            previous.toToken != current.toToken ||
            previous.availableTokens != current.availableTokens,
        builder: (context, state) {
          final outAmount = NumericUtils.divideStringByNumber(
                  state.quote?.outAmount ?? "", state.toToken?.decimals ?? 18)
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

                    dollarValue: state.quote?.inUsdValue?.toString() ?? "0.0",
                    isEditable: true,
                    // amountController: amountController,
                    onAmountChanged: (amount) {
                      context.read<TradeCubit>().updateAmount(amount);
                    },
                    token: TradeToken(
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
                  const SizedBox(height: 10), // 为中间图标留出空间
                  // Target Token
                  TokenSwapCard(
                    onSelectToken: () => _handleSelectTargetToken(
                        state.availableTokens), // 需要买进的代币
                    amount: outAmount,
                    dollarValue: state.quote?.outUsdValue?.toString() ?? "",
                    isEditable: false,
                    token: TradeToken(
                        chainId: state.toChainId,
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
              // 垂直居中的交换图标
              Positioned(
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.card(context),
                      shape: BoxShape.circle,
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
                        'assets/images/icons/swap.svg',
                        height: 16.w,
                        width: 16.w,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _buildTradeButton(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        context.read<TradeCubit>().swap();
      },
      width: double.infinity,
      backgroundColor: AppColors.buttonPrimary(context),
      textColor: AppColors.backgroundWhite,
      fontSize: 16.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/icons/aim-outline.svg'),
          SizedBox(width: 4),
          const Text(
            'Swap',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTradeDefailsRow(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(builder: (context, state) {
      final gasFee = formatPrice(state.quote?.gasFee ?? 0);
      // final tradeSetting = context.read<TradeSettingCubit>().state;

      return BlocBuilder<TradeSettingCubit, TradeSettingState>(
          builder: (context, tradeSetting) {
        final setting = tradeSetting.customSettings[state.fromChainId];
        final mode = tradeSetting.mode == TradeMode.lightning ? "闪电模式" : "平滑模式";
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
              Spacer(),
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
              SizedBox(width: 10),
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
              SizedBox(width: 10),
              Row(
                spacing: 4.w,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/icons/shield.svg",
                    width: 10.w,
                    height: 12.w,
                  ),
                  Text(setting?.mevProtect ?? false ? "开" : "关",
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
