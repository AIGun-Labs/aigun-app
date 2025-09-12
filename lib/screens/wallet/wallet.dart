import 'package:flutter/material.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_actions.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/user/index.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_list.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_profile.dart';
import 'package:flutter_aigun/widgets/user/widgets/user_profile_with_search_bar.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileWithSearchBar(),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const UserWalletProfile(),
                  const WalletActions(),
                  Divider(
                    color: AppColors.border(context),
                  ),
                  const WalletList(),
                  const WalletList(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
