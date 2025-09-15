import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/widgets/token_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletList extends StatelessWidget {
  const WalletList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: BlocBuilder<BalanceCubit, BalanceState>(
        builder: (context, state) {
          return TokenList(
            tokens: context.read<BalanceCubit>().getSortedTokens(),
            isLoading: state.isLoading,
            errorMessage: state.errorMessage,
          );
        },
      ),
    );
  }
}
