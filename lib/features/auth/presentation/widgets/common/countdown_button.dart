import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../themes/themes.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/auth/auth_state.dart';

/// Countdown Button - Button for resending verification code with countdown
class CountdownButton extends StatefulWidget {
  final VoidCallback onPressed;

  const CountdownButton({
    super.key,
    required this.onPressed,
  });

  @override
  State<CountdownButton> createState() => _CountdownButtonState();
}

class _CountdownButtonState extends State<CountdownButton> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start timer to update UI every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final canResend = state.canResendCode;
        final remaining = state.remainingSeconds;

        return GestureDetector(
          onTap: canResend ? widget.onPressed : null,
          child: Text(
            canResend
                ? S.of(context).auth_resendCode
                : '${S.of(context).auth_resendCode}($remaining)',
            style: TextStyle(
              fontFamily: 'Zeroes1',
              fontSize: 18.sp,
              color: canResend ? AppColors.tertiary : Colors.white,
            ),
          ),
        );
      },
    );
  }
}
