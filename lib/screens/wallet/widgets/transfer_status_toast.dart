import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';

class TransferStatusToast extends StatelessWidget {
  const TransferStatusToast({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransferCubit, TransferState>(
      listenWhen: (previous, current) => current.isSuccess || current.isFailed,
      listener: (context, state) {
        if (state.isSuccess) {
          _showSuccessToast(context);
        } else if (state.isFailed) {
          _showErrorToast(
            context,
            state.failedReason ?? S.of(context).transfer_failedToSendToken,
          );
        }
        context.read<TransferCubit>().resetStatus();
        context.read<BalanceCubit>().getBalanceList();
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showSuccessToast(BuildContext context) {
    final state = context.read<TransferCubit>().state;
    if (tid != null) {
      Toastification().dismiss(tid!);
    }
    tid = Toastification().showCustom(
      dismissDirection: DismissDirection.up,
      builder: (context, transition) {
        return Container(
          margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.21),
                offset: Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/images/icons/send-checked.svg',
                width: 24.w,
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${state.amount} ${context.read<BalanceCubit>().getTokenInfo(state.tokenAddress, state.chainId)?.symbol ?? ''}",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                  SizedBox(height: 4.h),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      // context.read<ChainCubit>().getChain(state.chainId).;
                    },
                    child: Text(
                      S.of(context).transfer_sendTokenPadding5,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.grey3,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 5), () {
      if (tid != null) {
        Toastification().dismiss(tid!);
      }
    });
  }

  void _showErrorToast(BuildContext context, String message) {
    showSimpleToast(
      message,
      type: ToastificationType.error,
      duration: const Duration(seconds: 5),
    );
  }
}
