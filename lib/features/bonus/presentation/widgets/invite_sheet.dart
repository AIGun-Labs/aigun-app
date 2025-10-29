import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/clipboard.dart';

class InviteSheet extends StatefulWidget {
  const InviteSheet({super.key});

  @override
  State<InviteSheet> createState() => _InviteSheetState();
}

class _InviteSheetState extends State<InviteSheet> {
  final TextEditingController _inviteCodeController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void dispose() {
    _inviteCodeController.dispose();
    super.dispose();
  }

  Future<void> _handlePaste() async {
    final pastedText = await ClipboardUtils.paste();
    if (pastedText.isNotEmpty) {
      setState(() {
        _inviteCodeController.text = pastedText;
        _errorMessage = null;
      });
    }
  }

  void _handleBind() {
    final inviteCode = _inviteCodeController.text.trim();

    if (inviteCode.isEmpty) {
      setState(() {
        _errorMessage = S.of(context).inviteCodeInputError;
      });
      return;
    }

    // TODO: 实现邀请码绑定逻辑
    // 这里需要调用API进行邀请码验证和绑定
    // 暂时模拟一个验证过程
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // 模拟API调用
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        // 这里应该根据API返回结果判断
        // 暂时显示错误信息作为示例
        setState(() {
          _isLoading = false;
          _errorMessage = S.of(context).inviteCodeInputError;
        });

        // 成功的情况：
        // ToastUtils.showSuccessToast(context, message: '绑定成功');
        // Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          8.verticalSpace,
          Center(
            child: Container(
              width: 41.w,
              height: 3.h,
              decoration: BoxDecoration(
                color: AppColors.textTertiary(context),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          14.verticalSpace,

          // 标题
          Text(
            S.of(context).bindReferrerInviteCode,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textPrimary(context),
            ),
          ),

          6.verticalSpace,

          // 副标题
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textPrimary(context),
              ),
              children: [
                TextSpan(text: S.of(context).earn),
                const TextSpan(text: ' '),
                const TextSpan(
                  text: '100 \$GOLD',
                  style: TextStyle(
                    color: AppColors.quaternary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(text: ' '),
                TextSpan(text: S.of(context).reward),
              ],
            ),
          ),

          25.verticalSpace,
          TextField(
            controller: _inviteCodeController,
            decoration: InputDecoration(
              hintText: S.of(context).inputInviteCode,
              hintStyle: TextStyle(
                color: AppColors.textQuaternary(context),
                fontSize: 16.sp,
                height: 1.4,
              ),
              contentPadding: EdgeInsets.fromLTRB(16.w, 14.h, 0.w, 14.h),
              // 不用 suffixIcon，改用 suffix
              suffixIcon: GestureDetector(
                onTap: _handlePaste,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Icon(
                    Icons.copy,
                    color: AppColors.textTertiary(context),
                    size: 20.w,
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _errorMessage != null
                      ? Colors.red
                      : AppColors.border(context),
                  width: 1.r,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _errorMessage != null
                      ? Colors.red
                      : AppColors.border(context),
                  width: 1.r,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      _errorMessage != null ? Colors.red : AppColors.quaternary,
                  width: 1.r,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            onChanged: (value) {
              if (_errorMessage != null) {
                setState(() {
                  _errorMessage = null;
                });
              }
            },
          ),
          6.verticalSpace,
          // 说明文字
          Text(
            S.of(context).goldDesc,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textTertiary(context),
            ),
          ),
          10.verticalSpace,
          // 错误提示
          Text(
            S.of(context).inviteCodeInputError,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.secondary,
            ),
          ),

          180.verticalSpace,
          // 绑定按钮
          SizedBox(
            height: 45.h,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleBind,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.foreground(context),
                foregroundColor: AppColors.background(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                elevation: 0,
              ),
              child: _isLoading
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      S.of(context).bind,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
            ),
          ),
          20.verticalSpace,
        ],
      ),
    ));
  }
}
