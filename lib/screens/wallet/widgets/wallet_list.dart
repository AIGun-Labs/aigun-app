import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/constants.dart';
import '../../../core/service_locator.dart';
import '../../../cubits/index.dart';
import '../../../utils/logger.dart';
import '../../../widgets/token/models/token.dart';
import '../../../widgets/token_list.dart';

class WalletList extends StatelessWidget {
  const WalletList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: BlocBuilder<BalanceCubit, BalanceState>(
        buildWhen: (previous, current) {
          // 检查多个字段的变化
          return previous.balances != current.balances ||
              previous.isLoading != current.isLoading ||
              previous.hasError != current.hasError;
        },
        builder: (context, state) {
          final newTokens = (state.balances?.tokens ?? [])
              .map((token) => Token.fromBalance(token))
              .toList();

          return TokenList(
            onTap: (token) async {
              try {
                getIt<QuickTradeCubit>().updateSelectedToken(token);
                context.pushNamed(RouteNames.tokenDetail, extra: "wallet");
                await getIt<TokenDetailCubit>().updateToken(token);
              } catch (e) {
                Logger.error("updateToken error: $e");
              }
            },
            tokens: newTokens,
            isLoading: state.isLoading,
            errorMessage: state.errorMessage,
          );
        },
      ),
    );
  }
}
