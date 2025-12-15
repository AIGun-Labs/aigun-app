import 'package:flutter/material.dart';

import '../../core/service_locator.dart';
import '../../features/language/presentation/controllers/locale_controller.dart';
import 'widgets/steps/email_step.dart';
import 'widgets/steps/profile_step.dart';
import 'widgets/steps/success_step.dart';
import 'widgets/steps/verify_code_step.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 使用 PageView 来实现页面切换
  final PageController _pageController = PageController();

  void _handleNextStep(int nextStep) {
    if (!_pageController.hasClients) return;
    _pageController.jumpToPage(nextStep);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // 禁止滑动
        children: [
          EmailStep(onNext: _handleNextStep),
          VerifyCodeStep(onNext: _handleNextStep),
          ProfileStep(onNext: _handleNextStep),
          SuccessStep(onNext: _handleNextStep),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // 切换语言按钮
        onPressed: () => getIt<LocaleController>().changeWithZhAndEn(),
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
    );
  }
}
