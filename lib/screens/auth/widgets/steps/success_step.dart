// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/constants.dart';
import '../../../../cubits/auth/auth_cubit.dart';
import '../../../../cubits/auth/auth_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../utils/toast.dart';
import '../../../../widgets/button/neon_button.dart';
import '../login_page_layout.dart';

class SuccessStep extends StatefulWidget {
  const SuccessStep({super.key, required this.onNext});

  final Function(int) onNext;

  @override
  State<SuccessStep> createState() => _SuccessStepState();
}

class _SuccessStepState extends State<SuccessStep> {
  List<String> _thanksMessages(S s) {
    return [
      s.inviteSuccessMessage1,
      s.inviteSuccessMessage2,
      s.inviteSuccessMessage3,
      s.inviteSuccessMessage4,
      s.inviteSuccessMessage5,
      s.inviteSuccessMessage6,
      s.inviteSuccessMessage7,
      s.inviteSuccessMessage8,
      s.inviteSuccessMessage9,
      s.inviteSuccessMessage10,
    ];
  }

  int selectedMessageIndex = 0;

  void _rollDice() {
    setState(() {
      final messageId = DateTime.now().millisecondsSinceEpoch %
          _thanksMessages(S.of(context)).length;
      context.read<AuthCubit>().updateThanksMessageId(messageId.toInt());
      selectedMessageIndex = messageId;
    });
  }

  void createThanksMessageSuccess() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.goNamed(RouteNames.wallet);
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
                    message: S.of(context).createThanksMessageFail);

              case CreateThanksMessageFailure.userNotExist:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).userNotExistToJump);

              case CreateThanksMessageFailure.inviteCodeInvalid:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).inviteCodeInvalidToJump);

                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) {
                    context.goNamed(RouteNames.wallet);
                  }
                });
              default:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).unknownErrorToJump);

                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) {
                    context.goNamed(RouteNames.wallet);
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
          20.verticalSpace,
          _buildInvitationMessage(),
          12.verticalSpace,
          _buildEnterButton(context),
          20.verticalSpace
        ],
      ),
    );
  }

  Widget _buildMessageCard() {
    final messages = _thanksMessages(S.of(context));
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
          Text(
            S.of(context).inviteSuccessDesc,
            style: const TextStyle(
              fontFamily: 'Tomorrow',
              fontWeight: FontWeight.w700,
              fontSize: 18,
              height: 0.8,
              color: Color(0xFFF8EF00),
              letterSpacing: 1.8,
            ),
          ),
          // const SizedBox(height: 10),
          10.verticalSpace,
          Text(
            messages[selectedMessageIndex],
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
    return Text(
      S.of(context).inviteSuccess,
      textAlign: TextAlign.left,
      style: TextStyle(
        // fontFamily: 'Styrene B Trial',
        fontSize: 16.sp,
        color: Colors.white,
        letterSpacing: 3.2,
      ),
    );
  }

  Widget _buildEnterButton(BuildContext context) {
    final isLoading = context
        .watch<AuthCubit>()
        .state
        .createThanksMessageState
        .maybeWhen(loading: () => true, orElse: () => false);
    return NeonCutCornerButton(
      onPressed: () => context.read<AuthCubit>().createThanksMessage(),
      child: Row(
        children: [
          Text(
            S.of(context).common_confirm,
            style: TextStyle(
                fontFamily: "Zeroes1",
                letterSpacing: 2,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
          15.horizontalSpace,
          if (!isLoading)
            SvgPicture.asset(
              "assets/images/icons/arrow-right-outline.svg",
              width: 18.w,
              height: 18.h,
            )
        ],
      ),
    );
  }
}
