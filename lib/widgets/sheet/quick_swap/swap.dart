import 'dart:async';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constant/count.dart';
import '../../../core/service_locator.dart';
import '../../../core/utils/calculator.dart';
import '../../../core/utils/token_handler.dart';
import '../../../cubits/index.dart';
import '../../../cubits/quick_trade/quick_trade_state.dart' as quick_trade;
import '../../../cubits/sound_effect/sound_effect_cubit.dart';
import '../../../cubits/trade/trade_state.dart';
import '../../../data/models/transfer/index.dart';
import '../../../features/chain/presentation/cubit/supported_chains_cubit.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/presentation/extensions/string_number_extension.dart';
import '../../../shared/trade/trade_button_state.dart';
import '../../../themes/colors.dart';
import '../../../utils/clipboard.dart';
import '../../../utils/extensions/string.dart';
import '../../../utils/format/currency.dart';
import '../../../utils/format/index.dart';
import '../../../utils/format/input_formatters.dart';
import '../../../utils/format/numeric.dart';
import '../../../utils/image_utils.dart';
import '../../../utils/sheet/token_selector_sheet.dart';
import '../../../utils/toast.dart';
import '../../../utils/toast/trade_status_toast.dart';
import '../../avatar/widget/token.dart';
import '../../button/primary.dart';
import '../../feature_image.dart';
import '../../setting/trade_row.dart';
import '../../token/models/token.dart';
import 'widgets/quick_swap_button.dart';
import 'widgets/select_buttons.dart';
import 'widgets/select_from_token.dart';

class TradeSheet extends StatefulWidget {
  const TradeSheet({super.key});

  @override
  TradeSheetState createState() => TradeSheetState();
}

class TradeSheetState extends State<TradeSheet> with WidgetsBindingObserver {
  bool isBuy = true;
  bool _isVisible = false;

  late QuickTradeCubit _quickTradeCubit;
  late BalanceCubit _balanceCubit;

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

  // 添加定时器用于延迟启动轮询
  Timer? _pollingStartTimer;
  // 记录当前可见性状态
  double _currentVisibleFraction = 0;
  @override
  void initState() {
    super.initState();
    _sellPercentController = TextEditingController(text: '');
    _buyAmountController = TextEditingController(text: null);
    WidgetsBinding.instance.addObserver(this);
    _quickTradeCubit = BlocProvider.of<QuickTradeCubit>(context);
    _balanceCubit = BlocProvider.of<BalanceCubit>(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // App 失去焦点时关闭 Toast
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
        _quickTradeCubit.updateSellPercent('100');
      } else {
        _sellPercentController.text = value;
        _quickTradeCubit.updateSellPercent(value);
      }
    });
  }

  void _handleBuyAmountChange(String value) {
    // final formatted = value.toDouble().comma(
    //   context,
    //   fractionDigits: NumericConstants.four,
    // );
    final formatted = NumericFormatter.formatToWei(value);
    // 获取当前光标位置

    final cursorPosition = _buyAmountController.selection.baseOffset;

    setState(() {
      // 使用 TextEditingValue 来保留光标位置
      _buyAmountController.value = TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(
          offset: _calculateNewCursorPosition(value, formatted, cursorPosition),
        ),
      );

      BlocProvider.of<QuickTradeCubit>(context).updateBuyAmount(value);
    });
  }

  int _calculateNewCursorPosition(
    String oldValue,
    String newValue,
    int oldPosition,
  ) {
    // 如果位置无效，返回新文本长度
    if (oldPosition < 0 || oldPosition > oldValue.length) {
      return newValue.length;
    }

    // 移除旧值中的逗号，计算实际的数字字符数量
    final oldWithoutCommas = oldValue.replaceAll(',', '');
    final newWithoutCommas = newValue.replaceAll(',', '');

    // 如果数字部分没有变化，保持相对位置
    if (oldWithoutCommas == newWithoutCommas) {
      // 计算光标前有多少个非逗号字符
      int nonCommaCharsBeforeCursor = 0;
      for (int i = 0; i < oldPosition && i < oldValue.length; i++) {
        if (oldValue[i] != ',') {
          nonCommaCharsBeforeCursor++;
        }
      }

      // 在新文本中找到对应的位置
      int newPosition = 0;
      int nonCommaCount = 0;
      for (int i = 0; i < newValue.length; i++) {
        if (newValue[i] != ',') {
          nonCommaCount++;
          if (nonCommaCount > nonCommaCharsBeforeCursor) {
            newPosition = i;
            break;
          }
        }
        newPosition = i + 1;
      }

      return newPosition;
    }

    // 如果数字发生了变化（例如删除或添加字符），将光标放在末尾
    return newValue.length;
  }

  void _handleBuyAmountPercentChange({
    required String balance,
    required String value,
  }) {
    final percent = value == 'all' ? 100 : double.tryParse(value) ?? 0;

    _handleBuyAmountChange(
      Calculator.multiplyTwo(
        balance,
        Calculator.divideTwo(percent.toString(), 100),
        precision: NumericConstants.twelve,
      ).removeTrailingZeros(maxDecimals: NumericConstants.twelve),
    );
  }

  @override
  void dispose() {
    // 取消轮询启动定时器
    _pollingStartTimer?.cancel();
    TradeStatusToastUtils.dismissToast();
    _sellPercentController.dispose();
    _buyAmountController.dispose();
    _sellPercentFocusNode.dispose();
    super.dispose();
  }

  ToastController? _toastController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuickTradeCubit, QuickTradeState>(
      listenWhen: (previous, current) =>
          previous.buyTokenStatus != current.buyTokenStatus ||
          previous.sellTokenStatus != current.sellTokenStatus,
      listener: (_, state) {
        if (!_isVisible) return;
        state.buyTokenStatus.whenOrNull(
          loading: () {
            if (mounted) {
              _toastController = TradeStatusToastUtils.showTrainingToast();
            }
          },
          success: (success) async {
            if (mounted) {
              _toastController?.dismiss();

              TradeStatusToastUtils.showSuccessToast(
                message: S.of(context).transactionSuccess,
                txHash: success.txHash ?? '',
                amount: CurrencyFormatter.abbreviateTokenPrice(
                  // TODO 后面在优化成使用 extesion
                  Calculator.fromAtomicUnits(
                    state.buyQuote?.outAmount ?? '0',
                    state.selectedToken?.decimals ?? 0,
                  ).toDouble(),
                ),
                symbol: state.selectedToken?.symbol ?? '',
                txUrl: success.txHash ?? '',
              );
            }
          },
          failure: (failure) {
            if (mounted) {
              _toastController?.dismiss();
            }
          },
        );
        state.sellTokenStatus.whenOrNull(
          loading: () {
            if (mounted) {
              _toastController = TradeStatusToastUtils.showTrainingToast();
            }
          },
          success: (success) {
            if (mounted) {
              _toastController?.dismiss();

              TradeStatusToastUtils.showSuccessToast(
                message: S.of(context).transactionSuccess,
                txHash: success.txHash ?? '',
                amount: CurrencyFormatter.abbreviateTokenPrice(
                  Calculator.fromAtomicUnits(
                    state.sellQuote?.outAmount ?? '0',
                    state.fromToken?.decimals ?? 0,
                  ).toDouble(),
                ),
                symbol: state.selectedToken?.nativeSymbol ?? '',
                txUrl: success.txHash ?? '',
              );
            }
          },
          failure: (failure) {
            if (mounted) {
              _toastController?.dismiss();
              // Toast 已在 Cubit 中显示，这里不再重复显示
            }
          },
        );
      },
      builder: (context, state) {
        return VisibilityDetector(
          key: const Key('trade_sheet'),
          onVisibilityChanged: (visibilityInfo) {
            if (!mounted) return;
            final newFraction = visibilityInfo.visibleFraction;

            // 添加阈值防止快速启动/停止
            if (newFraction > 0.5 && _currentVisibleFraction <= 0.5) {
              // 面板变为可见（超过50%）
              _pollingStartTimer?.cancel();
              _isVisible = true;

              // 延迟启动轮询，确保面板完全打开
              _pollingStartTimer = Timer(const Duration(milliseconds: 200), () {
                if (mounted && _currentVisibleFraction > 0.5) {
                  _quickTradeCubit.startPollingQuote();
                  _balanceCubit.startPollingBalance();
                }
              });
            } else if (newFraction < 0.1 && _currentVisibleFraction >= 0.1) {
              // 面板变为不可见（低于10%）
              _pollingStartTimer?.cancel();
              _isVisible = false;

              // 立即停止轮询
              _quickTradeCubit.stopPollingQuote();
              _balanceCubit.stopPollingBalance();
              TradeStatusToastUtils.dismissToast();
            }

            // 更新当前可见性状态
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
              child: SingleChildScrollView(
                child: _buildTradeSheetContent(state),
              ),
            ),
          ),
        );
      },
    );
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
            decoration: BoxDecoration(color: AppColors.border(context)),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarToken(
              avatar: state.selectedToken?.tokenAvatar ?? '',
              chainLogo: state.selectedToken?.chainLogo ?? '',
              tokenName: state.selectedToken?.tokenName ?? '',
              chainName: state.selectedToken?.chainName ?? '',
              width: 50.w,
              height: 50.w,
              chainLogoWidth: 20.w,
              chainLogoHeight: 20.w,
              right: -10.w,
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      ClipboardUtils.copy(
                        state.selectedToken?.tokenName ?? '',
                      ).then((_) {
                        if (!context.mounted) return;
                        ToastUtils.showCenterToast(
                          context,
                          S.of(context).copySuccess,
                        );
                      });
                    },
                    child: Text(
                      state.selectedToken?.symbol ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textPrimary(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  4.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      ClipboardUtils.copy(
                        state.selectedToken?.address ?? '',
                      ).then((_) {
                        if (!context.mounted) return;
                        ToastUtils.showCenterToast(
                          context,
                          S.of(context).copySuccess,
                        );
                      });
                    },
                    child: Text(
                      AddressFormatter.formatAddress(
                        state.selectedToken?.address ?? '',
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textTertiary(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 18.h),

        // 买卖切换按钮
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 33.w,
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
                                : Colors.transparent,
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            state.mode == QuickTradeMode.buy
                                ? Colors.black
                                : AppColors.textTertiary(context),
                          ),
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          // 更新模式为买入
                          TradeStatusToastUtils.dismissToast();
                          _quickTradeCubit.updateMode(QuickTradeMode.buy);
                        },
                        child: Text(
                          S.of(context).buy,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: state.mode == QuickTradeMode.buy
                                ? AppColors.textPrimary(context)
                                : AppColors.textTertiary(context),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 69.w,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            state.mode == QuickTradeMode.sell
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            state.mode == QuickTradeMode.sell
                                ? Colors.white
                                : AppColors.textTertiary(context),
                          ),
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          // 更新模式为卖出
                          TradeStatusToastUtils.dismissToast();
                          _quickTradeCubit.updateMode(QuickTradeMode.sell);
                        },
                        child: Text(
                          S.of(context).sell,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: state.mode == QuickTradeMode.sell
                                ? AppColors.textPrimary(context)
                                : AppColors.textTertiary(context),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SelectFromTokenButton(
              mode: state.mode,
              onTap: () async {
                final tokens =
                    BlocProvider.of<BalanceCubit>(
                      context,
                    ).state.balances?.tokens ??
                    [];

                final supportedChains = BlocProvider.of<SupportedChainsCubit>(
                  context,
                ).state.networkIds;
                final filteredTokens = TokenHandler.excludeUnsupportedToken(
                  tokens.map(Token.fromBalance).toList(),
                  supportedChains,
                );

                final selectedToken = await showTokenSelectorSheet(
                  context,
                  filteredTokens,
                  title: S.of(context).selectTradeToken,
                  isSearch: false,
                  isShowRight: true,
                  subTitle: S.of(context).crossChainTrade,
                  leading: const SizedBox.shrink(),
                  suffix: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      TradeStatusToastUtils.dismissToast();
                    },

                    child: Icon(
                      Icons.close,
                      size: 24.sp,
                      color: AppColors.foreground(context),
                    ),
                  ),
                );

                if (selectedToken != null && mounted) {
                  _quickTradeCubit.updateFromToken(selectedToken);
                }
              },
            ),
          ],
        ),

        if (state.mode.name == QuickTradeMode.buy.name) ...[
          _buildBuy(isBalanceEnough),
          SizedBox(height: 12.h),
          BlocSelector<QuickTradeCubit, QuickTradeState, TransferQuote?>(
            selector: (state) => state.buyQuote,
            builder: (context, buyQuote) =>
                SettingTradeRow(gasFee: buyQuote?.gasFee ?? '0'),
          ),
        ] else ...[
          _buildSell(isBalanceEnough),
          SizedBox(height: 12.h),
          BlocSelector<QuickTradeCubit, QuickTradeState, TransferQuote?>(
            selector: (state) => state.sellQuote,
            builder: (context, sellQuote) =>
                SettingTradeRow(gasFee: sellQuote?.gasFee ?? '0'),
          ),
        ],
      ],
    );
  }

  Widget _buildSell(bool isBalanceEnough) {
    return BlocBuilder<QuickTradeCubit, QuickTradeState>(
      buildWhen: (previous, current) =>
          previous.fromToken != current.fromToken ||
          previous.selectedToken != current.selectedToken ||
          previous.sellQuote != current.sellQuote ||
          previous.sellQuoteStatus != current.sellQuoteStatus ||
          previous.sellTokenStatus != current.sellTokenStatus ||
          previous.sellPercent != current.sellPercent,
      builder: (context, state) {
        final quickTradeCubit = _quickTradeCubit;
        final buttonState = quickTradeCubit.sellButtonState;

        // 检查 sellPercent 是否为空或无效
        final sellPercent = state.sellPercent.isEmpty ? '0' : state.sellPercent;

        // 计算卖出金额：如果是 100%，直接使用余额，避免浮点数精度问题
        final String sellAmount;
        if (sellPercent == '100' || sellPercent == 'all') {
          sellAmount = state.selectedToken?.balance ?? '0';
        } else {
          // 先转换为百分比
          final sellPercentValue = sellPercent.toPercentage();
          // 两数相乘得到结果
          sellAmount = sellPercentValue.safeMultiply(
            state.selectedToken?.balance ?? '0',
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 64.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: Offset(
                          0,
                          sellAmount.isNotEmptyAndZeroValue ? 8.h : 0,
                        ),
                        child: SizedBox(
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
                                  // 完成输入时保持当前值
                                  _sellPercentFocusNode.unfocus();
                                  _quickTradeCubit.updateSellPercent(
                                    _sellPercentController.text,
                                  );
                                },
                                onTap: () {
                                  if (_sellPercentController.text == '0') {
                                    _sellPercentController.clear();
                                  }
                                },
                                inputFormatters: [
                                  // 只允许输入整数
                                  FilteringTextInputFormatter.digitsOnly,
                                  TextInputFormatter.withFunction((
                                    oldValue,
                                    newValue,
                                  ) {
                                    // 如果输入为空，允许
                                    if (newValue.text.isEmpty) {
                                      return newValue;
                                    }
                                    // 转换为整数
                                    final int? value = int.tryParse(
                                      newValue.text,
                                    );
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
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '0',
                                  hintStyle: TextStyle(
                                    fontSize: 28.sp,
                                    color: AppColors.textQuaternary(context),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              // 测量层：透明的文本用于计算宽度
                              IgnorePointer(
                                child: Text(
                                  "${_sellPercentController.text.isEmpty ? "0" : _sellPercentController.text}%",
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Colors.transparent,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              // 显示层：只显示百分号，位置动态调整
                              Positioned(
                                left: _calculateTextWidth(
                                  _sellPercentController.text,
                                ),
                                child: IgnorePointer(
                                  child: Text(
                                    '%',
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      color: AppColors.textPrimary(context),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (sellAmount.isNotEmptyAndZeroValue && isBalanceEnough)
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "${CurrencyFormatter.abbreviateTokenPrice(double.parse(sellAmount.toString()))} ${state.selectedToken?.symbol ?? ""}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textTertiary(context),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          state.selectedToken?.symbol ?? '',
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textTertiary(context),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              // 'assets/images/icons/wallet-outline.svg',
                              width: 13.w,
                              height: 13.w,
                              Assets.images.icons.walletOutline,
                              colorFilter: ColorFilter.mode(
                                AppColors.textTertiary(context),
                                BlendMode.srcIn,
                              ),
                            ),
                            4.horizontalSpace,
                            Text(
                              "${CurrencyFormatter.abbreviateTokenPrice(double.tryParse(state.selectedToken?.balance ?? "0") ?? 0)} ${state.selectedToken?.symbol ?? ""}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textTertiary(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            8.verticalSpace,
            FastSellButtons(
              onPressed: (value) {
                _handleSellPercentChange(value);
                _sellPercentFocusNode.unfocus();
              },
            ),
            14.verticalSpace,
            // ✅ New unified button logic
            QuickSwapButton(
              buttonState: buttonState,
              defaultLabel: S.of(context).sellNow,
              onPressed: buttonState.isEnabled
                  ? () {
                      BlocProvider.of<SoundEffectCubit>(context).playGunLoad();
                      quickTradeCubit.sellToken(context);
                    }
                  : null,
            ),
          ],
        );
      },
    );
  }

  // 买入输入行
  Widget _buildBuy(bool isBalanceEnough) {
    return BlocBuilder<QuickTradeCubit, QuickTradeState>(
      buildWhen: (previous, current) =>
          previous.fromToken != current.fromToken ||
          previous.isNativeToken != current.isNativeToken ||
          previous.buyQuoteStatus != current.buyQuoteStatus ||
          previous.buyQuote != current.buyQuote ||
          previous.buyTokenStatus != current.buyTokenStatus ||
          previous.buyAmount != current.buyAmount,
      builder: (context, state) {
        // ✅ Get computed button state
        final buttonState = _quickTradeCubit.buyButtonState;

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            18.verticalSpace,
            SizedBox(
              height: 46.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AutoSizeTextField(
                      controller: _buyAmountController,
                      onChanged: _handleBuyAmountChange,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textAlign: TextAlign.start,
                      enableInteractiveSelection: true,
                      inputFormatters:
                          InputFormatters.tradeAmountInputFormatters(
                            maxDecimalPlaces: NumericConstants.sixteen,
                          ),
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: AppColors.textPrimary(context),
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: '0.0',
                        hintStyle: TextStyle(
                          fontSize: 28.sp,
                          color: AppColors.textQuaternary(context),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  6.horizontalSpace,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          if (state.fromToken?.tokenAvatar.isNotEmpty ?? false)
                            ClipOval(
                              child: FeatureImage(
                                url: ImageUtils.getImageProxyUrl(
                                  state.fromToken?.tokenAvatar,
                                ),
                                width: 16.w,
                                height: 16.w,
                                fit: BoxFit.cover,
                                errorWidget: Container(
                                  color: Colors.grey[200],
                                  height: 16.w,
                                  width: 16.w,
                                ),
                              ),
                            ),
                          4.horizontalSpace,
                          Text(
                            state.fromToken?.symbol ?? '',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textTertiary(context),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            // 'assets/images/icons/wallet-outline.svg',
                            Assets.images.icons.walletOutline,
                            width: 13.w,
                            height: 13.w,
                            colorFilter: ColorFilter.mode(
                              AppColors.textTertiary(context),
                              BlendMode.srcIn,
                            ),
                          ),
                          4.horizontalSpace,
                          Text(
                            "${CurrencyFormatter.abbreviateTokenPrice(double.parse(state.fromToken?.balance ?? "0"))} ${state.fromToken?.symbol ?? ""}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textTertiary(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // SizedBox(height: 8.h),
            8.verticalSpace,
            state.isNativeToken
                ? FastBuyButtons(
                    onPressed: (value) {
                      _handleBuyAmountChange(value);
                    },
                  )
                : FastSellButtons(
                    onPressed: (value) {
                      _handleBuyAmountPercentChange(
                        balance:
                            _quickTradeCubit.state.fromToken?.balance ?? '0',
                        value: value,
                      );
                    },
                  ),
            // ✅ Handle insufficient balance case specially (shows hint + special button)
            buttonState.maybeWhen(
              disabled: (reason) {
                return reason.maybeWhen(
                  insufficientBalance: (_) => Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 8.w),
                        child: Text(
                          S
                              .of(context)
                              .balanceNotEnoughHint(
                                state.fromToken?.symbol ?? '',
                              ),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                      _buildBalanceNotEnough(),
                    ],
                  ),
                  orElse: () => Column(
                    children: [
                      14.verticalSpace,
                      QuickSwapButton(
                        buttonState: buttonState,
                        defaultLabel: S.of(context).buyNow,
                        onPressed: null,
                      ),
                    ],
                  ),
                );
              },
              orElse: () => Column(
                children: [
                  14.verticalSpace,
                  QuickSwapButton(
                    buttonState: buttonState,
                    defaultLabel: S.of(context).buyNow,
                    onPressed: buttonState.isEnabled
                        ? () {
                            BlocProvider.of<SoundEffectCubit>(
                              context,
                            ).playGunLoad();
                            _quickTradeCubit.buyToken(context);
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBalanceNotEnough() {
    return BlocBuilder<QuickTradeCubit, QuickTradeState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: PrimaryButton(
                onPressed: () {
                  getIt<TradeCubit>().toReceivePage(
                    context,
                    TradeToken.fromToken(state.fromToken ?? Token.empty()),
                  );
                },
                // isLoading: isLoading,
                width: double.infinity,
                backgroundColor: AppColors.buttonPrimary(context),
                textColor: Colors.black,
                fontSize: 16.sp,

                label: Text(
                  S.of(context).topUpToken(state.fromToken?.symbol ?? ''),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: PrimaryButton(
                onPressed: () async {
                  final tokens =
                      BlocProvider.of<BalanceCubit>(
                        context,
                      ).state.balances?.tokens ??
                      [];
                  final selectedToken = await showTokenSelectorSheet(
                    context,
                    tokens.map(Token.fromBalance).toList(),
                    title: S.of(context).selectTradeToken,
                    isSearch: false,
                    isShowRight: true,
                    subTitle: S.of(context).crossChainTrade,
                    leading: const SizedBox.shrink(),
                    suffix: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        TradeStatusToastUtils.dismissToast();
                      },
                      child: Icon(
                        Icons.close,
                        size: 24.sp,
                        color: AppColors.foreground(context),
                      ),
                    ),
                  );

                  if (selectedToken != null) {
                    // ignore: use_build_context_synchronously
                    _quickTradeCubit.updateFromToken(selectedToken);
                  }
                },
                // isLoading: isLoading,
                width: double.infinity,
                backgroundColor: AppColors.buttonPrimary(context),
                textColor: Colors.black,
                fontSize: 16.sp,
                label: Text(
                  S.of(context).topUpTokenHint,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
