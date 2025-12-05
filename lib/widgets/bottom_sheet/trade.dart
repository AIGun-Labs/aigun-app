import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../themes/themes.dart';
import '../button/amount_group.dart';
import '../media/token.dart';

void showBottomSheetTrade(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.background(context),
    constraints: const BoxConstraints(
      minWidth: double.infinity,
      maxWidth: double.infinity,
    ),
    builder: (BuildContext context) {
      return const BottomSheetTradeContent();
    },
  );
}

class BottomSheetTradeContent extends StatefulWidget {
  const BottomSheetTradeContent({super.key});

  @override
  State<BottomSheetTradeContent> createState() =>
      _TradeBottomSheetContentState();
}

class _TradeBottomSheetContentState extends State<BottomSheetTradeContent> {
  bool isBuy = true;

  bool canTrade = false;

  final TextEditingController _amountController = TextEditingController();
  final NumberFormat _numberFormat = NumberFormat('#,###');
  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String _formatNumber(String value) {
    if (value.isEmpty) return '';

    String cleanValue = value.replaceAll(',', '');

    if (double.tryParse(cleanValue) == null) return value;

    List<String> parts = cleanValue.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    if (integerPart.isNotEmpty) {
      int number = int.tryParse(integerPart) ?? 0;
      String formattedInteger = _numberFormat.format(number);

      if (decimalPart.isNotEmpty) {
        return '$formattedInteger.$decimalPart';
      } else {
        return formattedInteger;
      }
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.textTertiary(context),
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: SizedBox(width: 40.w, height: 4.h),
          ),
          SizedBox(height: 16.h),
          const MediaToken(
            tokenName: "Token",
            tokenSymbol: "T",
            tokenLogo: "assets/images/icons/ai-agent.png",
            chainLogo: "assets/images/icons/ai-agent.png",
            showChain: true,
          ),
          SizedBox(height: 21.h),
          SizedBox(
            height: 35.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface(context),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            isBuy ? AppColors.secondary : Colors.transparent,
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            isBuy
                                ? Colors.white
                                : AppColors.textTertiary(context),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isBuy = true;
                          });
                        },
                        child: const Text(''),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            !isBuy ? AppColors.secondary : Colors.transparent,
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            !isBuy
                                ? Colors.white
                                : AppColors.textTertiary(context),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isBuy = false;
                          });
                        },
                        child: const Text(''),
                      ),
                    ],
                  ),
                ),
                if (isBuy)
                  TextButton.icon(
                    style: ButtonStyle(
                      textStyle: WidgetStateProperty.all(
                        TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                      ),
                      foregroundColor: WidgetStateProperty.all(
                        AppColors.textSecondary(context),
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        Colors.transparent,
                      ),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                    iconAlignment: IconAlignment.end,
                    onPressed: () {
                      setState(() {
                        canTrade = !canTrade;
                      });
                    },
                    label: const Text(''),
                    icon: const Icon(Icons.sync_alt),
                  ),
              ],
            ),
          ),
          SizedBox(height: 23.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      if (newValue.text.isEmpty) {
                        return newValue;
                      }
                      String formatted = _formatNumber(newValue.text);

                      int cursorPosition = newValue.selection.end;
                      int commasBefore =
                          newValue.text
                              .substring(0, cursorPosition)
                              .split(',')
                              .length -
                          1;
                      int commasAfter = formatted.split(',').length - 1;
                      int newCursorPosition =
                          cursorPosition + (commasAfter - commasBefore);

                      return TextEditingValue(
                        text: formatted,
                        selection: TextSelection.collapsed(
                          offset: newCursorPosition.clamp(0, formatted.length),
                        ),
                      );
                    }),
                  ],
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    hintText: '123,455,678.23131',
                    hintStyle: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textTertiary(context),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    spacing: 4.w,
                    children: [
                      Image(
                        image: const AssetImage(
                          "assets/images/icons/ai-agent.png",
                        ),
                        width: 18.w,
                        height: 18.h,
                      ),
                      Text(
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textTertiary(context),
                        ),
                        'SOL',
                      ),
                    ],
                  ),
                  Row(
                    spacing: 4.w,
                    children: [
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        color: AppColors.textQuaternary(context),
                        size: 14.w,
                      ),
                      Text(
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.textQuaternary(context),
                        ),
                        '1.23 SOL',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(
            child: isBuy
                ? ButtonAmountGroup(
                    amounts: const ['0.2', '0.5', '1', '2'],
                    onAmountSelected: (amount) {
                      _amountController.text = amount.toString();
                    },
                  )
                : ButtonAmountGroup(
                    amounts: const ['25%', '50%', '75%', '100%'],
                    onAmountSelected: (amount) {
                      _amountController.text = amount.toString();
                    },
                  ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.r),
            child: canTrade
                ? null
                : Text(
                    style: TextStyle(fontSize: 14.sp, color: AppColors.primary),
                    "SOL，",
                  ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: canTrade
                ? ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        AppColors.buttonPrimary(context),
                      ),
                      foregroundColor: WidgetStateProperty.all(
                        AppColors.background(context),
                      ),
                      minimumSize: WidgetStateProperty.all(
                        const Size(double.infinity, double.infinity),
                      ),
                    ),
                    onPressed: () {},
                    label: Text(
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      '',
                    ),
                    icon: SvgPicture.asset(
                      'assets/images/icons/aim-outline.svg',
                      width: 20.w,
                      height: 20.h,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 10.w,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            textStyle: WidgetStateProperty.all(
                              TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor: WidgetStateProperty.all(
                              AppColors.buttonPrimary(context),
                            ),
                            foregroundColor: WidgetStateProperty.all(
                              AppColors.background(context),
                            ),
                            minimumSize: WidgetStateProperty.all(
                              const Size(double.infinity, double.infinity),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('SOL'),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            textStyle: WidgetStateProperty.all(
                              TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor: WidgetStateProperty.all(
                              AppColors.quaternary,
                            ),
                            foregroundColor: WidgetStateProperty.all(
                              AppColors.background(context),
                            ),
                            minimumSize: WidgetStateProperty.all(
                              const Size(double.infinity, double.infinity),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(''),
                        ),
                      ),
                    ],
                  ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
