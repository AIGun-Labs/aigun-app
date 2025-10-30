import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/format/input_formatters.dart';
import 'package:flutter_aigun/utils/format/string.dart';
import 'package:flutter_aigun/utils/image_utils.dart';
import 'package:flutter_aigun/utils/toast/trade_status_toast.dart';
import 'package:flutter_aigun/widgets/feature_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TokenSwapCard extends StatefulWidget {
  const TokenSwapCard(
      {super.key,
      required this.onSelectToken,
      required this.dollarValue,
      required this.token,
      required this.isSourceToken,
      this.onAmountChanged,
      this.isEditable = false,
      this.amountController,
      this.amount});

  final VoidCallback onSelectToken;
  final String dollarValue;
  final TradeToken token;
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
    widget.onAmountChanged?.call(_amountController.text);
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
                  widget.token.tokenName.isNotEmpty
                      ? _buildTokenIcon(widget.token)
                      : const SizedBox.shrink(),
                  SizedBox(width: 16.w),
                  widget.token.tokenName.isEmpty
                      ? _buildNotSelectTokenText()
                      : _buildSelectTokenText(),
                  SizedBox(width: 4.w),
                  SvgPicture.asset("assets/images/icons/chevron-down.svg")
                ],
              ),
            ),
            // Spacer(),
            SizedBox(width: 12.w),
            Expanded(
                child: GestureDetector(
              onTap: () {
                TradeStatusToastUtils.showNotSuppertedInputAmountToast();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildAmount(),
                  if (widget.dollarValue.isNotEmpty) _buildDollarValue()
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildAmount() {
    if (!widget.isEditable) {
      return _buildNotEditableAmount();
    }

    return BlocBuilder<TradeCubit, TradeState>(builder: (context, state) {
      // 同步 state.amount 到 _amountController
      if (widget.isSourceToken && state.amount != _amountController.text) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            final amount = CurrencyFormatter.formatWithFourDecimals(
                double.tryParse(state.amount) ?? 0);

            // 如果 amount 不为空，则设置 _amountController.text
            if (amount.isNotEmptyAndZeroValue) {
              _amountController.text = amount;
            }
          }
        });
      }

      return SizedBox(
        child: TextField(
          controller: _amountController,
          focusNode: _focusNode,
          onChanged: widget.onAmountChanged,
          textAlign: TextAlign.end,
          readOnly: !widget.isEditable,
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true), // 设置为数字输入框并允许输入小数
          style: TextStyle(
            fontSize: 20.sp,
            color: AppColors.textPrimary(context),
            fontWeight: FontWeight.w600,
          ),
          inputFormatters: InputFormatters.tradeAmountInputFormatters(
            maxDecimalPlaces: 4, // 代币通常支持8位小数
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
    });
  }

  Widget _buildNotEditableAmount() {
    Widget textWidget;

//  格式化不可编辑的数量，使用 缩写形式如果直接截断会导致 出现 0.0000的问题
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

// 构建输入框下面的
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
        StringFormatter.splitText(widget.token.tokenName, splitLength: 10),
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

  Widget _buildTokenIcon(TradeToken token) {
    return Stack(
      clipBehavior: Clip.none, // 不裁剪子元素
      children: [
        ClipOval(
          child: FeatureImage(
            url: ImageUtils.getImageProxyUrl(token.tokenAvatar),
            height: 48.h,
            width: 48.w,
            fit: BoxFit.cover,
            errorWidget: Container(
              width: 48.w,
              height: 48.h,
              color: AppColors.tokenPlaceholderColor,
              child: Center(
                child: Text(
                  token.tokenName.splitValueByCount(count: 1),
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -4,
          right: -12,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                shape: BoxShape.circle),
            child: ClipOval(
              child: FeatureImage(
                url: ImageUtils.getImageProxyUrl(token.chainLogo),
                height: 22.h,
                width: 22.w,
                fit: BoxFit.cover,
                errorWidget: Container(
                  width: 24.w,
                  height: 24.h,
                  color: AppColors.tokenPlaceholderColor,
                  child: Center(
                    child: Text(
                      token.tokenName.splitValueByCount(count: 1),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
