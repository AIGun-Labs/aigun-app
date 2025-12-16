import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/format/currency.dart';
import '../cubit/swap/swap_cubit.dart';
import '../cubit/swap/swap_state.dart';

class BalanceRow extends StatelessWidget {
  BalanceRow({super.key});
  late SwapCubit _swapCubit;

  @override
  Widget build(BuildContext context) {
    _swapCubit = BlocProvider.of<SwapCubit>(context);
    return BlocBuilder<SwapCubit, SwapState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _swapCubit.toReceivePage(context, state.fromToken);
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 10.w,
                  child: Icon(
                    Icons.add,
                    color: AppColors.background(context),
                    size: 16.w,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _swapCubit.toReceivePage(context, state.fromToken),
                child: Row(
                  children: [
                    Text(
                      '${S.of(context).balance}: ',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    Text(
                      CurrencyFormatter.abbreviateTokenPrice(
                        state.fromBalance ?? 0,
                        fixedDecimals: 4,
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      state.fromToken?.symbol ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 6.w),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _swapCubit.updateAmountToMax,
                child: Text(
                  S.of(context).max,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textPrimary(context),
                  ),
                ),
              ),
              SizedBox(width: 4.w),
            ],
          ),
        );
      },
    );
  }
}
