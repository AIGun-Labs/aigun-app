import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aigun/cubits/sound_effect/sound_effect_cubit.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/format/input_formatters.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/constants.dart';
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
          title: S.of(context).wallet_transfer,
          onPressed: () {
            // 手动处理返回逻辑，使用新的 resetAll 方法
            final transferCubit = context.read<TransferCubit>();
            transferCubit.resetAll();
            // 使用 GoRouter 返回
            if (context.canPop()) {
              context.pop();
            } else {
              // 如果无法返回，导航到主页
              context.goNamed(RouteNames.intel);
            }
          },
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 选择币种
              LabelText(text: S.of(context).wallet_selectToken),
              SizedBox(
                height: 6.h,
              ),
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
              SizedBox(height: 25.h),
              // 接收地址
              LabelText(text: S.of(context).wallet_receivingAddress),
              SizedBox(
                height: 6.h,
              ),

              InputTextField(
                controller:
                    context.read<TransferCubit>().state.toAddressController,
                hintText: S.of(context).checkAddress,
                onChanged: (value) {
                  context.read<TransferCubit>().updateToAddress(value);
                  context.read<TransferCubit>().checkAddress(value);
                },
                suffixText: S.of(context).paste,
                onSuffixIconTap: () {
                  final cubit = context.read<TransferCubit>();
                  ClipboardUtils.paste().then((value) {
                    cubit.updateToAddress(value);
                    cubit.checkAddress(value);
                  });
                },
              ),
              SizedBox(height: 25.h),
              // 转账数量
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LabelText(text: S.of(context).transferAmount),
                  AvailableAmount(
                      amount: context
                              .read<TransferCubit>()
                              .state
                              .selectedToken
                              ?.balance ??
                          '0'),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputTextField(
                        formatters: InputFormatters.tradeAmountInputFormatters(
                            maxDecimalPlaces: state.decimals),
                        controller: state.amountController,
                        hintText: S.of(context).inputTransferAmount,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (value) {
                          context.read<TransferCubit>().updateAmount(value);
                          context
                              .read<TransferCubit>()
                              .checkAmount(value, token?.balance ?? '0');
                        },
                        suffixText: S.of(context).all,
                        onSuffixIconTap: () {
                          context
                              .read<TransferCubit>()
                              .updateAmount(token?.balance ?? '0');
                          context.read<TransferCubit>().checkAmount(
                              token?.balance ?? '0', token?.balance ?? '0');
                        },
                      ),
                      SizedBox(height: 25.h),
                      GasFeeText(
                        gasFee: CurrencyFormatter.abbreviateTokenPrice(
                            double.tryParse(state.gas?.gas ?? '0') ?? 0),
                        symbol: state.gas?.symbol ?? '',
                      ),
                      SizedBox(height: 25.h),
                      const ErrorTextList(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<TransferCubit, TransferState>(
            builder: (context, state) {
          final isDisabled = state.amountError ||
              state.addressError ||
              state.gasError ||
              state.amount == '0' ||
              state.toAddressController.text.isEmpty ||
              state.amountController.text.isEmpty;

          return SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: PrimaryButton(
                    backgroundColor: AppColors.primary,
                    onPressed: isDisabled
                        ? null
                        : () {
                            context.read<SoundEffectCubit>().playGunLoad();
                            context.pushNamed(RouteNames.sendConfirmAgain);
                          },
                    label: Text(
                      S.of(context).common_confirm,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: isDisabled
                              ? AppColors.textTertiary(context)
                              : AppColors.textPrimary(context)),
                    ),
                  )));
        }),
      ),
    );
  }
}

class GasFeeText extends StatelessWidget {
  const GasFeeText({super.key, required this.gasFee, required this.symbol});

  final String gasFee;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    final gasFeeText = "${S.of(context).gasFee}: $gasFee ${symbol ?? ''}";

    return Text(
      gasFeeText,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16.sp,
        color: AppColors.textSecondary(context),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  const LabelText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary(context),
      ),
    );
  }
}

class AvailableAmount extends StatelessWidget {
  const AvailableAmount({super.key, this.amount = ''});

  final String amount;

  @override
  Widget build(BuildContext context) {
    final balance =
        CurrencyFormatter.abbreviateTokenPrice(double.tryParse(amount) ?? 0);

    return Text(
      "${S.of(context).available}: $balance",
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary(context),
      ),
    );
  }
}

class TransferInputField extends StatelessWidget {
  const TransferInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}

class ErrorTextList extends StatelessWidget {
  const ErrorTextList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferCubit, TransferState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          if (state.gasError) ErrorText(text: S.of(context).gasFeeInsufficient),
          if (state.addressError) ErrorText(text: S.of(context).addressError),
          if (state.amountError) ErrorText(text: S.of(context).amountError),
        ],
      );
    });
  }
}

class ErrorText extends StatelessWidget {
  const ErrorText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/icons/info-outline.svg',
          width: 24.w,
          height: 24.h,
          colorFilter:
              const ColorFilter.mode(AppColors.tipColor, BlendMode.srcIn),
        ),
        SizedBox(width: 5.w),
        Text(
          text,
          style: TextStyle(
              color: AppColors.tipColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

class InputTextField extends StatelessWidget {
  const InputTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.onChanged,
      this.formatters,
      this.onSuffixIconTap,
      this.suffixText = '',
      this.keyboardType});

  final TextEditingController controller;
  final List<TextInputFormatter>? formatters;
  final String hintText;
  final Function(String) onChanged;
  final Function()? onSuffixIconTap;
  final String suffixText;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextField(
        keyboardType: keyboardType,
        inputFormatters: formatters,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: AppColors.border(context),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: AppColors.border(context),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: AppColors.border(context),
            ),
          ),
          fillColor: AppColors.background(context),
          hintText: hintText,
          hintStyle: TextStyle(
              color: AppColors.textQuaternary(context), fontSize: 16.sp),
          suffixIcon: GestureDetector(
            onTap: onSuffixIconTap,
            child: SizedBox(
              width: 60.w,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  suffixText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.quaternary,
                  ),
                ),
              ),
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class InputTextFieldSuffixIcon extends StatelessWidget {
  const InputTextFieldSuffixIcon({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-14.w, 0),
      child: child,
    );
  }
}
