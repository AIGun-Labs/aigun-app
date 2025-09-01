import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/send_token_detail/widgets/title_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class NetworkFees extends StatelessWidget {
  const NetworkFees({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferCubit, TransferState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).wallet_networkFees,
            style: TextStyle(
              fontSize: 16.sp,
              // color: Color(0xFF101010),
              color: Colors.white,
            ),
          ),
          BlocBuilder<TransferCubit, TransferState>(
            builder: (context, state) {
              return state.loadingGas && state.gas == null
                  ? Container(
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
                  : TitleText(
                      // text:
                      //     "${state.calculatedGas?.getValueInUnit(EtherUnit.gwei).toStringAsFixed(9)} ${state.gas?.chainType}",
                      text:
                          "${state.gas?.gas.toString() ?? '0'} ${state.gas?.symbol ?? ''}",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    );
            },
          ),
        ],
      );
    });
  }
}
