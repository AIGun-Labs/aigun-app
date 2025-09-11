import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_aigun/config/nav.dart";
import "package:flutter_aigun/cubits/auth/auth_cubit.dart";
import "package:flutter_aigun/cubits/language/language_cubit.dart";
import "package:flutter_aigun/routing/routes_path.dart";
import "package:flutter_aigun/screens/auth/auth_steps.dart";
import "package:flutter_aigun/screens/auth/widgets/steps/email_step.dart";
import "package:flutter_aigun/screens/auth/widgets/steps/profile_step.dart";
import "package:flutter_aigun/screens/auth/widgets/steps/success_step.dart";
import "package:flutter_aigun/screens/auth/widgets/steps/verify_code_step.dart";
import "package:go_router/go_router.dart";

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

    // 如果是最后一步，跳转到首页的钱包页面
    if (nextStep == AuthStep.success.stepIndex)
      return context.go(Routes.home, extra: NavIndex.wallet);

    // 否则跳转到下一个步骤页面
    _pageController.jumpToPage(nextStep);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // 禁止滑动
            children: [
              EmailStep(onNext: _handleNextStep),
              VerifyCodeStep(onNext: _handleNextStep),
              ProfileStep(onNext: _handleNextStep),
              SuccessStep(onNext: _handleNextStep),
            ]),
        floatingActionButton: FloatingActionButton(
          // 切换语言按钮
          onPressed: () =>
              context.read<LanguageCubit>().changeLanguage(context),
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
