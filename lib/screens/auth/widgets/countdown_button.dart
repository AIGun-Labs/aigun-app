import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/auth/auth_cubit.dart';
import 'package:flutter_aigun/cubits/auth/auth_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef FutureVoidCallback = Future<void> Function();

class CountdownButton extends StatefulWidget {
  final FutureVoidCallback onPressed;

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
    // 启动定时器每秒更新一次UI
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

  void _handleOnPressed() async {
    await widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final canResend = state.canResendCode;
        final remaining = state.remainingSeconds;

        return GestureDetector(
          onTap: canResend ? _handleOnPressed : null,
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
