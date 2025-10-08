import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/swap/swap_cubit.dart';
import 'package:flutter_aigun/cubits/swap/swap_state.dart';
import 'package:flutter_aigun/screens/trade_confirm/widgets/token_selector.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/bottom_button.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TradeConfirmScreen extends StatefulWidget {
  const TradeConfirmScreen({super.key});

  @override
  State<TradeConfirmScreen> createState() => _TradeConfirmScreenState();
}

class _TradeConfirmScreenState extends State<TradeConfirmScreen> {
  SwapCubit? _swapCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 在这里安全地获取并保存 SwapCubit 的引用
    _swapCubit = context.read<SwapCubit>();
  }

  @override
  void dispose() {
    // 使用保存的引用而不是通过 context 访问
    _swapCubit?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SwapCubit>().state;

    return Scaffold(
      appBar: AppBar(
        // title: _buildTokenAvatar(context),
        // leadingWidth: 0,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.refresh,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
              )),
        ],
      ),
      bottomNavigationBar: BottomButton(
        child: CustomButton(
          onPressed: () async {
            final state = context.read<SwapCubit>().state;
            // final password = await showDialog(
            //     context: context,
            //     builder: (context) => const PasswordDialog(
            //           maxLength: 6,
            //           counterText: "",
            //         ));

            // if (password != null && context.mounted) {

            // }

            await context.read<SwapCubit>().swap(
                  fromChainId: state.selectedToken!.chainId.toString(),
                  toChainId: state.selectedToken!.chainId.toString(),
                  inputMint: state.selectedToken!.tokenAddress,
                  outputMint: state.outputMint,
                  amount: state.amount,
                  slippage: state.slippage.toString(),
                  // paymentPin: password,
                  priorityFee: state.priorityFee,
                );

            state.transactionStatus.whenOrNull(
              success: (response) {
                // showSimpleToast(S.of(context).transactionSuccess,
                //     style: ToastificationStyle.simple);
              },
              error: (error) {},
            );
          },
          // text: "确认",
          backgroundColor: Colors.black,
          textColor: Colors.white,
          child: Text(state.isLoading
              ? S.of(context).transactionTraing
              : S.of(context).common_confirm),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<SwapCubit, SwapState>(
            buildWhen: (previous, current) =>
                previous.quoteStatus != current.quoteStatus,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16.w,
                children: [
                  // _buildDefense(context),
                  _buildSelectToken(context),
                  _buildSpend(context),
                  _buildPrecedence(context),
                  _buildAmountInput(context),
                  _buildOutputMint(context),
                  _buildMessage(context)
                ],
              );
            },
          ),
        ),
      )),
    );
  }

  Widget _buildSelectToken(BuildContext context) {
    final selectedToken =
        context.select((SwapCubit cubit) => cubit.state.selectedToken);

    return TokenSelector(
        chainName: selectedToken?.chainName.toString() ?? "",
        tokenAddress: selectedToken?.tokenAddress ?? "",
        chainId: selectedToken?.chainId ?? 0);
  }

  Widget _buildSpend(BuildContext context) {
    return _buildSection(
        BlocBuilder<SwapCubit, SwapState>(builder: (context, state) {
      return Column(
        spacing: 16.w,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "滑点",
                      style:
                          TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 3.h), // 在这里调整文字与下划线的距离
                    SizedBox(
                      height: 1,
                      child: CustomPaint(
                        painter: DashedLinePainter(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Container(
          //   padding: EdgeInsets.all(10.w),
          //   decoration: BoxDecoration(
          //     color: Colors.grey[200],
          //     borderRadius: BorderRadius.circular(10.w),
          //   ),
          //   child: TextField(
          //     textAlign: TextAlign.right,
          //     keyboardType: const TextInputType.numberWithOptions(
          //         decimal: true), // 设置为数字输入框并允许输入小数
          //     style: TextStyle(
          //         fontSize: 16.sp,
          //         color: Colors.black,
          //         fontWeight: FontWeight.normal),
          //     decoration: InputDecoration(
          //         suffixText: "%",
          //         suffixStyle: TextStyle(
          //             fontSize: 16,
          //             fontWeight: FontWeight.normal,
          //             color: Colors.black),
          //         isDense: true,
          //         contentPadding: EdgeInsets.zero,
          //         border: InputBorder.none,
          //         hintText: "0.00000000",
          //         hintStyle: TextStyle(
          //             color: Colors.grey[400],
          //             fontSize: 16.sp,
          //             fontWeight: FontWeight.normal)),
          //   ),
          // )
          Row(
            children: [
              Text("${state.slippage.toInt()}%"),
              Expanded(
                  child: Slider(
                      value: state.slippage,
                      max: 10000,
                      min: 100,
                      divisions: 99,
                      label: "${state.slippage.toInt()}%",
                      activeColor: AppColors.quinary,
                      inactiveColor: AppColors.quinary.withValues(alpha: 0.3),
                      onChanged: (double value) {
                        context.read<SwapCubit>().updateSlippage(value);
                      })),
              const Text("10000%")
            ],
          )
        ],
      );
    }));
  }

  Widget _buildSection(Widget child) {
    return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.background(context),
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: child);
  }

  Widget _buildPrecedence(BuildContext context) {
    return _buildSection(Column(
      spacing: 16.w,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "优先费",
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 3.h), // 在这里调整文字与下划线的距离
                  SizedBox(
                    height: 1,
                    child: CustomPaint(
                      painter: DashedLinePainter(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            // color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.w),
          ),
          child: TextField(
            textAlign: TextAlign.right,
            onChanged: (value) {
              context.read<SwapCubit>().updatePriorityFee(value);
            },
            keyboardType: const TextInputType.numberWithOptions(
                decimal: true), // 设置为数字输入框并允许输入小数
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                // backgroundColor: AppColors.pageBg2Dark,
                fontWeight: FontWeight.normal),
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.background(context),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.w),
                ),
                // suffixText: "SO
                suffixStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                isDense: true,
                contentPadding: EdgeInsets.zero,
                // border: InputBorder.none,
                // fillColor: AppColors.pageBg2Dark,
                // filled: true,
                hintText: "0.00000000",
                hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal)),
          ),
        )
      ],
    ));
  }

  Widget _buildAmountInput(BuildContext context) {
    return _buildSection(Column(
      spacing: 16.w,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "代币数量",
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 3.h), // 在这里调整文字与下划线的距离
                  SizedBox(
                    height: 1,
                    child: CustomPaint(
                      painter: DashedLinePainter(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.background(context),
            borderRadius: BorderRadius.circular(10.w),
          ),
          child: TextField(
            textAlign: TextAlign.right,
            onChanged: (value) {
              context.read<SwapCubit>().updateAmount(value);
            },
            keyboardType: const TextInputType.numberWithOptions(
                decimal: true), // 设置为数字输入框并允许输入小数
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.normal),
            decoration: InputDecoration(
                // suffixText: "SOL",
                suffixStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: "0.00000000",
                hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal)),
          ),
        )
      ],
    ));
  }

  Widget _buildOutputMint(BuildContext context) {
    return _buildSection(Column(
      spacing: 16.w,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "目标代币地址",
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 3.h), // 在这里调整文字与下划线的距离
                  SizedBox(
                    height: 1,
                    child: CustomPaint(
                      painter: DashedLinePainter(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.background(context),
            borderRadius: BorderRadius.circular(10.w),
          ),
          child: TextField(
            textAlign: TextAlign.right,
            onChanged: (value) {
              context.read<SwapCubit>().updateOutputMint(value);
            },
            // keyboardType: const TextInputType.numberWithOptions(
            //     decimal: true), // 设置为数字输入框并允许输入小数
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.normal),
            decoration: InputDecoration(
                // suffixText: "SOL",
                suffixStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: "请输入目标代币地址",
                hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal)),
          ),
        )
      ],
    ));
  }

  Widget _buildMessage(BuildContext context) {
    return BlocBuilder<SwapCubit, SwapState>(builder: (context, state) {
      return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Text("Gas Fee：\$${state.quote?.gasFee ?? 0}",
                  style: const TextStyle(color: Colors.grey)),
              Text("Impact Price：${state.quote?.impactPrice ?? 0}",
                  style: const TextStyle(color: Colors.grey)),
              Text("Input：${state.quote?.inAmount ?? 0}",
                  style: const TextStyle(color: Colors.grey)),
              Text("Output：${state.quote?.outAmount ?? 0}",
                  style: const TextStyle(color: Colors.grey)),
            ],
          ));
    });
  }
}

//
class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 4;
    double dashSpace = 2;
    double startX = 0;
    final paint = Paint()
      ..color = Colors.grey[600]!
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
