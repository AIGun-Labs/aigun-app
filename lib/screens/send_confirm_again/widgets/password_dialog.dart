import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordDialog extends StatefulWidget {
  const PasswordDialog({super.key, this.maxLength, this.counterText = ""});

  final int? maxLength;
  final String counterText;

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.of(context).form_enterPassword,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: TextField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        maxLength: widget.maxLength,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
        decoration: InputDecoration(
          hintText: S.of(context).form_password,
          counterText: widget.counterText,
          hintStyle: TextStyle(
            color: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.color
                ?.withValues(alpha: .5),
          ),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.of(context).common_cancel),
        ),
        TextButton(
          onPressed: () {
            if (_passwordController.text.isNotEmpty) {
              Navigator.of(context).pop(_passwordController.text);
            }
          },
          child: Text(S.of(context).common_confirm),
        ),
      ],
    );
  }
}
