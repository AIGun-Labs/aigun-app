import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../themes/themes.dart';
import '../../../../../utils/extensions/string.dart';
import '../../../../../utils/format/currency.dart';
import '../../../../../utils/format/input_formatters.dart';
import '../../../../../utils/format/string.dart';
import '../../../../../utils/image_utils.dart';
import '../../../../../utils/toast/trade_status_toast.dart';
import '../../../../../widgets/feature_image.dart';
import '../../cubit/swap/swap_cubit.dart';
import '../../cubit/swap/swap_state.dart';
import 'token_card_config.dart';

/// Token 卡片组件
///
/// 显示代币信息和金额输入/展示
/// 使用配置模式管理状态
class TokenCard extends StatefulWidget {
  const TokenCard({
    super.key,
    required this.config,
    required this.interaction,
  });

  /// Token 显示配置
  final TokenCardConfig config;

  /// 交互配置
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

    // 控制器变化时重新初始化
    if (widget.interaction.amountController !=
        oldWidget.interaction.amountController) {
      _disposeController();
      _initializeController();
    }

    // 金额变化时更新控制器
    if (widget.config.amount != oldWidget.config.amount &&
        _amountController.text != widget.config.amount) {
      _amountController.text = widget.config.amount ?? '';
    }
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

  void _disposeController() {
    if (_isControllerOwned) {
      _amountController.dispose();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _disposeController();
    super.dispose();
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
  const _TokenSelector({
    required this.config,
    this.onTap,
  });

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
            )
          else
            const SizedBox.shrink(),
          SizedBox(width: 16.w),
          _TokenName(
            tokenName: config.tokenName,
            hasSelectedToken: config.hasSelectedToken,
          ),
          SizedBox(width: 4.w),
          SvgPicture.asset('assets/images/icons/chevron-down.svg'),
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
      children: [
        ClipOval(
          child: FeatureImage(
            url: ImageUtils.getImageProxyUrl(tokenAvatar),
            height: 48.h,
            width: 48.w,
            fit: BoxFit.cover,
            errorWidget: _buildPlaceholder(48, 24),
          ),
        ),
        Positioned(
          bottom: -4,
          right: -12,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: FeatureImage(
                url: ImageUtils.getImageProxyUrl(chainLogo),
                height: 22.h,
                width: 22.w,
                fit: BoxFit.cover,
                errorWidget: _buildPlaceholder(24, 12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(double size, double fontSize) {
    return Container(
      width: size.w,
      height: size.h,
      color: AppColors.tokenPlaceholderColor,
      child: Center(
        child: Text(
          tokenName.splitValueByCount(count: 1),
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
  const _TokenName({
    required this.tokenName,
    required this.hasSelectedToken,
  });

  final String tokenName;
  final bool hasSelectedToken;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        hasSelectedToken
            ? StringFormatter.splitText(tokenName, splitLength: 10)
            : StringFormatter.splitText(
                S.of(context).selectToken,
                splitLength: 10,
              ),
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
      onTap: () {
        if (!interaction.isEditable) {
          TradeStatusToastUtils.showNotSupportedInputAmountToast();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          interaction.isEditable
              ? _EditableAmount(
                  controller: amountController,
                  focusNode: focusNode,
                  onChanged: interaction.onAmountChanged,
                  isSourceToken: interaction.isSourceToken,
                )
              : _DisplayAmount(amountController: amountController),
          if (config.dollarValue.isNotEmpty)
            _DollarValue(dollarValue: config.dollarValue),
        ],
      ),
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
    return BlocBuilder<SwapCubit, SwapState>(
      buildWhen: (previous, current) =>
          previous.amount != current.amount && isSourceToken,
      builder: (context, state) {
        // 同步状态到控制器
        if (isSourceToken && state.amount != controller.text) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final amount = CurrencyFormatter.abbreviateTokenPrice(
              double.tryParse(state.amount) ?? 0,
              fixedDecimals: 4,
            );
            controller.text = amount.isNotEmptyAndZeroValue ? amount : '';
          });
        }

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
            maxDecimalPlaces: 4,
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
      },
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
