import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AmountDisplay extends StatelessWidget {
  const AmountDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferCubit, TransferState>(
      builder: (context, state) {
        final tokenInfo = context.read<BalanceCubit>().getTokenInfo(
              state.tokenAddress,
              state.chainId,
            );

        // 安全地解析金额，避免 FormatException
        final amount = double.tryParse(state.amount) ?? 0.0;

        return Column(
          children: [
            Center(
              child: Text(
                S.of(context).common_send,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '-',
                      style: TextStyle(
                        fontSize: 30.sp,
                      ),
                    ),
                    TextSpan(
                      text: CurrencyFormatter.format(amount),
                      style: TextStyle(
                        fontSize: 28.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 16.5.w,
                    backgroundImage: AssetImage('assets/images/token.webp'),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    tokenInfo?.symbol ?? '',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
