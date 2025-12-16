import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constant/count.dart';
import '../../../../../core/utils/calculator.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../themes/themes.dart';
import '../../../../../utils/extensions/string.dart';
import '../../../../../utils/format/currency.dart';
import '../../../../../utils/format/input_formatters.dart';
import '../../../../../utils/format/string.dart';
import '../../../../../utils/image_utils.dart';
import '../../../../../utils/toast/trade_status_toast.dart';
import '../../../../../widgets/feature_image.dart';
import '../../../../../widgets/skeleton/widgets/text.dart';
import '../../cubit/swap/swap_cubit.dart';
import '../../cubit/swap/swap_state.dart';
import 'token_card_config.dart';

/// Token 卡片组件
///
/// 显示代币信息和金额输入/展示
/// 使用配置模式管理状态，遵循单一职责原则
class TokenCard extends StatefulWidget {
  const TokenCard({super.key, required this.config, required this.interaction});

  final TokenCardConfig config;
  final TokenCardInteraction interaction;

  @override
  State<TokenCard> createState() => _TokenCardState();
}

class _TokenCardState extends State<TokenCard> {
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
  void didUpdateWidget(TokenCard oldWidget) {
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
    final externalController = widget.interaction.amountController;
    if (externalController != null) {
      _amountController = externalController;
      _isControllerOwned = false;
    } else {
      _amountController = TextEditingController(
        text: widget.config.amount ?? '',
      );
      _isControllerOwned = true;
    }
  }

  void _handleControllerUpdate(TokenCard oldWidget) {
    if (widget.interaction.amountController !=
        oldWidget.interaction.amountController) {
      _disposeController();
      _initializeController();
    }
  }

  void _handleAmountUpdate(TokenCard oldWidget) {
    if (widget.config.amount != oldWidget.config.amount &&
        _amountController.text != widget.config.amount) {
      _amountController.text = widget.config.amount ?? '';
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
            _TokenSelector(
              config: widget.config,
              onTap: widget.interaction.onSelectToken,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _AmountSection(
                config: widget.config,
                interaction: widget.interaction,
                amountController: _amountController,
                focusNode: _focusNode,
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
  const _TokenSelector({required this.config, this.onTap});

  final TokenCardConfig config;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          if (config.hasSelectedToken)
            _TokenIcon(
              tokenAvatar: config.tokenAvatar,
              chainLogo: config.chainLogo,
              tokenName: config.tokenName,
            ),
          SizedBox(width: 16.w),
          _TokenName(
            tokenName: config.tokenName,
            hasSelectedToken: config.hasSelectedToken,
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
  const _TokenIcon({
    required this.tokenAvatar,
    required this.chainLogo,
    required this.tokenName,
  });

  final String tokenAvatar;
  final String chainLogo;
  final String tokenName;

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
        url: ImageUtils.getImageProxyUrl(tokenAvatar),
        height: 48.w,
        width: 48.w,
        fit: BoxFit.cover,
        errorWidget: _TokenPlaceholder(size: 48, fontSize: 24, text: tokenName),
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
            url: ImageUtils.getImageProxyUrl(chainLogo),
            height: 22.w,
            width: 22.w,
            fit: BoxFit.cover,
            errorWidget: _TokenPlaceholder(
              size: 24,
              fontSize: 12,
              text: tokenName,
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
    required this.config,
    required this.interaction,
    required this.amountController,
    required this.focusNode,
  });

  final TokenCardConfig config;
  final TokenCardInteraction interaction;
  final TextEditingController amountController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: interaction.isEditable
          ? null
          : TradeStatusToastUtils.showNotSupportedInputAmountToast,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildAmountWidget(),
          _DollarValue(dollarValue: config.dollarValue),
        ],
      ),
    );
  }

  Widget _buildAmountWidget() {
    if (interaction.isEditable) {
      return _EditableAmount(
        controller: amountController,
        focusNode: focusNode,
        onChanged: interaction.onAmountChanged,
        isSourceToken: interaction.isSourceToken,
      );
    }
    return _DisplayAmount(amountController: amountController);
  }
}

/// 可编辑金额输入框
class _EditableAmount extends StatefulWidget {
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
  State<_EditableAmount> createState() => _EditableAmountState();
}

class _EditableAmountState extends State<_EditableAmount> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => BlocListener<SwapCubit, SwapState>(
        listenWhen: (previous, current) =>
            previous.amount != current.amount && widget.isSourceToken,
        listener: (context, state) => _syncControllerWithState(state),
        // child: TextField(
        //   controller: widget.controller,
        //   focusNode: widget.focusNode,
        //   onChanged: widget.onChanged,
        //   textAlign: TextAlign.end,
        //   keyboardType: const TextInputType.numberWithOptions(decimal: true),
        //   style: TextStyle(
        //     fontSize: _fontSize,
        //     color: AppColors.textPrimary(context),
        //     fontWeight: FontWeight.w600,
        //   ),
        //   inputFormatters: InputFormatters.tradeAmountInputFormatters(
        //     maxDecimalPlaces: NumericConstants.sixteen,
        //   ),
        //   decoration: InputDecoration(
        //     border: InputBorder.none,
        //     hintText: '0.0',
        //     hintStyle: TextStyle(
        //       fontSize: 22.sp,
        //       fontWeight: FontWeight.w700,
        //       color: AppColors.textQuaternary(context),
        //     ),
        //     isDense: true,
        //     contentPadding: EdgeInsets.zero,
        //   ),
        // ),
        child: AutoSizeTextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          onChanged: widget.onChanged,
          textAlign: TextAlign.end,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: TextStyle(
            fontSize: 22.sp,
            color: AppColors.textPrimary(context),
            fontWeight: FontWeight.w600,
          ),
          inputFormatters: InputFormatters.tradeAmountInputFormatters(
            maxDecimalPlaces: NumericConstants.sixteen,
          ),
          minFontSize: 16,
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
        ),
      ),
    );
  }

  void _syncControllerWithState(SwapState state) {
    if (!widget.isSourceToken || state.amount == widget.controller.text) return;

    final amount = Calculator.truncate(state.amount, NumericConstants.sixteen);
    widget.controller.text = amount.isNotEmptyAndZeroValue ? amount : '';
  }
}

/// 只读金额显示
class _DisplayAmount extends StatelessWidget {
  const _DisplayAmount({required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    final hasValue = amountController.text.isNotEmptyAndZeroValue;

    /// 截断小数位数 6 位
    final formattedAmount = CurrencyFormatter.abbreviateTokenPrice(
      double.tryParse(amountController.text) ?? 0,
      fixedDecimals: NumericConstants.six,
    );

    return AutoSizeText(
      hasValue ? '≈$formattedAmount' : '0.0',
      maxLines: 1,
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: hasValue
            ? AppColors.textPrimary(context)
            : AppColors.textQuaternary(context),
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
    if (!dollarValue.isNotEmptyAndZeroValue) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<SwapCubit, SwapState>(
      builder: (context, state) {
        final height = 20.sp;

        return SizedBox(
          height: height,
          child: state.quoteStatus.maybeWhen(
            orElse: SizedBox.shrink,
            loading: () => TextSkeleton(width: 100.w, height: height),
            success: (_) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                // 使用传进来的 dollar 而不是 quote
                CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                  double.tryParse(dollarValue) ?? 0,
                ),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textSecondary(context),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
