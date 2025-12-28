import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/constants.dart';
import '../../../core/service_locator.dart';
import '../../../cubits/index.dart';
import '../../../data/models/wallet/token/token.dart' as wallet_token;
import '../../../l10n/l10n.dart';
import '../../../widgets/button.dart';
import '../../../widgets/error_retry_view.dart';
import '../../../widgets/token/models/token.dart' as widgets_token;
import '../../../widgets/token_card.dart';
import '../../../widgets/token_skeleton.dart';

void showSelectTokenDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: SelectTokenList(
            tokens: context.read<BalanceCubit>().state.balances?.tokens,
            isLoading: false,
          ),
        ),
      );
    },
  );
}

class SelectTokenList extends StatelessWidget {
  const SelectTokenList({
    super.key,
    required this.tokens,
    // required this.addressList,
    this.showAddress = false,
    this.replace = false,
    this.isLoading = false,
    this.errorMessage,
  });

  final bool showAddress;
  final bool replace;
  final List<wallet_token.Token>? tokens;
  // final List<Address>? addressList;
  final bool isLoading;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      if (tokens != null) {
        return _buildTokenList(context);
      }
      return const TokenSkeleton();
    }
    if (errorMessage != null) {
      return ErrorRetryView(
        errorMessage: errorMessage ?? '',
        onRetry: () {
          context.read<BalanceCubit>().getBalanceList();
        },
      );
    }
    return _buildTokenList(context);
  }

  Widget _buildTokenList(BuildContext context) {
    if (tokens!.isEmpty == true) {
      return Column(
        children: [
          SizedBox(height: 50.w),
          Text(S.of(context).wallet_noToken),
          SizedBox(height: 20.w),
          Center(
            child: CustomButton(
              width: 150.w,
              height: 40.w,
              backgroundColor: Theme.of(context).colorScheme.primary,
              fontSize: 14.sp,
              textColor: Colors.white,
              onPressed: () {
                context.pushNamed(RouteNames.addToken);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text(S.of(context).tokens_addToken)],
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: tokens!.map((token) {
        return TokenCard(
          token: widgets_token.Token.fromBalance(token),
          showAddress: showAddress,
          onTap: () {
            getIt<SwapCubit>().updateToken(token);
            context.pop(); //
          },
        );
      }).toList(),
    );
  }
}
