import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/router/routes/app_routes.dart';
import '../../../../cubits/index.dart';
import '../../../../shared/domain/mappers/token_mapper.dart';
import '../../../../utils/logger.dart';
import '../../../../widgets/token/models/token.dart';
import '../../../../widgets/token_list.dart';

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
                BlocProvider.of<QuickTradeCubit>(
                  context,
                ).updateSelectedToken(token);

                TokenDetailRoute(
                  token.toTokenEntity(),
                  type: 'wallet',
                ).push(context);
              } catch (e) {
                Logger.error('updateToken error: $e');
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
