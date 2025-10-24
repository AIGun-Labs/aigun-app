import 'package:flutter/material.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
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
        buildWhen: (previous, current) {
          // 检查多个字段的变化
          return previous.balances != current.balances ||
              previous.isLoading != current.isLoading ||
              previous.hasError != current.hasError;
        },
        builder: (context, state) {
          final newTokens = state.balances?.tokens
                  .map((token) => Token.fromBalance(token))
                  .toList() ??
              [];

          return TokenList(
            tokens: newTokens,
            isLoading: state.isLoading,
            errorMessage: state.errorMessage,
          );
        },
      ),
    );
  }
}
