import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/widgets/error_retry_view.dart';

import '../../../cubits/wallet_backups/wallet_cubit.dart';

class WalletError extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;

  const WalletError({
    super.key,
    required this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorRetryView(
      errorMessage: errorMessage,
      onRetry: onRetry ??
          () {
            // 默认的重试逻辑是刷新钱包数据
            context.read<WalletCubit>().getChains();
          },
    );
  }
}
