import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/constants.dart';
import '../../../../cubits/index.dart';
import '../../../../l10n/l10n.dart';
import '../../../../screens/send_confirm_again/widgets/send_confirm_again_content.dart';
import '../../../../shared/presentation/widgets/appbar_widget.dart';
import '../../../../themes/themes.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/loading_indicator/index.dart';

class SendConfirmAgainScreen extends StatelessWidget {
  const SendConfirmAgainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferCubit, TransferState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppbarWidget(
              title: S.of(context).transfer_confirmAgain,
            ),
            body: const SendConfirmAgainContent(),
            bottomNavigationBar: SafeArea(
              top: false,
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
                    // SizedBox(width: 16.w), // 添加固定的间距
                    16.horizontalSpace,
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
            ));
      },
    );
  }
}
