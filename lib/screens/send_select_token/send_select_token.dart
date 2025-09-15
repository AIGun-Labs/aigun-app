import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/send_select_token/cubit/send_select_token_cubit.dart';
import 'package:flutter_aigun/screens/send_select_token/cubit/send_select_token_state.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/button/add_token_button.dart';
import 'package:flutter_aigun/widgets/token_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'widgets/search_input.dart';

/// 转出-选币
class SendSelectTokenScreen extends StatelessWidget {
  const SendSelectTokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    final showAddress = extra?['showAddress'] as bool? ?? false;
    final replace = extra?['replace'] as bool? ?? false;

    return Scaffold(
      appBar: CustomAppBar(
          title: S.of(context).transfer_sendToken,
          onPressed: () {
            //   if (replace) {
            //     context.replace(Routes.sendTokenDetail, extra: {
            //       'showAddress': showAddress,
            //       'replace': replace,
            //     });
            //   } else {
            //     context.pop();
            //   }
            context.go(Routes.home);
          }),
      body: BlocProvider(
        create: (context) => SendSelectTokenCubit(),
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
                  final filterToken =
                      context.read<SendSelectTokenCubit>().getTokens(tokens);

                  return Column(
                    children: [
                      TokenList(
                        showAddress: showAddress,
                        replace: replace,
                        tokens: filterToken,
                        isLoading: balanceState.isLoading,
                      ),
                      // 提示文本
                      // SizedBox(height: 16.h),
                      // Text(
                      //   "Couldn't find your token?",
                      //   style: TextStyle(
                      //     color: Colors.grey[600],
                      //     fontSize: 16.sp,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                      // SizedBox(height: 8.h),
                      // Text(
                      //   "Tap the button below to add.",
                      //   style: TextStyle(
                      //     color: Colors.grey[500],
                      //     fontSize: 14.sp,
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                      // SizedBox(height: 24.h),

                      const AddTokenButton()
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildSearchInput(BuildContext context) {
  //   return CustomInput(
  //     isPassword: false,
  //     hintText: S.of(context).tokenName,
  //     fontSize: 16.sp,
  //     controller: TextEditingController(),
  //     height: 50.h,
  //     fillColor: const Color.fromRGBO(209, 209, 209, 0.25),
  //     borderRadius: BorderRadius.circular(20),
  //     prefixIcon: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 10.w),
  //       child: SvgPicture.asset(
  //         'assets/images/icons/icons8-search.svg',
  //         width: 20.w,
  //         height: 20.w,
  //         colorFilter: ColorFilter.mode(
  //           Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
  //           BlendMode.srcIn,
  //         ),
  //       ),
  //     ),
  //     borderSide: BorderSide.none,
  //     enabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(20),
  //       borderSide: BorderSide.none,
  //     ),
  //   );
  // }

  // Widget _buildTokenList(BuildContext context) {
  //   return Expanded(
  //     child: ListView.builder(
  //       itemCount: 6, // 假设有6个代币
  //       itemBuilder: (context, index) {
  //         return index == 5
  //             ? _buildAddTokenSection(context)
  //             : _buildTokenCard(context);
  //       },
  //     ),
  //   );
  // }

  // Widget _buildTokenCard(BuildContext context) {
  //   return TokenCard(
  //     tokenAsset: tokenAsset,
  //     showAddress: false,
  //     onTap: () {
  //       context.push(Routes.sendTokenDetail);
  //     },
  //   );
  // }

  // Widget _buildAddTokenSection(BuildContext context) {
  //   return Column(
  //     children: [
  //       _buildTokenCard(context),
  //       SizedBox(height: 20.h),
  //       Text(
  //         S.of(context).couldNotFindToken,
  //         style: TextStyle(
  //           fontSize: 16.sp,
  //           color: Theme.of(context).textTheme.bodySmall?.color,
  //         ),
  //       ),
  //       SizedBox(height: 5.h),
  //       Text(
  //         S.of(context).tapToAddToken,
  //         style: TextStyle(
  //           fontSize: 16.sp,
  //           color: Theme.of(context).textTheme.bodySmall?.color,
  //         ),
  //       ),
  //       SizedBox(height: 10.h),
  //       _buildAddTokenButton(context),
  //     ],
  //   );
  // }

//   Widget _buildAddTokenButton(BuildContext context) {
//     return CustomButton(
//       onPressed: () {
//         context.push(Routes.addToken);
//       },
//       type: ButtonType.outlined,
//       width: 126.w,
//       height: 40.h,
//       child: Text(
//         S.of(context).addToken,
//         style: TextStyle(
//           fontSize: 14.sp,
//         ),
//       ),
//     );
//   }
}
