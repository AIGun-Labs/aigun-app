// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_confetti/flutter_confetti.dart";
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/cubits/auth/auth_cubit.dart';
import 'package:flutter_aigun/cubits/auth/auth_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/auth/widgets/login_page_layout.dart';
import 'package:flutter_aigun/widgets/button/neon_button.dart';
import 'package:go_router/go_router.dart';

class SuccessStep extends StatefulWidget {
  const SuccessStep({super.key, required this.onNext});

  final Function(int) onNext;

  @override
  State<SuccessStep> createState() => _SuccessStepState();
}

class _SuccessStepState extends State<SuccessStep> {
  final _confettiController = ConfettiController();

  final List<String> _thanksMessages = [
    "Thanks for getting me into DogeX, my dude! Wishing you all the best.",
    "Appreciate the golden ticket, pal. I owe you one big time for this.",
    "This invite took me from zero to hero in a flash! Thanks a ton, bro!",
    "Your invite is like hitting the jackpot on steroids! My future's so bright, I gotta wear shades!",
    "The moment I got your invite, felt like I won the lottery! You call the shots from now on, boss!",
    "Is this invite a cheat code for getting rich? You're my life guru now, pinned to the top of my contacts!",
    "OMG, fam, who feels me?! My bro got me in, and I'm about to make it rain! Absolute win!",
    "This invite is legendary! You're a modern-day MVP in my book. I've got your back, always.",
    "So patrons are real! This invite sent me straight to the moon! I'm your number one fan now!",
    "Who knew one invite could turn me from a broke gamer to a VIP pass holder! Eternally grateful, my friend!",
  ];

  String selectedMessage =
      "Thanks for getting me into DogeX, my dude! Wishing you all the best.";

  void _rollDice() {
    setState(() {
      final messageId =
          DateTime.now().millisecondsSinceEpoch % _thanksMessages.length;
      context.read<AuthCubit>().updateThanksMessageId(messageId);
      selectedMessage = _thanksMessages[messageId];
    });
  }

  void createThanksMessageSuccess() {
    _confettiController.launch();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go(Routes.home, extra: NavIndex.wallet);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.createThanksMessageState.whenOrNull(
          success: () {
            createThanksMessageSuccess();
          },
        );
        state.createThanksMessageState.whenOrNull(
          failure: (failure) {
            switch (failure) {
              case CreateThanksMessageFailure.createThanksMessageFail:
                ToastUtils.showFailureToast(context,
                    message: "发送感谢语失败，两秒后自动跳转");

              case CreateThanksMessageFailure.userNotExist:
                ToastUtils.showFailureToast(context, message: "用户不存在，两秒后自动跳转");

              case CreateThanksMessageFailure.inviteCodeInvalid:
                ToastUtils.showFailureToast(context, message: "邀请码无效，两秒后自动跳转");

                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) {
                    context.go(Routes.home, extra: NavIndex.wallet);
                  }
                });
              default:
                ToastUtils.showFailureToast(context,
                    message: "发送感谢语失败，两秒后自动跳转");

                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) {
                    context.go(Routes.home, extra: NavIndex.wallet);
                  }
                });
            }
          },
        );
      },
      child: _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    return AuthPageLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildMessageCard(),
          const SizedBox(height: 20),
          _buildInvitationMessage(),
          const SizedBox(height: 12),
          _buildEnterButton(context),
        ],
      ),
    );
  }

  Widget _buildMessageCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        // borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF29ABE2), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '你对邀请人说：',
            style: TextStyle(
              fontFamily: 'Tomorrow',
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Color(0xFFF8EF00),
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            selectedMessage,
            style: const TextStyle(
              fontFamily: 'Styrene B Trial',
              fontSize: 18,
              color: Colors.white,
              letterSpacing: 1.8,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: _rollDice,
              child: Image.asset(
                'assets/images/icons/dice.png',
                width: 25,
                height: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvitationMessage() {
    return const Text(
      '恭喜，邀请码有效，你获得了算力加成奖励，并激活了间接邀请奖励！选择一句感谢邀请人的话吧',
      textAlign: TextAlign.left,
      style: TextStyle(
        // fontFamily: 'Styrene B Trial',
        fontSize: 16,
        color: Colors.white,
        letterSpacing: 3.2,
      ),
    );
  }

  Widget _buildEnterButton(BuildContext context) {
    return NeonCutCornerButton(
      onPressed: () => context
          .read<AuthCubit>()
          .createThanksMessage(() => createThanksMessageSuccess()),
      // onPressed: () {
      //   Confetti.launch(context,
      //       options:
      //           const ConfettiOptions(particleCount: 100, spread: 70, y: 0.6));
      // },
      child: Text(S.of(context).common_confirm),
    );
  }
}
