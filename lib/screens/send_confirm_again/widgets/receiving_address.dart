import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceivingAddress extends StatelessWidget {
  const ReceivingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).wallet_receivingAddress,
          style: TextStyle(
              fontSize: 16.sp,
              // color: Color(0xFF101010),
              color: Colors.white),
        ),
        SizedBox(height: 5.h),
        BlocBuilder<TransferCubit, TransferState>(
          builder: (context, state) {
            return Text(
              state.toAddress,
              style: TextStyle(
                  fontSize: 18.sp,
                  // color: Color(0xFF101010),
                  color: AppColors.textPrimary(context)),
            );
          },
        ),
      ],
    );
  }
}
