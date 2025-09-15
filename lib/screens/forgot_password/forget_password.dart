import 'package:flutter/material.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/background_with_overlay.dart';
import 'widgets/forgot_password_content.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        backgroundColor: Colors.transparent,
        leadingIconColor: Colors.white,
      ),
      body: BackgroundWithOverlay(
        child: ForgotPasswordContent(),
      ),
    );
  }
}
