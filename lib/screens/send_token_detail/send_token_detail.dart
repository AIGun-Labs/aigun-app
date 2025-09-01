import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/bottom_button.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import 'widgets/title_text.dart';
import 'widgets/token_selector.dart';

// 转出-输入详情
class SendTokenDetailScreen extends StatelessWidget {
  const SendTokenDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // 页面已经弹出，只需要清除状态，不要再次执行导航
          final transferCubit = context.read<TransferCubit>();
          transferCubit.resetAll();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          onPressed: () {
            // 手动处理返回逻辑，使用新的 resetAll 方法
            final transferCubit = context.read<TransferCubit>();
            transferCubit.resetAll();
            // 使用 GoRouter 返回
            if (context.canPop()) {
              context.pop();
            } else {
              // 如果无法返回，导航到主页
              context.go(Routes.home);
            }
          },
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: S.of(context).wallet_transfer,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              TitleText(
                text: S.of(context).wallet_selectToken,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                topPadding: 17.h,
              ),

              // 选择 token
              BlocBuilder<TransferCubit, TransferState>(
                buildWhen: (previous, current) {
                  return previous.tokenAddress != current.tokenAddress ||
                      previous.chainId != current.chainId;
                },
                builder: (context, state) {
                  return TokenSelector(
                    chainName: state.selectedToken?.chainName ?? '',
                    tokenAddress: state.tokenAddress,
                    chainId: state.chainId,
                  );
                },
              ),
              TitleText(
                text: S.of(context).wallet_receivingAddress,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                topPadding: 27.h,
              ),

              SizedBox(height: 14.h),

              // 输入收款地址
              CustomInput(
                hintText: S.of(context).form_inputCorrectAddress,
                fontSize: 16.sp,
                isOutline: true,
                controller:
                    context.read<TransferCubit>().state.toAddressController,
                borderRadius: BorderRadius.circular(8.r),
                onChanged: (value) {
                  context.read<TransferCubit>().updateToAddress(value);
                  context.read<TransferCubit>().checkAddress(value);
                },
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () async {
                      final cubit = context.read<TransferCubit>();
                      try {
                        final clipboardData =
                            await Clipboard.getData(Clipboard.kTextPlain);
                        if (clipboardData?.text != null) {
                          cubit.updateToAddress(clipboardData!.text!);
                          cubit.checkAddress(clipboardData.text!);
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      S.of(context).common_paste,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.quinary,
                      ),
                    ),
                  ),
                ),
              ),
              TitleText(
                text: S.of(context).form_amount,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                topPadding: 27.h,
              ),
              SizedBox(height: 14.h),
              BlocBuilder<TransferCubit, TransferState>(
                builder: (context, state) {
                  final token = state.selectedToken;
                  // 如果 balance 为 null，显示加载状态或错误提示
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            S.of(context).wallet_noToken,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  );

// 错误文本
                  String errorText = '';
                  if (state.gasError) {
                    errorText = S.of(context).wallet_gasFeeInsufficient;
                  } else if (state.amountError) {
                    errorText = S.of(context).validation_amountInsufficient;
                  } else if (state.addressError) {
                    errorText = S.of(context).validation_addressInvalid;
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 输入金额
                      CustomInput(
                        hintText: S.of(context).form_inputCorrectAmount,
                        fontSize: 16.sp,
                        controller: state.amountController,
                        isOutline: true,
                        borderRadius: BorderRadius.circular(8.r),
                        onChanged: (value) {
                          // 修改金额
                          context.read<TransferCubit>().updateAmount(value);
                          context
                              .read<TransferCubit>()
                              .checkAmount(value, token?.balance ?? '0');
                        },
                        suffixIcon: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            context
                                .read<TransferCubit>()
                                .updateAmount(token?.balance ?? '0');
                            context.read<TransferCubit>().checkAmount(
                                token?.balance ?? '0', token?.balance ?? '0');
                            // “全部”的点击事件
                            // context.read<TransferCubit>().setAllAmount();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text(
                              S.of(context).common_all,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.quinary,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // 显示余额
                      TitleText(
                        text: S.of(context).wallet_available(
                              token?.balance.isNotEmpty == true
                                  ? (num.tryParse(token?.balance ?? '0') ?? 0)
                                      .toStringAsFixed(3)
                                  : 0,
                              token?.symbol ?? '',
                            ),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        topPadding: 9.h,
                      ),
                      TitleText(
                        text: S.of(context).wallet_gasFee,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        topPadding: 22.h,
                      ),

                      // 获取 gas 时显示 loading
                      if (state.loadingGas && state.gas == null)
                        Container(
                          width: 100.w,
                          height: 16.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 100.w,
                              height: 16.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ),
                        )
                      else
                        TitleText(
                          // 需要调用获取 gasFee 的 api
                          // text:
                          //     "${state.calculatedGas?.getValueInUnit(EtherUnit.gwei).toStringAsFixed(9) ?? 0} ${state.selectedToken?.symbol ?? ''}",
                          text:
                              "${state.gas?.gas.toString() ?? '0'} ${state.gas?.symbol ?? ''}",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),

                      // 显示错误信息
                      if (errorText.isNotEmpty)
                        TitleText(
                          text: errorText,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          topPadding: 12.h,
                          color: Colors.red,
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<TransferCubit, TransferState>(
            builder: (context, state) {
          return BottomButton(
            child: CustomButton(
              height: 50.h,
              textColor: Colors.white,
              backgroundColor: AppColors.background(context),
              onPressed: state.amountError ||
                      state.addressError ||
                      state.gasError ||
                      state.amount == '0' ||
                      state.toAddressController.text.isEmpty ||
                      state.amountController.text.isEmpty
                  ? null
                  : () => context.push(Routes.sendConfirmAgain),
              // onPressed: () {
              //   context.push(Routes.sendConfirmAgain);
              // },
              text: S.of(context).common_confirm,
              fontSize: 16.sp,
            ),
          );
        }),
      ),
    );
  }
}
