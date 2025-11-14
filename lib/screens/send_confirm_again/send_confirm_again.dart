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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferCubit, TransferState>(
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          appBar: CustomAppBar(
            title: S.of(context).transfer_confirmAgain,
            onPressed: () {
              context.pop();
            },
          ),
          body: const SendConfirmAgainContent(),
          bottomNavigationBar: SafeArea(
              child: BottomButton(
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
                      onPressed: () =>
                          context.read<TransferCubit>().transferToken(() {
                            context.pushNamed(RouteNames.sendToken);
                          }),
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
              ],
            ),
          )),
        ));
      },
    );
  }
}
