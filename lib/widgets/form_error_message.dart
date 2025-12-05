import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../enums/index.dart';
import '../l10n/l10n.dart';

class FormErrorMessage extends StatelessWidget {
  final ValidationError? error;
  final String text;

  const FormErrorMessage({
    super.key,
    this.text = '',
    this.error,
  });

  String getErrorMessage(BuildContext context) {
    switch (error) {
      case ValidationError.emailEmpty:
        return S.of(context).validation_emailEmpty;
      case ValidationError.emailInvalid:
        return S.of(context).validation_emailInvalid;
      case ValidationError.passwordEmpty:
        return S.of(context).validation_passwordEmpty;
      case ValidationError.passwordTooShort:
        return S.of(context).validation_passwordTooShort;
      case ValidationError.passwordTooSimple:
        return S.of(context).validation_passwordTooSimple;
      case ValidationError.confirmPasswordEmpty:
        return S.of(context).validation_confirmPasswordEmpty;
      case ValidationError.passwordsDoNotMatch:
        return S.of(context).validation_passwordsDoNotMatch;
      default:
        return 'Unknown error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.circle,
          size: 10.w,
          color: Colors.blueAccent,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text.isEmpty ? getErrorMessage(context) : text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}
