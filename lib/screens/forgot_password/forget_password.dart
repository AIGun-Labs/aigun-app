import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/screens/forgot_password/widgets/unregistered_bottom_sheet.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/background_with_overlay.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/forgot_password_content.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        backgroundColor: Colors.transparent,
        leadingIconColor: Colors.white,
      ),
      body: BackgroundWithOverlay(
        child: const ForgotPasswordContent(),
      ),
    );
  }
}
