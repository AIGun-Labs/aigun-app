import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/language/language_cubit.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_actions.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/language.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_aigun/widgets/user/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
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
            const UserWalletProfile(),
            const WalletActions(),
            Divider(
              color: AppColors.border(context),
            ),
            const Expanded(
              child: WalletList(),
            ),
            // ElevatedButton(onPressed: (), child: Text(S.of(context).logout))
            // ElevatedButton(
            //     onPressed: () {
            //       context.read<LanguageCubit>().changeLanguage(context);
            //     },
            //     child: Text(S.of(context).logout))
          ],
        ),
      ),
    );
  }
}

// class WalletScreen extends StatelessWidget {
//   const WalletScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isLoggedIn = context.select(
//       (UserCubit cubit) => cubit.state.isLoggedIn,
//     );

//     final isLoading = context.select(
//       (UserCubit cubit) => cubit.state.isLoading,
//     );

//     // 如果用户没有登录，则实现提示用户登录界面
//     if (!isLoggedIn) {
//       return const WalletNotLoggedIn();
//     }

// // 加载动画
//     if (isLoading) {
//       return const LoadingIndicator();
//     }

//     return SafeArea(
//       child: BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
//         return Column(
//           children: [
//             const WalletProfile(),
//             SizedBox(height: 12.w),
//             // 使用Expanded确保WalletList可以占用剩余空间
//             Expanded(child: _buildWalletList(context)),

//             Padding(
//                 padding: EdgeInsets.all(8.w),
//                 child: PrimaryButton(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
//                     backgroundColor: AppColors.card(context),
//                     onPressed: () {
//                       context.read<UserCubit>().logout();
//                     },
//                     label: Text(S.of(context).logout),
//                     icon: const Icon(Icons.logout)))
//           ],
//         );
//       }),
//     );
//   }

//   Widget _buildWalletList(BuildContext context) {
//     return BlocBuilder<WalletCubit, WalletState>(
//       builder: (context, state) {
//         if (state.isLoading) {
//           return Center(
//             child: Padding(
//               padding: EdgeInsets.only(top: 100.w),
//               child: LoadingIndicator(
//                 color: Theme.of(context).textTheme.bodyMedium!.color!,
//               ),
//             ),
//           );
//         }

//         // 显示错误状态
//         if (state.errorMessage.isNotEmpty) {
//           return WalletError(errorMessage: state.errorMessage);
//         }

//         // 钱包列表不为空时，显示钱包列表
//         return const WalletList();
//       },
//     );
//   }
// }
