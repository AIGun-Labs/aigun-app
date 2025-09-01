import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubits/wallet_backups/wallet_cubit.dart';
import '../../../cubits/wallet_backups/wallet_state.dart';
import '../../../data/models/wallet_group/wallet_group.dart';
import '../../../l10n/l10n.dart';
import 'wallet_account_item.dart';

class WalletGroupItem extends StatefulWidget {
  final WalletGroup walletGroup;

  const WalletGroupItem({
    super.key,
    required this.walletGroup,
  });

  @override
  State<WalletGroupItem> createState() => _WalletGroupItemState();
}

class _WalletGroupItemState extends State<WalletGroupItem> {
  bool isExpanded = true;
  bool isAddButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // 钱包组标题
          InkWell(
            onTap: () => setState(() => isExpanded = !isExpanded),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: ListTile(
              title: Text(
                widget.walletGroup.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
              ),
              trailing: AnimatedRotation(
                duration: const Duration(milliseconds: 300),
                turns: isExpanded ? 0.5 : 0,
                child: const Icon(Icons.keyboard_arrow_down),
              ),
            ),
          ),
          ClipRect(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: SizedBox(
                height: isExpanded ? null : 0,
                child: Column(
                  children: [
                    ...widget.walletGroup.accounts.map(
                      (account) => BlocBuilder<WalletCubit, WalletState>(
                        builder: (context, state) => WalletAccountItem(
                          account: account,
                          isSelected:
                              account.address == state.selectedWalletAddress,
                          onTap: () {
                            if (account.address !=
                                state.selectedWalletAddress) {
                              context
                                  .read<WalletCubit>()
                                  .selectWallet(account.address);
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: GestureDetector(
                        onTapDown: (_) =>
                            setState(() => isAddButtonPressed = true),
                        onTapUp: (_) =>
                            setState(() => isAddButtonPressed = false),
                        onTapCancel: () =>
                            setState(() => isAddButtonPressed = false),
                        onTap: () {},
                        child: AnimatedScale(
                          scale: isAddButtonPressed ? 0.95 : 1.0,
                          duration: const Duration(milliseconds: 100),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withValues(alpha: .1),
                              child: Icon(
                                Icons.add,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            title: Text(
                              S.of(context).wallet_addAccount,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
