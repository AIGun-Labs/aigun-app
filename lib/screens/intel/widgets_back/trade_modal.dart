import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'trade/index.dart';

class TradeModal extends StatefulWidget {
  final String tokenSymbol;
  final String reserveSymbol;
  final String balance;
  final String reserveBalance;

  const TradeModal({
    super.key,
    required this.tokenSymbol,
    required this.reserveSymbol,
    required this.balance,
    required this.reserveBalance,
  });

  @override
  State<TradeModal> createState() => _TradeModalState();
}

class _TradeModalState extends State<TradeModal>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _amountController = TextEditingController();
  bool isBuy = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        isBuy = _tabController.index == 0;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 头部
              const TradeHeader(),
              // 交易类型
              TradeTabs(controller: _tabController),
              // 交易主体
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    // 交易输入框
                    TradeInput(
                      controller: _amountController,
                      isBuy: isBuy,
                      tokenSymbol: widget.tokenSymbol,
                      reserveSymbol: widget.reserveSymbol,
                    ),
                    SizedBox(height: 12.h),
                    // 快速输入
                    TradeQuickButtons(
                      isBuy: isBuy,
                      onAmountSelected: _handleAmountSelected,
                    ),
                  ],
                ),
              ),
              // 余额
              TradeBalance(
                isBuy: isBuy,
                balance: widget.balance,
                reserveBalance: widget.reserveBalance,
                tokenSymbol: widget.tokenSymbol,
                reserveSymbol: widget.reserveSymbol,
              ),
              // 滑点设置
              const TradeSlippage(),
              // 底部
              keyboardHeight <= 0
                  ? SizedBox(height: bottomPadding)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAmountSelected(String amount) {
    if (isBuy) {
      _amountController.text = amount;
    } else {
      final amountValue = double.tryParse(amount) ?? 0.0;
      final balanceValue = double.tryParse(widget.balance) ?? 0.0;
      _amountController.text = (amountValue / 100 * balanceValue).toString();
    }
  }
}
