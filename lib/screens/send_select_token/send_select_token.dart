import 'package:flutter/material.dart';
import 'package:flutter_aigun/core/router/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/send_select_token/cubit/send_select_token_cubit.dart';
import 'package:flutter_aigun/screens/send_select_token/cubit/send_select_token_state.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/button/add_token_button.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_aigun/widgets/token_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'widgets/search_input.dart';

/// 转出-选币
class SendSelectTokenScreen extends StatelessWidget {
  const SendSelectTokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? extra;
    try {
      extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    } catch (e) {
      debugPrint('GoRouterState.of failed in SendSelectTokenScreen: $e');
    }
    final showAddress = extra?['showAddress'] as bool? ?? false;
    final replace = extra?['replace'] as bool? ?? false;

    return Scaffold(
      appBar: CustomAppBar(
          title: S.of(context).transfer_sendToken,
          onPressed: () {
            context.pop();
          }),
      body: SafeArea(
          child: BlocProvider(
        create: (context) => SendSelectTokenCubit(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                const SearchInput(),
                SizedBox(height: 12.h),
                BlocBuilder<SendSelectTokenCubit, SendSelectTokenState>(
                  builder: (context, state) {
                    final balanceState = context.watch<BalanceCubit>().state;
                    final tokens = balanceState.balances?.tokens
                        .where((token) =>
                            (double.tryParse(token.tokenPrice) ?? 0.0) > 0)
                        .toList();
                    final filterToken = context
                        .read<SendSelectTokenCubit>()
                        .getTokens(tokens)
                        ?.map((token) => Token.fromBalance(token))
                        .toList();

                    return Column(
                      children: [
                        TokenList(
                          onTap: (token) {
                            // 更新选中的 token
                            context
                                .read<TransferCubit>()
                                .updateSelectedToken(token);

                            context.pushNamed(RouteNames.sendTokenDetail);
                          },
                          showAddress: showAddress,
                          replace: replace,
                          tokens: filterToken,
                          isLoading: balanceState.isLoading,
                        ),
                        const AddTokenButton()
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
