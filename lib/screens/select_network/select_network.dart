import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/wallet_backups/wallet_cubit.dart';
import '../../cubits/wallet_backups/wallet_state.dart';
import '../../data/models/index.dart';
import '../../l10n/l10n.dart';
import '../../widgets/appbar.dart';
import 'widgets/network_item.dart';

class SelectNetworkScreen extends StatelessWidget {
  const SelectNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).wallet_selectNetwork),
      body: SafeArea(
        child: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            return BlocSelector<WalletCubit, WalletState, List<WalletAddress>?>(
              // 注意 Null Safety
              selector: (state) => state.wallets.firstOrNull?.addresses ?? [],
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state?.length ?? 0,
                  itemBuilder: (context, index) {
                    final wallet = state?[index];
                    if (wallet == null) return const SizedBox.shrink();
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        child: NetworkItem(wallet: wallet));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
