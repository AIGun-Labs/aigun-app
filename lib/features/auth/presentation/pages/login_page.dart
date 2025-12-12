import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/language/language_cubit.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../widgets/steps/email_step_widget.dart';
import '../widgets/steps/profile_step_widget.dart';
import '../widgets/steps/success_step_widget.dart';
import '../widgets/steps/verify_code_step_widget.dart';

/// Login Page - Main page for authentication flow
///
/// Uses PageView to navigate between authentication steps:
/// 1. Email input
/// 2. Verification code
/// 3. Profile setup (for new users)
/// 4. Success (when invite code is used)
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleStepChange(AuthStep step) {
    if (!_pageController.hasClients) return;
    _pageController.jumpToPage(step.index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.currentStep != current.currentStep,
      listener: (context, state) {
        _handleStepChange(state.currentStep);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            EmailStepWidget(),
            VerifyCodeStepWidget(),
            ProfileStepWidget(),
            SuccessStepWidget(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              BlocProvider.of<LanguageCubit>(context).changeLanguage(),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          elevation: 0,
          child: Image.asset(
            'assets/images/icons/language.png',
            width: 30,
            height: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
