import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/widgets/form_error_message.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/widgets/bottom_logo.dart';

import 'title_section.dart';
import 'email_input.dart';
import 'send_code_button.dart';

class ForgotPasswordContent extends StatelessWidget {
  const ForgotPasswordContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0.w, 0.h, 16.0.w, 10.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleSection(),
          SizedBox(height: 20.h),
          const EmailInput(),
          SizedBox(height: 20.h),
          const SendCodeButton(),
          SizedBox(height: 20.h),
          BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
            builder: (context, state) {
              if (state.emailError != null) {
                return FormErrorMessage(
                  error: state.emailError,
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const Spacer(),
          const BottomLogo(),
        ],
      ),
    );
  }
}
