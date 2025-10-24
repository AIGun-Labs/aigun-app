import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/send_confirm_again/widgets/send_confirm_again_content.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/bottom_button.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/loading_indicator/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/constants.dart';

class SendConfirmAgainScreen extends StatelessWidget {
  const SendConfirmAgainScreen({super.key});

  Future<void> _handleSend(BuildContext context) async {
    final transferCubit = BlocProvider.of<TransferCubit>(context);
    final wallet = BlocProvider.of<WalletCubit>(context).state.wallets.first;

    final state = transferCubit.state;

    final walletAddress = wallet.addresses!
        .firstWhere(
            (address) => address.chainId == state.selectedToken?.chainId)
        .address!;
    // 调用转账接口
    transferCubit.transferToken(
      state.selectedToken!.chainId,
      walletAddress,
      state.toAddress,
      state.amount,
      state.selectedToken?.address ?? "",
      (success) => success ? context.pushNamed(RouteNames.sendToken) : null,
    );
  }

// 处理风控挑战
  void _handleRiskChallenge(BuildContext context, TransferState state) {
    state.riskChallenge.whenOrNull(
      captcha: (captcha) async {
        // final String? result = await CaptchaDialog.show(
        //   context,
        //   base64Image: captcha?.masterImage ?? "",
        //   thumbnailBase64Image: captcha?.thumbImage ?? "",
        // );

        // if (result != null) {
        //   getIt<TransferCubit>()
        //       .transferTokenWithCaptchaChallenge(captcha?.key ?? "", result);
        // }
      },
      sms: (sms) async {
        // // 处理短信验证码
        // final String? result = await SmsDialog.show(context, sms?.email);

        // if (result != null) {
        //   getIt<TransferCubit>().transferTokenWithSmsChallenge(result);
        // }
      },
    );

    // state.transferStatus.whenOrNull(
    //   failure: () {
    //     showSimpleToast("转账失败，请稍后重试");
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransferCubit, TransferState>(
      listener: (context, state) => _handleRiskChallenge(context, state),
      child: BlocBuilder<TransferCubit, TransferState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: S.of(context).transfer_confirmAgain,
              onPressed: () {
                context.goNamed(RouteNames.intel);
              },
            ),
            body: const SendConfirmAgainContent(),
            bottomNavigationBar: BottomButton(
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        context.pop();
                      },
                      text: S.of(context).common_cancel,
                      textColor: AppColors.textPrimary(context),
                      backgroundColor: AppColors.background(context),
                      borderSide: const BorderSide(color: Color(0xFFB2B2B2)),
                      height: 50.h,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(width: 16.w), // 添加固定的间距
                  Expanded(
                    child: CustomButton(
                        onPressed: () => _handleSend(context),
                        text: S.of(context).common_confirm,
                        textColor: AppColors.background(context),
                        backgroundColor: AppColors.foreground(context),
                        fontSize: 16.sp,
                        height: 50.h,
                        child: state.transferStatus.whenOrNull(
                            loading: () => const LoadingIndicator(
                                  size: 20,
                                  color: Colors.white,
                                ))),
                  ),

                  // Flexible(
                  //   child: CustomButton(
                  //     onPressed: () => showDialog(
                  //         context: context,
                  //         builder: (context) => Container(
                  //               width: 300.w,
                  //               height: 220.h,
                  //               child: Text("123"),
                  //             )),
                  //     text: S.of(context).common_confirm,
                  //     textColor: Colors.white,
                  //     backgroundColor: Colors.black,
                  //   ),
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
