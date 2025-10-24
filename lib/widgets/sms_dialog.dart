import 'package:flutter/material.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/input/opt_input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmsDialog {
  static Future<String?> show(
    BuildContext context,
    String? email,
  ) {
    return showDialog<String?>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return SmsDialogContent(email: email ?? "");
        });
  }
}

class SmsDialogContent extends StatefulWidget {
  const SmsDialogContent({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<SmsDialogContent> createState() => _SmsDialogContentState();
}

class _SmsDialogContentState extends State<SmsDialogContent> {
  void _cancel() {
    Navigator.of(context).pop(null);
  }

  void _confirm() {
    Navigator.of(context).pop(_codeController.text);
  }

  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "请输入邮箱验证码",
        style: TextStyle(color: Colors.black, fontSize: 16.sp),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      content: SizedBox(
        width: 300,
        height: 50,
        child: OTPInput(
          codeLength: 6,
          inputWidth: 100,
          inputHeight: 50,
          borderColor: Colors.grey,
          focusedBorderColor: Colors.blue,
          onChanged: (value) {
            _codeController.text = value;
          },
          onCompleted: (value) {
            _confirm();
          },
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Row(
            spacing: 20.w,
            children: [
              Flexible(
                  child: CustomButton(
                onPressed: _cancel,
                text: '取消',
                textColor: Colors.black,
                backgroundColor: Colors.white,
                borderSide: const BorderSide(color: Color(0xFFB2B2B2)),
                height: 50.h,
                fontSize: 16.sp,
              )),
              Flexible(
                child: CustomButton(
                  onPressed: _confirm,
                  text: '确定',
                  textColor: Colors.white,
                  backgroundColor: Colors.black,
                  height: 50.h,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
