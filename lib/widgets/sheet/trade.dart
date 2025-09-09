import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/screens/trade_back/widgets/token_list_dialog.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/format/index.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/utils/format/numeric.dart';
import 'package:flutter_aigun/utils/numeric_utils.dart';
import 'package:flutter_aigun/utils/sheet/token_selector_sheet.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_aigun/widgets/setting/trade_row.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_aigun/widgets/token/token_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TradeSheet extends StatefulWidget {
  TradeSheet({Key? key}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    _sellPercentController = TextEditingController(text: "0.0");
    _buyAmountController = TextEditingController(text: "0.0");
  }

  void _handleSellPercentChange(String value) {
    setState(() {
      if (value == 'all') {
        _sellPercentController.text = "100";
      } else {
        _sellPercentController.text = value;
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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuickTradeCubit, QuickTradeState>(
        builder: (context, state) {
      // state.buyTokenStatus.whenOrNull(success: (transaction) {
      //   showSimpleToast("操作成功", type: ToastificationType.success);
      // }, failure: (failure) {
      //   showSimpleToast("未知错误，请检查 Gas 费用是否足够", type: ToastificationType.error);
      // });

      // state.sellTokenStatus.whenOrNull(success: (transaction) {
      //   showSimpleToast("操作成功", type: ToastificationType.success);
      // }, failure: (failure) {
      //   showSimpleToast("未知错误，请检查 Gas 费用是否足够", type: ToastificationType.error);
      // });

      return SafeArea(
          child: Padding(
              padding: EdgeInsets.all(16.w),
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
              color: AppColors.textTertiary(context),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        ListTile(
          onTap: null,
          contentPadding: EdgeInsets.zero,
          leading: TokenAvatar(
            avatar: state.selectedToken?.tokenAvatar ?? "",
            chainLogo: state.selectedToken?.chainLogo ?? "",
            width: 55.w,
            height: 55.h,
            chainLogoWidth: 20.w,
            chainLogoHeight: 20.h,
          ),
          title: Text(
            state.selectedToken?.tokenName ?? "",
            style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textPrimary(context),
                fontWeight: FontWeight.w700),
          ),
          subtitle: GestureDetector(
            onTap: () {
              ClipboardUtils.copy(state.selectedToken?.address ?? "").then((_) {
                showSimpleToast("复制成功",
                    context: context, type: ToastificationType.success);
              });
            },
            child: Text(
              AddressFormatter.formatAddress(
                  state.selectedToken?.address ?? ""),
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textQuaternary(context),
              ),
            ),
          ),
        ),

// 买卖切换按钮
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 33.h,
                margin: EdgeInsets.symmetric(vertical: 16.w),
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
                            '买',
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: isBuy
                                    ? AppColors.textPrimary(context)
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
                            '卖',
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
                      final tokens =
                          context.read<TradeCubit>().state.availableTokens;
                      final selectedToken = await showTokenSelectorSheet(
                          context, tokens,
                          title: "选择交易币种",
                          isSearch: false,
                          isShowRight: true,
                          subTitle: "AIGun支持跨链交易",
                          leading: SizedBox.shrink(),
                          suffix: Icon(Icons.close,
                              size: 24.sp,
                              color: AppColors.foreground(context)));

                      if (selectedToken != null) {
                        context
                            .read<QuickTradeCubit>()
                            .updateFromToken(selectedToken);
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          "用其他币买",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary(context)),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Icon(
                          Icons.sync_alt,
                          size: 14.w,
                          color: AppColors.textSecondary(context),
                        )
                      ],
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
        // 数据行
        state.mode == QuickTradeMode.buy
            ? _buildBuy(isBalanceEnough)
            : _buildSell(isBalanceEnough),
        SizedBox(height: 16.h),
        SettingTradeRow(),
      ],
    );
  }

  Widget _buildSell(isBalanceEnough) {
    return BlocBuilder<QuickTradeCubit, QuickTradeState>(
        builder: (context, state) {
      // final balanceStr = state.selectedToken?.balance ?? "0";
      // final balance = int.tryParse(balanceStr) ?? 0;
      // final sellAmount = state.sellPercent * balance;

      // 检查 sellPercent 是否为空或无效
      final sellPercent = state.sellPercent.isEmpty ? "0" : state.sellPercent;
      final sellAmount = NumericUtils.multiplyTwoNumbers(
          sellPercent, state.selectedToken?.balance ?? "0");
      final balance = state.selectedToken?.balance ?? "0";

// 当前的代币余额是否大于 卖出数量的
      // final isBalanceEnough = NumericUtils.greaterThan(balance, sellAmount);

      return Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 方法一：使用Stack让百分号垂直居中于TextField右侧
                  SizedBox(
                    width: 80.w,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        TextField(
                          // 卖出百分比 controller
                          controller: _sellPercentController,
                          keyboardType: TextInputType.number,
                          onChanged: _handleSellPercentChange,
                          enableInteractiveSelection: true,
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
                        Positioned(
                          right: 0,
                          child: Text(
                            "%",
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    state.selectedToken?.tokenName ?? "",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textQuaternary(context),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$sellAmount ${state.selectedToken?.symbol ?? ""}",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textQuaternary(context)),
                  ),
                  Text(
                    "${state.selectedToken?.balance.isEmpty ?? true ? "0" : state.selectedToken?.balance} ${state.selectedToken?.symbol ?? ""}",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textQuaternary(context)),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10.h),
          _buildSellButtons(onPressed: (value) {
            // showSimpleToast("卖出$value%");
            _handleSellPercentChange(value);
          }),
          SizedBox(height: 16.h),
          _buildConfirmButton(
              text: isBalanceEnough ? "立即卖出" : "余额不足",
              backgroundColor: AppColors.senary,
              textColor: isBalanceEnough
                  ? AppColors.textQuaternary(context)
                  : AppColors.textTertiary(context),
              onPressed: () {
                if (isBalanceEnough) {
                  context.read<QuickTradeCubit>().sellToken();
                }
              }),
        ],
      );
    });
  }

// 买入输入行
  Widget _buildBuy(bool isBalanceEnough) {
    return BlocBuilder<QuickTradeCubit, QuickTradeState>(
        builder: (context, state) {
      // 检查 buyAmount 是否为空或无效
      final buyAmount = state.buyAmount.isEmpty ? "0" : state.buyAmount;
      final buyAmountValue = NumericUtils.subtractNumbers(
          state.fromToken?.balance ?? "0", buyAmount);

      return Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: TextField(
              controller: _buyAmountController,
              onChanged: _handleBuyAmountChange,
              keyboardType: TextInputType.number,
              enableInteractiveSelection: true,
              inputFormatters: [
                // 只接受数字和小数点
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                // 使用自定义输入格式化器
                TextInputFormatter.withFunction((oldValue, newValue) {
                  // 如果输入的值为空，则返回旧值
                  if (newValue.text.isEmpty) {
                    return newValue;
                  }
                  // 转换为数字（支持小数）
                  final double? value = double.tryParse(newValue.text);

                  // 如果转换失败，则返回旧值
                  if (value == null) {
                    return oldValue;
                  }

                  if (value < 0) {
                    return oldValue;
                  }
                  // 阻止多个小数点
                  if ('.'.allMatches(newValue.text).length > 1) {
                    return oldValue;
                  }

                  // 阻止以0开头但不是0或0.x的情况（如023, 00, 005等）
                  if (newValue.text.startsWith('0') &&
                      !newValue.text.startsWith('0.') &&
                      newValue.text.length > 1 &&
                      value != 0) {
                    return oldValue;
                  }
                  // 阻止00输入
                  if (newValue.text == '00') {
                    return oldValue;
                  }
                  // 返回新值
                  return newValue;
                }),
              ],
              style: TextStyle(
                  fontSize: 28.sp,
                  color: AppColors.textPrimary(context),
                  fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "0.5",
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
                        url: state.fromToken?.tokenAvatar ?? "",
                        width: 16.w,
                        height: 16.h,
                        errorWidget: const SizedBox.shrink(),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      state.fromToken?.tokenName ?? "",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textQuaternary(context),
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      state.fromToken?.chainLogo ?? "",
                      width: 14.w,
                      height: 14.h,
                      colorFilter: ColorFilter.mode(
                          AppColors.textQuaternary(context), BlendMode.srcIn),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      " ${formatPrice(state.fromToken?.balance)} ${state.fromToken?.symbol ?? ""}",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textQuaternary(context)),
                    )
                  ],
                ),
              ],
            )
          ]),
          SizedBox(height: 5.h),
          _buildBuyButtons(onPressed: (value) {
            // showSimpleToast("买入$value");
            // _handleBuyPercentChange(value);
            _handleBuyAmountChange(value);
          }),
          // SizedBox(height: 10.h),
          isBalanceEnough
              ? SizedBox(height: 16.h)
              : Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8.w),
                  child: NumericUtils.isGreaterThanZero(buyAmountValue)
                      ? const SizedBox.shrink()
                      : Text(
                          "${state.fromToken?.symbol ?? ""} 余额不足，无法执行本次交易",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14.sp, color: AppColors.secondary),
                        ),
                ),
          _buildConfirmButton(
              text: isBalanceEnough ? "立即购买" : "余额不足",
              backgroundColor: isBalanceEnough
                  ? AppColors.buttonPrimary(context)
                  : AppColors.senary,
              textColor: isBalanceEnough
                  ? AppColors.white
                  : AppColors.textQuaternary(context),
              onPressed: () {
                if (isBalanceEnough) {
                  context.read<QuickTradeCubit>().buyToken();
                }
              }),
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
        _buildButton(text: "全部", key: "all", onPressed: onPressed)
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
      Color? textColor}) {
    return PrimaryButton(
      onPressed: onPressed,
      // isLoading: isLoading,
      width: double.infinity,
      backgroundColor: backgroundColor ?? AppColors.buttonPrimary(context),
      textColor: textColor ?? AppColors.white,
      fontSize: 16.sp,
      icon: SvgPicture.asset(
        'assets/images/icons/aim-outline.svg',
        colorFilter:
            ColorFilter.mode(textColor ?? AppColors.white, BlendMode.srcIn),
      ),
      label: Text(
        text ?? '立即卖出',
        style: TextStyle(fontWeight: FontWeight.bold),
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
