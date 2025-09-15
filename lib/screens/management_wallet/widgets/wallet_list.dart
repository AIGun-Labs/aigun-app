import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/wallet_group/wallet_group.dart';
import 'wallet_group_item.dart';

class WalletList extends StatelessWidget {
  const WalletList({super.key});

  // 模拟数据
  List<WalletGroup> get mockWalletGroups => [
        const WalletGroup(
          name: 'Wallet A',
          accounts: [
            WalletAccount(
              name: 'Account 1',
              address: '0x1234...5678',
              balance: '1000 USDT',
            ),
            WalletAccount(
              name: 'Account 2',
              address: '0x8765...4321',
              balance: '500 USDT',
            ),
          ],
        ),
        const WalletGroup(
          name: 'Wallet B',
          accounts: [
            WalletAccount(
              name: 'Account 3',
              address: '0x2468...1357',
              balance: '750 USDT',
            ),
          ],
        ),
        const WalletGroup(
          name: 'Wallet C',
          accounts: [
            WalletAccount(
              name: 'Account 3',
              address: '0x2468...1357',
              balance: '750 USDT',
            ),
          ],
        ),
        const WalletGroup(
          name: 'Wallet D',
          accounts: [
            WalletAccount(
              name: 'Account 3',
              address: '0x2468...1357',
              balance: '750 USDT',
            ),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mockWalletGroups.length,
      separatorBuilder: (context, index) => Padding(
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w, top: 30.h, bottom: 20.h),
        child: Divider(
          height: 1,
          thickness: 1,
          color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
        ),
      ),
      itemBuilder: (context, index) => WalletGroupItem(
        walletGroup: mockWalletGroups[index],
      ),
    );
  }
}
