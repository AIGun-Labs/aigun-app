import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/constants.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../utils/toast.dart';
import '../../../../../widgets/button/neon_button.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/auth/auth_state.dart';
import '../common/auth_page_layout.dart';

/// Success Step Widget - Final step of authentication flow
///
/// Shows success message when user registers with an invite code.
/// Allows user to send a thank you message to the inviter.
class SuccessStepWidget extends StatefulWidget {
  const SuccessStepWidget({super.key});

  @override
  State<SuccessStepWidget> createState() => _SuccessStepWidgetState();
}

class _SuccessStepWidgetState extends State<SuccessStepWidget> {
  int _selectedMessageIndex = 0;
  bool _isSubmitting = false;

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

  void _rollDice() {
    setState(() {
      final messages = _thanksMessages(S.of(context));
      _selectedMessageIndex =
          DateTime.now().millisecondsSinceEpoch % messages.length;
    });
  }

  Future<void> _handleConfirm(BuildContext context) async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      await context.read<AuthCubit>().submitThanksMessage(_selectedMessageIndex);
      if (mounted) {
        // Navigate to wallet after a short delay
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            context.goNamed(RouteNames.wallet);
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ToastUtils.showFailureToast(
          context,
          message: S.of(context).createThanksMessageFail,
        );
        // Navigate to wallet anyway after error
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            context.goNamed(RouteNames.wallet);
          }
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return AuthPageLayout(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildMessageCard(context),
              20.verticalSpace,
              _buildInvitationMessage(context),
              12.verticalSpace,
              _buildConfirmButton(context),
              20.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageCard(BuildContext context) {
    final messages = _thanksMessages(S.of(context));
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
            messages[_selectedMessageIndex],
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

  Widget _buildInvitationMessage(BuildContext context) {
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

  Widget _buildConfirmButton(BuildContext context) {
    return NeonCutCornerButton(
      isLoading: _isSubmitting,
      onPressed: () => _handleConfirm(context),
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
          if (!_isSubmitting)
            SvgPicture.asset(
              'assets/images/icons/arrow-right-outline.svg',
              width: 18.w,
              height: 18.h,
            ),
        ],
      ),
    );
  }
}
