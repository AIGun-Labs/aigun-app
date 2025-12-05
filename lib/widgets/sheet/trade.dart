import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../gen/assets.gen.dart';
import '../../l10n/l10n.dart';
import '../../themes/colors.dart';
import '../../utils/format/numeric.dart';
import '../../utils/toast.dart';
import '../../utils/toast/trade_status_toast.dart';
import '../button/primary.dart';
import '../lotties/index.dart';

class TradeSheet extends StatefulWidget {
  const TradeSheet({super.key});

  @override
  TradeSheetState createState() => TradeSheetState();
}

class TradeSheetState extends State<TradeSheet> with WidgetsBindingObserver {
  bool isBuy = true;
  bool _isVisible = false;

  List<String> sellPercentValues = ['25', '50', '75', 'all'];
  Map<String, String> sellPercentMap = {
    '25': '25%',
    '50': '50',
    '75': '75',
    'all': '100',
  };

  List<String> buyPercentValues = ['0.2', '0.5', '1', '2'];

  late TextEditingController _sellPercentController;
  late TextEditingController _buyAmountController;
  final FocusNode _sellPercentFocusNode = FocusNode();

  Timer? _pollingStartTimer;

  double _currentVisibleFraction = 0;
  @override
  void initState() {
    super.initState();
    _sellPercentController = TextEditingController(text: '0');
    _buyAmountController = TextEditingController(text: null);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      TradeStatusToastUtils.dismissToast();
    }
  }

  double _calculateTextWidth(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text.isEmpty ? '0' : text,
        style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  void _handleSellPercentChange(String value) async {
    setState(() {
      if (value == 'all') {
        _sellPercentController.text = '100';
      } else {
        _sellPercentController.text = value;
      }
    });
  }

  void _handleBuyAmountChange(String value) {
    final formatted = NumericFormatter.formatToWei(value);

    final cursorPosition = _buyAmountController.selection.baseOffset;

    setState(() {
      _buyAmountController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: 0),
      );
    });
  }

  void _handleBuyAmountPercentChange(String value) {}

  @override
  void dispose() {}

  ToastController? _toastController;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('trade_sheet'),
      onVisibilityChanged: (visibilityInfo) {
        if (!mounted) return;
        final newFraction = visibilityInfo.visibleFraction;

        if (newFraction > 0.5 && _currentVisibleFraction <= 0.5) {
          _pollingStartTimer?.cancel();
          _isVisible = true;

          _pollingStartTimer = Timer(const Duration(milliseconds: 200), () {
            if (mounted && _currentVisibleFraction > 0.5) {}
          });
        } else if (newFraction < 0.1 && _currentVisibleFraction >= 0.1) {
          _pollingStartTimer?.cancel();
          _isVisible = false;

          TradeStatusToastUtils.dismissToast();
        }

        _currentVisibleFraction = newFraction;
      },
      child: SafeArea(
        child: AnimatedPadding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 6.h,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          duration: const Duration(milliseconds: 200),
          child: null,
        ),
      ),
    );
  }

  Widget _buildBuyButton(
    bool isBalanceEnough,
    bool isEnoughFee, {
    bool isQuoteLoading = false,
    bool isTradeLoading = false,
  }) {
    if (isBalanceEnough && isEnoughFee) {
      return _buildConfirmButton(
        text: S.of(context).buyNow,
        // backgroundColor: AppColors.buttonPrimary(context),
        textColor: Colors.black,
        isQuoteLoading: isQuoteLoading,
        isTradeLoading: isTradeLoading,
        onPressed: null,
      );
    } else if (!isBalanceEnough) {
      return _buildBalanceNotEnough();
    } else {
      return _buildConfirmButton(
        isEnoughFee: isEnoughFee,
        text: S.of(context).feeNotEnough,
        backgroundColor: AppColors.surface(context),
        textColor: AppColors.textQuaternary(context),
        onPressed: null,
      );
    }
  }

  Widget _buildBalanceNotEnough() {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            onPressed: () {},
            // isLoading: isLoading,
            width: double.infinity,
            backgroundColor: AppColors.buttonPrimary(context),
            textColor: Colors.black,
            fontSize: 16.sp,

            label: Text(
              "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: PrimaryButton(
            onPressed: () async {},
            // isLoading: isLoading,
            width: double.infinity,
            backgroundColor: AppColors.buttonPrimary(context),
            textColor: Colors.black,
            fontSize: 16.sp,
            label: Text(
              S.of(context).topUpTokenHint,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBuyWithOtherToken({required Function(String)? onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButton(text: '25%', key: '25', onPressed: onPressed),
        _buildButton(text: '50%', key: '50', onPressed: onPressed),
        _buildButton(text: '75%', key: '75', onPressed: onPressed),
        _buildButton(text: S.of(context).all, key: 'all', onPressed: onPressed),
      ],
    );
  }

  Widget _buildSellButtons({required Function(String)? onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButton(text: '25%', key: '25', onPressed: onPressed),
        _buildButton(text: '50%', key: '50', onPressed: onPressed),
        _buildButton(text: '75%', key: '75', onPressed: onPressed),
        _buildButton(text: S.of(context).all, key: 'all', onPressed: onPressed),
      ],
    );
  }

  Widget _buildBuyButtons({required Function(String)? onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButton(text: '0.2', key: '0.2', onPressed: onPressed),
        _buildButton(text: '0.5', key: '0.5', onPressed: onPressed),
        _buildButton(text: '1', key: '1', onPressed: onPressed),
        _buildButton(text: '2', key: '2', onPressed: onPressed),
      ],
    );
  }

  Widget _buildConfirmButton({
    String? text,
    required Function()? onPressed,
    Color? backgroundColor,
    Color? textColor,
    bool isQuoteLoading = false,
    bool isTradeLoading = false,
    bool isEnoughFee = false,
  }) {
    final icon = isQuoteLoading
        ? null
        : SvgPicture.asset(
            'assets/images/icons/aim-outline.svg',
            colorFilter: ColorFilter.mode(
              textColor ?? Colors.black,
              BlendMode.srcIn,
            ),
          );

    final Widget content = isQuoteLoading
        ? LottieAsset(
            const $AssetsLottieGen().aim,
            config: LottieConfig(
              width: 24.w,
              height: 24.w,
              repeat: true,
              animate: true,
            ),
          )
        : Text(
            text ?? S.of(context).sellNow,
            style: const TextStyle(fontWeight: FontWeight.bold),
          );

    return PrimaryButton(
      onPressed: isQuoteLoading || isTradeLoading ? null : onPressed,
      height: 50.h,
      width: double.infinity,
      backgroundColor: isQuoteLoading || isTradeLoading
          ? AppColors.quinary
          : backgroundColor ?? AppColors.buttonPrimary(context),
      textColor: isTradeLoading || isQuoteLoading
          ? AppColors.textQuaternary(context)
          : textColor ?? Colors.black,
      fontSize: 16,
      isLoading: isTradeLoading,
      // loading: const LoadingIndicator(
      //   size: 20,
      //   color: Colors.black,
      // ),
      icon: icon,
      label: content,
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
        ),
      ),
    );
  }
}
