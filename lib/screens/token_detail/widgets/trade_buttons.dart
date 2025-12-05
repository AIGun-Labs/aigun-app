import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubits/index.dart';
import '../../../cubits/token_detail/token_detail_state.dart';
import '../../../l10n/l10n.dart';
import '../../../themes/themes.dart';
import '../../../widgets/button/primary.dart';

class TradeButtons extends StatelessWidget {
  const TradeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
      builder: (context, state) {
        return Container(
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50.h,
                  child: PrimaryButton(
                    onPressed: () async {},
                    label: Text(
                      S.of(context).buyIn,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: SizedBox(
                  height: 50.h,
                  child: PrimaryButton(
                    borderSide: BorderSide(
                      color: AppColors.border(context),
                      width: 1.w,
                    ),
                    backgroundColor: AppColors.quinary,
                    onPressed: () async {
                      if (state.token != null) {}
                    },
                    label: Text(
                      S.of(context).sellOut,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
