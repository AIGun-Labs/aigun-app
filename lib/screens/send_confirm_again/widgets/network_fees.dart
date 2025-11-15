import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../cubits/index.dart';
import '../../../l10n/l10n.dart';
import '../../../themes/themes.dart';
import '../../../utils/format/currency.dart';
import '../../send_token_detail/widgets/title_text.dart';

class NetworkFees extends StatelessWidget {
  const NetworkFees({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferCubit, TransferState>(builder: (context, state) {
      final gasFee = state.gas?.gas;
      final gas =
          "${CurrencyFormatter.abbreviateTokenPrice(double.tryParse(gasFee ?? '0') ?? 0)} ${state.gas?.symbol ?? ''}";
      final gasUsd = CurrencyFormatter.abbreviateTokenPriceWithSymbol(
          double.tryParse(state.gas?.gasUsd ?? '0') ?? 0);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).wallet_networkFees,
            style: TextStyle(
              fontSize: 16.sp,
              // color: Color(0xFF101010),
              color: AppColors.textPrimary(context),
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
                            color: AppColors.background(context),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    )
                  : TitleText(
                      // text:
                      //     "${state.calculatedGas?.getValueInUnit(EtherUnit.gwei).toStringAsFixed(9)} ${state.gas?.chainType}",
                      text: "$gas ($gasUsd)",
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
