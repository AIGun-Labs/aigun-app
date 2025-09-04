import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenSwapCard extends StatefulWidget {
  const TokenSwapCard(
      {Key? key,
      required this.onSelectToken,
      required this.dollarValue,
      required this.token,
      required this.isSourceToken,
      this.onAmountChanged,
      this.isEditable = false,
      this.amountController,
      this.amount})
      : super(key: key);

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
  bool _isControllerOwned = false;

  @override
  void initState() {
    super.initState();
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
      _amountController = widget.amountController!;
      _isControllerOwned = false;
    } else {
      _amountController = TextEditingController(text: widget.amount ?? "");
      _isControllerOwned = true;
    }
  }

  @override
  void dispose() {
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
    // final amountText =
    //     widget.isSourceToken ? widget.amount : "≈${widget.amount}";

    return Card(
      elevation: 0,
      color: AppColors.background(context),
      // shadowColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: AppColors.border(context), // 边框颜色
          width: 1.r, // 边框宽度
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: widget.onSelectToken,
              child: Row(
                children: [
                  _buildTokenIcon(widget.token),
                  SizedBox(width: 8.w),
                  _buildSelectTokenText(),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 18.w,
                  )
                ],
              ),
            ),
            // Spacer(),
            SizedBox(width: 12.w),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [_buildAmount(), _buildDollarValue()],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildAmount() {
    return
        // 如果可编辑，显示输入框，否则显示文本
        widget.isEditable
            ? SizedBox(
                child: TextField(
                  controller: _amountController,
                  onChanged: widget.onAmountChanged,
                  textAlign: TextAlign.end,
                  readOnly: !widget.isEditable,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.textSecondary(context),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "0.00",
                    hintStyle: TextStyle(
                      fontSize: 20.sp,
                      color: AppColors.textQuinary(context),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              )
            : Text(
                // 否则显示文本
                _amountController.text.isEmpty
                    ? "0.00"
                    : "≈${formatPrice(_amountController.text)}",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.textSecondary(context),
                ),
              );
  }

  Widget _buildDollarValue() {
    return Text(
      widget.dollarValue.isEmpty
          ? "0.00"
          : "\$${formatPrice(widget.dollarValue)}",
      style: TextStyle(
        fontSize: 16.sp,
        color: AppColors.textQuaternary(context),
      ),
    );
  }

  Widget _buildSelectTokenText() {
    // return Text(
    //   widget.token.tokenName,
    //   style: TextStyle(fontSize: 18.w),
    // );

    final String tokenName =
        widget.token.tokenName.isEmpty ? "请先选择代币" : widget.token.tokenName;

    return Text(
      tokenName,
      style: TextStyle(fontSize: 16.w),
    );
  }

  Widget _buildTokenIcon(TradeToken token) {
    return Stack(
      clipBehavior: Clip.none, // 不裁剪子元素
      children: [
        ClipOval(
          // child: SmartNetworkImage(
          //   // url: getImageUrl(token?.logo) ?? "",
          //   url: ,
          //   width: 48.w,
          //   height: 48.h,
          //   fit: BoxFit.cover,
          // ),
          child: SmartNetworkImage(
            url: getImageUrl(token.tokenAvatar) ?? "",
            height: 48.h,
            width: 48.w,
            fit: BoxFit.cover,
            loadingWidget: const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: CachedImage(
              imageUrl: "assets/images/icons/ai-agent.png",
              height: 48.h,
              width: 48.w,
            ),
          ),
        ),
        Positioned(
          bottom: -4,
          right: -4,
          child: ClipOval(
            child: SmartNetworkImage(
              url: getImageUrl(token.chainLogo) ?? "",
              height: 24.h,
              width: 24.w,
              fit: BoxFit.cover,
              loadingWidget: const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: CachedImage(
                imageUrl: "assets/images/icons/ai-agent.png",
                height: 24.h,
                width: 24.w,
              ),
            ),
          ),
        )
      ],
    );
  }
}
