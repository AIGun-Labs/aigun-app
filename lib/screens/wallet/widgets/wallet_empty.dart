import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubits/index.dart';
import '../../../l10n/l10n.dart';
import '../../../widgets/button.dart';
import '../../../widgets/input.dart';
import '../../../widgets/loading_indicator/index.dart';

class WalletEmpty extends StatefulWidget {
  const WalletEmpty({super.key});

  @override
  State<WalletEmpty> createState() => _WalletEmptyState();
}

class _WalletEmptyState extends State<WalletEmpty> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        Text(S.of(context).branding_createWalletDescription),
        SizedBox(height: 15.w),
        BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
          return CustomButton(
            width: 100.w,
            height: 40.w,
            fontSize: 14.sp,
            textColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
            // onPressed: state.isCreating
            //     ? null
            //     : () {
            //         context.read<WalletCubit>().createWallet(
            //               context
            //                   .read<ChainCubit>()
            //                   .state
            //                   .chains
            //                   .first
            //                   .chainType,
            //             );
            //       },
            onPressed: () {
              showAdaptiveDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    "Create Wallet",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomInput(
                        maxLength: 6,
                        fontSize: 14.sp,
                        controller: controller,
                        // hintText: S.of(context).wallet_passwordHint,
                        hintText: "Payment Pin",
                        isPassword: true,
                        height: 50.h,
                        counterText: "",
                        onChanged: (value) {
                          // 处理密码输入变化
                        },
                      ),
                      Text(
                        "A 6 digit payment password that cannot be incremented or decremented",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              // 处理创建钱包逻辑
                              // Navigator.of(context).pop();
                              await context
                                  .read<WalletCubit>()
                                  .createWalletUser(controller.text);

                              // 这里可以调用创建钱包的方法
                              // context.read<WalletCubit>().createWallet(...);
                            },
                            child: Row(children: [
                              Text(
                                "Confirm",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ])),
                      ],
                    )
                  ],
                ),
              );
            },
            child: state.isCreating
                ? LoadingIndicator(
                    size: 20.w,
                    color: Colors.white,
                  )
                : Text(S.of(context).branding_createWallet),
          );
        }),
      ],
    );
  }
}
