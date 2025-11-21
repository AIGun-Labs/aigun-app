import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/constants.dart';
import '../../cubits/index.dart';
import '../../l10n/l10n.dart';
import '../../themes/themes.dart';
import '../../widgets/appbar.dart';
import '../../widgets/bottom_button.dart';
import '../../widgets/button.dart';
import '../../widgets/loading_indicator/index.dart';
import 'widgets/send_confirm_again_content.dart';

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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
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
                          ),
              )),
        );
      },
    );
  }
}
