import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/format/index.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/utils/format/numeric.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_aigun/utils/sheet/token_selector_sheet.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_aigun/widgets/loading_indicator/index.dart';
import 'package:flutter_aigun/widgets/setting/trade_row.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_aigun/widgets/avatar/widget/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TradeSheet extends StatefulWidget {
  const TradeSheet({super.key});

  @override
  TradeSheetState createState() => TradeSheetState();
}

class TradeSheetState extends State<TradeSheet> {
  bool isBuy = true;

  List<String> sellPercentValues = ['25', '50', '75', 'all'];
  Map<String, String> sellPercentMap = {
    '25': '25%',
    '50': '50',
    '75': '75',
    'all': '100'
  };

  List<String> buyPercentValues = ['0.2', '0.5', '1', '2'];

  late TextEditingController _sellPercentController;
  late TextEditingController _buyAmountController;
  final FocusNode _sellPercentFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _sellPercentController = TextEditingController(text: "0%");
    _buyAmountController = TextEditingController(text: "0.0");
    _sellPercentFocusNode.addListener(() {
      _handleSellPercentFocusChange(_sellPercentFocusNode.hasFocus);
    });
  }

  void _handleSellPercentFocusChange(bool hasFocus) {
    final text = _sellPercentController.text;
    if (hasFocus) {
      _sellPercentController.text =
          text.endsWith("%") ? text.substring(0, text.length - 1) : text;
    } else {
      _sellPercentController.text = text.endsWith("%") ? text : "$text%";
    }
  }

  void _handleSellPercentChange(String value) {
    setState(() {
      if (value == 'all') {
        _sellPercentController.text = "100%";
        context.read<QuickTradeCubit>().updateSellPercent("100");
      } else {
        _sellPercentController.text = "$value%";
        context.read<QuickTradeCubit>().updateSellPercent(value);
      }
    });
  }

  void _handleBuyAmountChange(String value) {
    final formatted = NumericFormatter.formatToWei(value);

    setState(() {
      _buyAmountController.text = formatted;

      context.read<QuickTradeCubit>().updateBuyAmount(value);
    });
  }

  @override
  void dispose() {
    _sellPercentController.dispose();
    _buyAmountController.dispose();
    _sellPercentFocusNode.dispose();
    super.dispose();
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
    return BlocConsumer<QuickTradeCubit, QuickTradeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
              child: AnimatedPadding(
                  padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 8.h,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  duration: const Duration(milliseconds: 200),
                  child: _buildTradeSheetContent(state)));
        });
  }

  Widget _buildTradeSheetContent(QuickTradeState state) {
    final isBalanceEnough = state.isBalanceEnough();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 4.h,
          width: 40.w,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.border(context),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        ListTile(
          onTap: null,
          contentPadding: EdgeInsets.zero,
          leading: AvatarToken(
            avatar: state.selectedToken?.tokenAvatar ?? "",
            chainLogo: state.selectedToken?.chainLogo ?? "",
            tokenName: state.selectedToken?.tokenName ?? "",
            chainName: state.selectedToken?.chainName ?? "",
            width: 50.w,
            height: 50.h,
            chainLogoWidth: 20.w,
            chainLogoHeight: 20.h,
            right: -10.w,
          ),
          title: GestureDetector(
            onTap: () {
              ClipboardUtils.copy(state.selectedToken?.tokenName ?? "")
                  .then((_) {
                if (mounted) {
                  showSimpleToast(S.of(context).copySuccess,
                      context: context, type: ToastificationType.success);
                }
              });
            },
            child: Text(
              state.selectedToken?.symbol ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textPrimary(context),
                  fontWeight: FontWeight.w700),
            ),
          ),
          subtitle: GestureDetector(
            onTap: () {
              ClipboardUtils.copy(state.selectedToken?.address ?? "").then((_) {
                // if (mounted) {
                //   SnackBarUtils.showSimpleSnackBar(
                //       context, S.of(context).copySuccess);
                // }
              });
            },
            child: Text(
              AddressFormatter.formatAddress(
                  state.selectedToken?.address ?? ""),
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textTertiary(context),
              ),
            ),
          ),
        ),

        SizedBox(height: 12.h),

// 买卖切换按钮
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 33.h,
                decoration: BoxDecoration(
                  color: AppColors.surface(context),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 69.w,
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                state.mode == QuickTradeMode.buy
                                    ? AppColors.primary
                                    : Colors.transparent),
                            foregroundColor: WidgetStateProperty.all(
                                state.mode == QuickTradeMode.buy
                                    ? Colors.white
                                    : AppColors.textTertiary(context)),
                            padding: WidgetStateProperty.all(EdgeInsets.zero),
                            alignment: Alignment.center,
                          ),
                          onPressed: () {
                            // 更新模式为买入
                            context
                                .read<QuickTradeCubit>()
                                .updateMode(QuickTradeMode.buy);
                          },
                          child: Text(
                            S.of(context).buy,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: state.mode == QuickTradeMode.buy
                                    ? Colors.white
                                    : AppColors.textTertiary(context)),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    SizedBox(
                      width: 69.w,
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                state.mode == QuickTradeMode.sell
                                    ? AppColors.primary
                                    : Colors.transparent),
                            foregroundColor: WidgetStateProperty.all(
                                state.mode == QuickTradeMode.sell
                                    ? Colors.white
                                    : AppColors.textTertiary(context)),
                            padding: WidgetStateProperty.all(EdgeInsets.zero),
                            alignment: Alignment.center,
                          ),
                          onPressed: () {
                            // 更新模式为卖出
                            context
                                .read<QuickTradeCubit>()
                                .updateMode(QuickTradeMode.sell);
                          },
                          child: Text(
                            S.of(context).sell,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: state.mode == QuickTradeMode.sell
                                    ? AppColors.textPrimary(context)
                                    : AppColors.textTertiary(context)),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            // 右边的选择代币按钮
            state.mode == QuickTradeMode.buy
                ? GestureDetector(
                    onTap: () async {
                      // showSelectTokenDialog(context);
                      context.read<SearchTokenCubit>().clear();
                      final tokens =
                          context.read<TradeCubit>().state.availableTokens;

                      final selectedToken = await showTokenSelectorSheet(
                          context, tokens,
                          title: S.of(context).selectTradeToken,
                          isSearch: false,
                          isShowRight: true,
                          subTitle: S.of(context).crossChainTrade,
                          leading: const SizedBox.shrink(),
                          suffix: Icon(Icons.close,
                              size: 24.sp,
                              color: AppColors.foreground(context)));

                      if (selectedToken != null && mounted) {
                        context
                            .read<QuickTradeCubit>()
                            .updateFromToken(selectedToken);
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          S.of(context).buyWithOtherToken,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary(context)),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        // Icon(
                        //   Icons.sync_alt,
                        //   size: 14.w,
                        //   color: AppColors.textSecondary(context),
                        // ),
                        SvgPicture.asset(
                          "assets/images/icons/wallet-trade-action.svg",
                          width: 16.w,
                          height: 16.w,
                          colorFilter: ColorFilter.mode(
                              AppColors.textSecondary(context),
                              BlendMode.srcIn),
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        // 数据行
        state.mode == QuickTradeMode.buy
            ? _buildBuy(isBalanceEnough)
            : _buildSell(isBalanceEnough),

        SizedBox(height: 12.h),
        const SettingTradeRow(),
      ],
    );
  }

  Widget _buildSell(isBalanceEnough) {
    return BlocBuilder<QuickTradeCubit, QuickTradeState>(
        builder: (context, state) {
      // 检查 sellPercent 是否为空或无效
      final sellPercent = state.sellPercent.isEmpty ? "0" : state.sellPercent;

// 先转换为百分比
      final sellPercentValue = sellPercent.toPercentage();

// 两数相乘得到结果
      final sellAmount =
          sellPercentValue.safeMultiply(state.selectedToken?.balance ?? "0");

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120.w,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        TextField(
                          // 卖出百分比 controller
                          controller: _sellPercentController,
                          keyboardType: TextInputType.number,
                          onChanged: _handleSellPercentChange,
                          enableInteractiveSelection: true,
                          focusNode: _sellPercentFocusNode,

                          onEditingComplete: () {
                            // 完成输入添加一个百分号
                            _handleSellPercentChange(
                                "${_sellPercentController.text}%");
                            context
                                .read<QuickTradeCubit>()
                                .updateSellPercent("100");
                          },
                          inputFormatters: [
                            // 只允许输入整数
                            FilteringTextInputFormatter.digitsOnly,
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              // 如果输入为空，允许
                              if (newValue.text.isEmpty) {
                                return newValue;
                              }
                              // 转换为整数
                              final int? value = int.tryParse(newValue.text);
                              // 如果不是有效整数，禁止
                              if (value == null) {
                                return oldValue;
                              }
                              // 不允许大于100的整数
                              if (value > 100) {
                                return oldValue;
                              }
                              // 阻止多余的前导0（如00, 000等，但允许单个0）
                              if (newValue.text.length > 1 &&
                                  newValue.text.startsWith('0')) {
                                return oldValue;
                              }
                              return newValue;
                            }),
                          ],
                          style: TextStyle(
                              fontSize: 28.sp,
                              color: AppColors.textPrimary(context),
                              fontWeight: FontWeight.w700),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "0",
                            hintStyle: TextStyle(
                                fontSize: 28.sp,
                                color: AppColors.textQuaternary(context),
                                fontWeight: FontWeight.w700),
                            contentPadding:
                                EdgeInsets.only(right: 28.w), // 给百分号留空间
                          ),
                          textAlign: TextAlign.left, // 让输入内容居中
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${CurrencyFormatter.abbreviateTokenPrice(double.parse(sellAmount.toString()))} ${state.selectedToken?.symbol ?? ""}",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textTertiary(context)),
                  )
                ],
              ),
              Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        state.selectedToken?.tokenName ?? "",
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textTertiary(context),
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            "assets/images/icons/wallet-outline.svg",
                            colorFilter: ColorFilter.mode(
                                AppColors.textTertiary(context),
                                BlendMode.srcIn),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "${state.selectedToken?.balance.isEmpty ?? true ? "0" : CurrencyFormatter.abbreviateTokenPrice(double.parse(state.selectedToken?.balance ?? "0"))} ${state.selectedToken?.symbol ?? ""}",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textTertiary(context)),
                          )
                        ],
                      ),
                    ],
                  ))
            ],
          ),
          SizedBox(height: 10.h),
          _buildSellButtons(onPressed: (value) {
            // showSimpleToast("卖出$value%");
            _handleSellPercentChange(value);
            _sellPercentFocusNode.unfocus();
          }),
          SizedBox(height: 16.h),
          _buildConfirmButton(
              text: isBalanceEnough
                  ? S.of(context).sellNow
                  : S.of(context).balanceNotEnough,
              backgroundColor: isBalanceEnough
                  ? AppColors.buttonPrimary(context)
                  : AppColors.surface(context),
              textColor: isBalanceEnough
                  ? Colors.white
                  : AppColors.textTertiary(context),
              onPressed: () {
                if (isBalanceEnough) {
                  context
                      .read<QuickTradeCubit>()
                      .sellToken(context, _closeToast, _showTraingToast);
                }
              }),
        ],
      );
    });
  }

// 买入输入行
  Widget _buildBuy(bool isBalanceEnough) {
    return BlocBuilder<QuickTradeCubit, QuickTradeState>(
        buildWhen: (previous, current) =>
            previous.fromToken != current.fromToken,
        builder: (context, state) {
          // final buyAmount = state.buyAmount.isEmpty ? "0" : state.buyAmount;
          // final buyAmountValue = NumericUtils.subtractNumbers(
          //     state.fromToken?.balance ?? "0", buyAmount);

          final isLoading =
              state.buyTokenStatus.whenOrNull(loading: () => true) ?? false;

          return Column(
            children: [
              Transform.translate(
                offset: Offset(0, 4.h),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: TextField(
                        controller: _buyAmountController,
                        onChanged: _handleBuyAmountChange,
                        keyboardType: TextInputType.number,
                        enableInteractiveSelection: true,
                        inputFormatters: [
                          // 只接受数字和小数点
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        style: TextStyle(
                            fontSize: 28.sp,
                            color: AppColors.textPrimary(context),
                            fontWeight: FontWeight.w700),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "0.0",
                          hintStyle: TextStyle(
                              fontSize: 28.sp,
                              color: AppColors.textQuaternary(context),
                              fontWeight: FontWeight.w700),
                        ),
                      )),
                      SizedBox(
                        width: 6.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: SmartNetworkImage(
                                  url: getImageUrl(
                                          state.fromToken?.tokenAvatar) ??
                                      "",
                                  width: 16.w,
                                  height: 16.h,
                                  errorWidget: Container(
                                    color: Colors.grey[200],
                                    height: 16.h,
                                    width: 16.w,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                state.fromToken?.symbol ?? "",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.textTertiary(context),
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/icons/wallet-outline.svg",
                                width: 13.w,
                                height: 13.h,
                                colorFilter: ColorFilter.mode(
                                    AppColors.textTertiary(context),
                                    BlendMode.srcIn),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "${CurrencyFormatter.abbreviateTokenPrice(double.parse(state.fromToken?.balance ?? "0"))} ${state.fromToken?.symbol ?? ""}",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.textTertiary(context)),
                              )
                            ],
                          ),
                        ],
                      )
                    ]),
              ),
              SizedBox(height: 3.h),
              _buildBuyButtons(onPressed: (value) {
                _handleBuyAmountChange(value);
              }),
              isBalanceEnough
                  ? SizedBox(height: 16.h)
                  : Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      child: Text(
                        S.of(context).balanceNotEnoughHint(
                            state.fromToken?.symbol ?? ""),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14.sp, color: AppColors.secondary),
                      ),
                    ),
              _buildBuyButton(isBalanceEnough, isLoading: isLoading)
            ],
          );
        });
  }

  Widget _buildBuyButton(bool isBalanceEnough, {bool isLoading = false}) {
    if (isBalanceEnough) {
      return _buildConfirmButton(
          text: isBalanceEnough
              ? S.of(context).buyNow
              : S.of(context).balanceNotEnough,
          backgroundColor: isBalanceEnough
              ? AppColors.buttonPrimary(context)
              : AppColors.surface(context),
          textColor:
              isBalanceEnough ? Colors.white : AppColors.textTertiary(context),
          isLoading: isLoading,
          onPressed: () {
            if (isBalanceEnough) {
              context
                  .read<QuickTradeCubit>()
                  .buyToken(context, _closeToast, _showTraingToast);
            }
          });
    } else {
      return _buildBalanceNotEnough();
    }
  }

  Widget _buildBalanceNotEnough() {
    return BlocBuilder<QuickTradeCubit, QuickTradeState>(
        builder: (context, state) {
      return Row(
        children: [
          Expanded(
              child: PrimaryButton(
            onPressed: () {},
            // isLoading: isLoading,
            width: double.infinity,
            backgroundColor: AppColors.buttonPrimary(context),
            textColor: Colors.white,
            fontSize: 16.sp,

            label: Text(
              S.of(context).topUpToken(state.fromToken?.symbol ?? ""),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          )),
          SizedBox(width: 16.w),
          Expanded(
              child: PrimaryButton(
            onPressed: () async {
              final tokens = context.read<TradeCubit>().state.availableTokens;
              final selectedToken = await showTokenSelectorSheet(
                  context, tokens,
                  title: S.of(context).selectTradeToken,
                  isSearch: false,
                  isShowRight: true,
                  subTitle: S.of(context).crossChainTrade,
                  leading: const SizedBox.shrink(),
                  suffix: Icon(Icons.close,
                      size: 24.sp, color: AppColors.foreground(context)));

              if (selectedToken != null) {
                // ignore: use_build_context_synchronously
                context.read<QuickTradeCubit>().updateFromToken(selectedToken);
              }
            },
            // isLoading: isLoading,
            width: double.infinity,
            backgroundColor: AppColors.buttonPrimary(context),
            textColor: Colors.white,
            fontSize: 16.sp,
            label: Text(
              S.of(context).topUpTokenHint,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ))
        ],
      );
    });
  }

  Widget _buildSellButtons({
    required Function(String)? onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButton(text: "25%", key: "25", onPressed: onPressed),
        _buildButton(text: "50%", key: "50", onPressed: onPressed),
        _buildButton(text: "75%", key: "75", onPressed: onPressed),
        _buildButton(text: S.of(context).all, key: "all", onPressed: onPressed)
      ],
    );
  }

  Widget _buildBuyButtons({
    required Function(String)? onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButton(text: "0.2", key: "0.2", onPressed: onPressed),
        _buildButton(text: "0.5", key: "0.5", onPressed: onPressed),
        _buildButton(text: "1", key: "1", onPressed: onPressed),
        _buildButton(text: "2", key: "2", onPressed: onPressed)
      ],
    );
  }

  Widget _buildConfirmButton(
      {String? text,
      required Function()? onPressed,
      Color? backgroundColor,
      Color? textColor,
      bool isLoading = false}) {
    return PrimaryButton(
      onPressed: onPressed,
      // isLoading: isLoading,
      width: double.infinity,
      backgroundColor: backgroundColor ?? AppColors.buttonPrimary(context),
      textColor: textColor ?? Colors.white,
      fontSize: 16.sp,
      isLoading: isLoading,
      loading: const LoadingIndicator(
        size: 20,
        color: Colors.white,
      ),
      icon: SvgPicture.asset(
        'assets/images/icons/aim-outline.svg',
        colorFilter:
            ColorFilter.mode(textColor ?? Colors.white, BlendMode.srcIn),
      ),
      label: Text(
        text ?? S.of(context).sellNow,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required String key,
    required Function(String)? onPressed,
  }) {
    return SizedBox(
      width: 80.w,
      height: 40.h,
      child: TextButton(
          onPressed: () => onPressed?.call(key),
          style: TextButton.styleFrom(
            backgroundColor: AppColors.card(context),
            foregroundColor: AppColors.textPrimary(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.textPrimary(context),
            ),
          )),
    );
  }
}
