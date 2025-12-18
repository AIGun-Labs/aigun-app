import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constant/count.dart';
import '../../../../cubits/trade/trade_state.dart' show TradeToken;
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/extensions/string.dart';
import '../../../../utils/format/currency.dart';
import '../../../../utils/format/input_formatters.dart';
import '../../../../utils/format/string.dart';
import '../../../../utils/image_utils.dart';
import '../../../../utils/numeric_utils.dart';
import '../../../../utils/toast/trade_status_toast.dart';
import '../../../../widgets/feature_image.dart';
import '../cubit/swap/swap_cubit.dart';
import '../cubit/swap/swap_state.dart';

/// Token 交换卡片组件
///
/// 显示代币信息和金额输入/展示
/// 使用 TradeToken 作为数据模型
class TokenSwapCard extends StatefulWidget {
  const TokenSwapCard({
    super.key,
    required this.onSelectToken,
    required this.dollarValue,
    required this.token,
    required this.isSourceToken,
    this.onAmountChanged,
    this.isEditable = false,
    this.amountController,
    this.amount,
  });

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
  }

  @override
  void didUpdateWidget(TokenSwapCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleControllerUpdate(oldWidget);
    _handleAmountUpdate(oldWidget);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _disposeController();
    super.dispose();
  }

  void _initializeController() {
    if (widget.amountController != null) {
      _amountController = widget.amountController!;
      _isControllerOwned = false;
    } else {
      _amountController = TextEditingController(text: widget.amount ?? '');
      _isControllerOwned = true;
    }
  }

  void _handleControllerUpdate(TokenSwapCard oldWidget) {
    if (widget.amountController != oldWidget.amountController) {
      _disposeController();
      _initializeController();
    }
  }

  void _handleAmountUpdate(TokenSwapCard oldWidget) {
    if (widget.amount != oldWidget.amount &&
        _amountController.text != widget.amount) {
      _amountController.text = widget.amount ?? '';
    }
  }

  void _disposeController() {
    if (_isControllerOwned) {
      _amountController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 6.0.h),
      child: SizedBox(
        height: 70.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _TokenSelector(token: widget.token, onTap: widget.onSelectToken),
            SizedBox(width: 12.w),
            Expanded(
              child: _AmountSection(
                token: widget.token,
                dollarValue: widget.dollarValue,
                isEditable: widget.isEditable,
                isSourceToken: widget.isSourceToken,
                amountController: _amountController,
                focusNode: _focusNode,
                onAmountChanged: widget.onAmountChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Token 选择器部分
class _TokenSelector extends StatelessWidget {
  const _TokenSelector({required this.token, required this.onTap});

  final TradeToken token;
  final VoidCallback onTap;

  bool get _hasSelectedToken => token.tokenName.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          if (_hasSelectedToken) _TokenIcon(token: token),
          SizedBox(width: 16.w),
          _TokenName(
            tokenName: token.tokenName,
            hasSelectedToken: _hasSelectedToken,
          ),
          SizedBox(width: 4.w),
          SvgPicture.asset(Assets.images.icons.chevronDown),
        ],
      ),
    );
  }
}

/// Token 图标组件
class _TokenIcon extends StatelessWidget {
  const _TokenIcon({required this.token});

  final TradeToken token;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [_buildMainIcon(), _buildChainBadge()],
    );
  }

  Widget _buildMainIcon() {
    return ClipOval(
      child: FeatureImage(
        url: ImageUtils.getImageProxyUrl(token.tokenAvatar),
        height: 48.w,
        width: 48.w,
        fit: BoxFit.cover,
        errorWidget: _TokenPlaceholder(
          size: 48,
          fontSize: 24,
          text: token.tokenName,
        ),
      ),
    );
  }

  Widget _buildChainBadge() {
    return Positioned(
      bottom: -4,
      right: -12,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: FeatureImage(
            url: ImageUtils.getImageProxyUrl(token.chainLogo),
            height: 22.w,
            width: 22.w,
            fit: BoxFit.cover,
            errorWidget: _TokenPlaceholder(
              size: 24,
              fontSize: 12,
              text: token.tokenName,
            ),
          ),
        ),
      ),
    );
  }
}

/// Token 占位符组件
class _TokenPlaceholder extends StatelessWidget {
  const _TokenPlaceholder({
    required this.size,
    required this.fontSize,
    required this.text,
  });

  final double size;
  final double fontSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      color: AppColors.tokenPlaceholderColor,
      child: Center(
        child: Text(
          text.splitValueByCount(count: 1),
          style: TextStyle(
            fontSize: fontSize.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// Token 名称组件
class _TokenName extends StatelessWidget {
  const _TokenName({required this.tokenName, required this.hasSelectedToken});

  final String tokenName;
  final bool hasSelectedToken;

  @override
  Widget build(BuildContext context) {
    final displayText = hasSelectedToken
        ? StringFormatter.splitText(tokenName, splitLength: 10)
        : StringFormatter.splitText(S.of(context).selectToken, splitLength: 10);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        displayText,
        style: TextStyle(
          fontSize: hasSelectedToken ? 22.w : 16.w,
          fontWeight: hasSelectedToken ? FontWeight.w700 : FontWeight.normal,
        ),
      ),
    );
  }
}

/// 金额部分组件
class _AmountSection extends StatelessWidget {
  const _AmountSection({
    required this.token,
    required this.dollarValue,
    required this.isEditable,
    required this.isSourceToken,
    required this.amountController,
    required this.focusNode,
    this.onAmountChanged,
  });

  final TradeToken token;
  final String dollarValue;
  final bool isEditable;
  final bool isSourceToken;
  final TextEditingController amountController;
  final FocusNode focusNode;
  final ValueChanged<String>? onAmountChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: TradeStatusToastUtils.showNotSupportedInputAmountToast,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildAmountWidget(),
          if (dollarValue.isNotEmpty) _DollarValue(dollarValue: dollarValue),
        ],
      ),
    );
  }

  Widget _buildAmountWidget() {
    if (!isEditable) {
      return _DisplayAmount(amountController: amountController);
    }
    return _EditableAmount(
      controller: amountController,
      focusNode: focusNode,
      onChanged: onAmountChanged,
      isSourceToken: isSourceToken,
    );
  }
}

/// 可编辑金额输入框
class _EditableAmount extends StatelessWidget {
  const _EditableAmount({
    required this.controller,
    required this.focusNode,
    required this.isSourceToken,
    this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isSourceToken;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SwapCubit, SwapState>(
      listenWhen: (previous, current) =>
          previous.amount != current.amount && isSourceToken,
      listener: (context, state) => _syncControllerWithState(state),
      child: _buildTextField(context),
    );
  }

  void _syncControllerWithState(SwapState state) {
    if (!isSourceToken || state.amount == controller.text) return;

    final amount = NumericUtils.truncateDecimals(
      double.tryParse(state.amount) ?? 0,
      NumericConstants.twelve,
    );

    controller.text = amount.isNotEmptyAndZeroValue ? amount : '';
  }

  Widget _buildTextField(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      textAlign: TextAlign.end,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: TextStyle(
        fontSize: 20.sp,
        color: AppColors.textPrimary(context),
        fontWeight: FontWeight.w600,
      ),
      inputFormatters: InputFormatters.tradeAmountInputFormatters(
        maxDecimalPlaces: NumericConstants.twelve,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: '0.0',
        hintStyle: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textQuaternary(context),
        ),
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

/// 只读金额显示
class _DisplayAmount extends StatelessWidget {
  const _DisplayAmount({required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    final hasValue = amountController.text.isNotEmptyAndZeroValue;
    final formattedAmount = CurrencyFormatter.abbreviateTokenPrice(
      double.tryParse(amountController.text) ?? 0,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        hasValue ? '≈$formattedAmount' : '0.0',
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: hasValue
              ? AppColors.textPrimary(context)
              : AppColors.textQuaternary(context),
        ),
      ),
    );
  }
}

/// 美元价值显示
class _DollarValue extends StatelessWidget {
  const _DollarValue({required this.dollarValue});

  final String dollarValue;

  @override
  Widget build(BuildContext context) {
    final value = Decimal.tryParse(dollarValue);
    if (value == null || value.toDouble() == 0) {
      return const SizedBox.shrink();
    }

    final formatted = CurrencyFormatter.abbreviateTokenPriceWithSymbol(
      double.tryParse(dollarValue) ?? 0,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        formatted,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.textSecondary(context),
        ),
      ),
    );
  }
}
