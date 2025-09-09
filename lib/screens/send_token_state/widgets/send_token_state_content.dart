import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/transfer/transfer_cubit.dart';
import 'package:flutter_aigun/cubits/transfer/transfer_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/url.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SendTokenStateContent extends StatelessWidget {
  const SendTokenStateContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferCubit, TransferState>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildChildren(context, state),
          ),
        );
      },
    );
  }

  List<Widget> _buildChildren(BuildContext context, TransferState state) {
    if (state.isSending) {
      return _buildSending(context);
    }
    // 发送成功
    else if (state.isSent) {
      return _buildSent(context, state);
    } else {
      return _buildFailed(context);
    }
  }

  List<Widget> _buildSending(BuildContext context) {
    return [
      SvgPicture.asset(
        'assets/images/icons/send-token-history.svg',
        width: 120.w,
        height: 120.h,
        colorFilter: ColorFilter.mode(
          AppColors.textPrimary(context),
          BlendMode.srcIn,
        ),
      ),
      SizedBox(height: 26.h),
      Text(S.of(context).transfer_sendTokenPadding1),
      SizedBox(height: 5.h),
      Text(S.of(context).transfer_sendTokenPadding2),
      SizedBox(height: 100.h),
    ];
  }

  List<Widget> _buildSent(BuildContext context, TransferState state) {
    return [
      SvgPicture.asset(
        'assets/images/icons/send-checked.svg',
        width: 120.w,
        height: 120.h,
        colorFilter: const ColorFilter.mode(
          AppColors.quaternary,
          BlendMode.srcIn,
        ),
      ),
      SizedBox(height: 26.h),
      _buildAmountText(
          context, state.amount, state.selectedToken?.symbol ?? ""),
      SizedBox(height: 15.h),
      // _buildText(context, S.of(context).transfer_sendTokenPadding5, 14.sp,
      //     color: AppColors.pirmary),
      TextButton(
        onPressed: () {
          launchUrl(state.transaction?.txUrl ?? "");
        },
        child: Text(
          S.of(context).transfer_sendTokenPadding5,
          style: TextStyle(color: AppColors.textPrimary(context)),
        ),
      ),
      SizedBox(height: 100.h),
    ];
  }

  List<Widget> _buildFailed(BuildContext context) {
    return [
      SizedBox(height: 150.h),
      SvgPicture.asset(
        'assets/images/icons/send-failed.svg',
        width: 120.w,
        height: 120.h,
        colorFilter: const ColorFilter.mode(
          AppColors.secondary,
          BlendMode.srcIn,
        ),
      ),
      SizedBox(height: 26.h),
      _buildText(context, S.of(context).transfer_failedToSendToken, 20.sp),
      SizedBox(height: 15.h),
      _buildText(context, S.of(context).transfer_failedToSendTokenReason, 14.sp,
          color: AppColors.secondary),
      SizedBox(height: 5.h),
      _buildText(
          context, S.of(context).transfer_failedToSendTokenReason2, 14.sp,
          color: AppColors.secondary),
      SizedBox(height: 100.h),
    ];
  }

  Widget _buildAmountText(BuildContext context, String amount, String symbol) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildText(
          context,
          amount,
          20.sp,
        ),
        SizedBox(width: 5.w),
        _buildText(context, symbol, 20.sp),
      ],
    );
  }

  Widget _buildText(BuildContext context, String text, double fontSize,
      {Color? color}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? AppColors.textPrimary(context),
      ),
    );
  }
}
