import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef FutureVoidCallback = Future<void> Function();

class CountdownButton extends StatefulWidget {
  final FutureVoidCallback onPressed;

  final int duration;

  const CountdownButton({
    super.key,
    required this.onPressed,
    this.duration = 60,
  });

  @override
  State<CountdownButton> createState() => _OtpCountdownButtonState();
}

class _OtpCountdownButtonState extends State<CountdownButton> {
  Timer? _timer;
  late int _countdown;
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _countdown = widget.duration;
    _isButtonDisabled = true;

    // 先延迟1秒，然后开始倒计时
    Timer(const Duration(seconds: 1), () {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_countdown > 0) {
          setState(() {
            _countdown--;
          });
        } else {
          setState(() {
            _isButtonDisabled = false;
          });
          _timer?.cancel();
        }
      });
    });
  }

  void _handleOnPressed() async {
    await widget.onPressed();

    if (mounted) {
      setState(() {
        startTimer();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isButtonDisabled ? null : _handleOnPressed,
      child: Text(
        _isButtonDisabled
            ? '${S.of(context).auth_resendCode}($_countdown)'
            : S.of(context).auth_resendCode,
        style: TextStyle(
            fontSize: 18.sp,
            color: _isButtonDisabled ? Colors.white : AppColors.tertiary),
      ),
    );
  }
}
