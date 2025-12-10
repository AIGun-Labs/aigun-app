import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../widgets/button/neon_button.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/auth/auth_state.dart';
import '../common/auth_page_layout.dart';

/// Success Step Widget - Final step of authentication flow
///
/// Shows success message when user registers with an invite code.
/// Allows user to send a thank you message to the inviter.
class SuccessStepWidget extends StatelessWidget {
  const SuccessStepWidget({super.key});

  static const _thanksMessageKeys = [
    'inviteSuccessMessage1',
    'inviteSuccessMessage2',
    'inviteSuccessMessage3',
    'inviteSuccessMessage4',
    'inviteSuccessMessage5',
    'inviteSuccessMessage6',
    'inviteSuccessMessage7',
    'inviteSuccessMessage8',
    'inviteSuccessMessage9',
    'inviteSuccessMessage10',
  ];

  List<String> _getThanksMessages(S s) {
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          previous.thanksMessageIndex != current.thanksMessageIndex ||
          previous.isLoading != current.isLoading ||
          previous.currentStep != current.currentStep ||
          previous.inviteCode != current.inviteCode,
      builder: (context, state) {
        final messages = _getThanksMessages(S.of(context));

        return AuthPageLayout(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _MessageCard(
                message: messages[state.thanksMessageIndex],
                onRollDice: () =>
                    BlocProvider.of<AuthCubit>(context).randomizeThanksMessage(
                      totalMessages: _thanksMessageKeys.length,
                    ),
              ),
              20.verticalSpace,
              _InvitationMessage(),
              12.verticalSpace,
              _ConfirmButton(
                isLoading: state.isLoading,
                onPressed: () => BlocProvider.of<AuthCubit>(
                  context,
                ).submitThanksAndNavigate(),
              ),
              20.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}

class _MessageCard extends StatelessWidget {
  final String message;
  final VoidCallback onRollDice;

  const _MessageCard({required this.message, required this.onRollDice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
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
          10.verticalSpace,
          Text(
            message,
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
              onTap: onRollDice,
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
}

class _InvitationMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).inviteSuccess,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 16.sp,
        color: Colors.white,
        letterSpacing: 3.2,
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _ConfirmButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return NeonCutCornerButton(
      isLoading: isLoading,
      onPressed: onPressed,
      child: Row(
        children: [
          Text(
            S.of(context).common_confirm,
            style: TextStyle(
              fontFamily: 'Zeroes1',
              letterSpacing: 2,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          15.horizontalSpace,
          if (!isLoading)
            SvgPicture.asset(
              // 'assets/images/icons/arrow-right-outline.svg',
              Assets.images.icons.arrowRightOutline,
              width: 18.w,
              height: 18.h,
            ),
        ],
      ),
    );
  }
}
