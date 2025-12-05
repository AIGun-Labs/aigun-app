import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../l10n/l10n.dart';
import '../../../themes/themes.dart';
import '../../../utils/extensions/string.dart';
import '../../../utils/format/currency.dart';
import '../../../utils/format/input_formatters.dart';
import '../../../utils/format/string.dart';
import '../../../utils/toast/trade_status_toast.dart';

class TokenSwapCard extends StatefulWidget {
  const TokenSwapCard({
    super.key,
    required this.onSelectToken,
    required this.dollarValue,
    required this.isSourceToken,
    this.onAmountChanged,
    this.isEditable = false,
    this.amountController,
    this.amount,
  });

  final VoidCallback onSelectToken;
  final String dollarValue;
  final bool isSourceToken;
  final ValueChanged<String>? onAmountChanged;
  final bool isEditable;
  final TextEditingController? amountController;
  final String? amount;

  @override
  State<TokenSwapCard> createState() => _TokenSwapCardState();
}

class _TokenSwapCardState extends State<TokenSwapCard> {
  late TextEditingController _amountController;
  late FocusNode _focusNode;
  bool _isControllerOwned = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _initializeController();
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void didUpdateWidget(TokenSwapCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.amountController != oldWidget.amountController) {
      _amountController.removeListener(_onAmountChanged);
      if (_isControllerOwned) {
        _amountController.dispose();
      }
      _initializeController();
      _amountController.addListener(_onAmountChanged);
    }

    if (widget.amount != oldWidget.amount &&
        _amountController.text != widget.amount) {
      _amountController.text = widget.amount ?? "";
    }
  }

  void _initializeController() {
    if (widget.amountController != null) {
      _amountController = widget.amountController ?? TextEditingController();
      _isControllerOwned = false;
    } else {
      _amountController = TextEditingController(text: widget.amount ?? "");
      _isControllerOwned = true;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _amountController.removeListener(_onAmountChanged);
    if (_isControllerOwned) {
      _amountController.dispose();
    }
    super.dispose();
  }

  void _onAmountChanged() {
    // widget.onAmountChanged?.call(_amountController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 6.0.h),
      child: SizedBox(
        height: 70.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: widget.onSelectToken,
              child: Row(
                children: [
                  SizedBox(width: 16.w),
                  SizedBox(width: 4.w),
                  SvgPicture.asset("assets/images/icons/chevron-down.svg"),
                ],
              ),
            ),
            // Spacer(),
            SizedBox(width: 12.w),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  TradeStatusToastUtils.showNotSupportedInputAmountToast();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildAmount(),
                    if (widget.dollarValue.isNotEmpty) _buildDollarValue(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmount() {
    if (!widget.isEditable) {
      return _buildNotEditableAmount();
    }

    return SizedBox(
      child: TextField(
        controller: _amountController,
        focusNode: _focusNode,
        onChanged: widget.onAmountChanged,
        textAlign: TextAlign.end,
        readOnly: !widget.isEditable,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: TextStyle(
          fontSize: 20.sp,
          color: AppColors.textPrimary(context),
          fontWeight: FontWeight.w600,
        ),
        inputFormatters: InputFormatters.tradeAmountInputFormatters(
          maxDecimalPlaces: 4,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "0.0",
          hintStyle: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textQuaternary(context),
          ),
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildNotEditableAmount() {
    Widget textWidget;

    final amount = CurrencyFormatter.abbreviateTokenPrice(
      double.tryParse(_amountController.text) ?? 0,
    );

    if (!_amountController.text.isNotEmptyAndZeroValue) {
      textWidget = Text(
        "0.0",
        style: TextStyle(
          fontSize: 22.sp,
          color: AppColors.textQuaternary(context),
          fontWeight: FontWeight.w700,
        ),
      );
    } else {
      textWidget = Text(
        "≈$amount",
        style: TextStyle(
          fontSize: 22.sp,
          color: AppColors.textPrimary(context),
          fontWeight: FontWeight.w700,
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: textWidget,
    );
  }

  Widget _buildDollarValue() {
    final dollarValue = Decimal.tryParse(widget.dollarValue);
    if (dollarValue == null || dollarValue.toDouble() == 0) {
      return const SizedBox.shrink();
    }

    final dollarValueStr = CurrencyFormatter.abbreviateTokenPriceWithSymbol(
      double.tryParse(widget.dollarValue) ?? 0,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        dollarValueStr,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.textSecondary(context),
        ),
      ),
    );
  }

  Widget _buildSelectTokenText() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        StringFormatter.splitText("SOL", splitLength: 10),
        style: TextStyle(fontSize: 22.w, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildNotSelectTokenText() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        StringFormatter.splitText(S.of(context).selectToken, splitLength: 10),
        style: TextStyle(fontSize: 16.w),
      ),
    );
  }
}
