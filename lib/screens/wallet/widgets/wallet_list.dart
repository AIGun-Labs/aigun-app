import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/screens/wallet/widgets/filter_token.dart';
import 'package:flutter_aigun/widgets/token_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletList extends StatelessWidget {
  const WalletList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const FilterToken(),
        ),
        SizedBox(height: 12.w),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<BalanceCubit, BalanceState>(
            builder: (context, state) {
              return TokenList(
                tokens: state.balances?.tokens,
                isLoading: state.isLoading,
                errorMessage: state.errorMessage,
              );
            },
          ),
        )),
      ],
    );
  }
}
