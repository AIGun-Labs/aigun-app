import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/service_locator.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/clipboard.dart';
import '../cubits/invite_cubit.dart';

class InviteSheet extends StatefulWidget {
  const InviteSheet({super.key});

  @override
  State<InviteSheet> createState() => _InviteSheetState();
}

class _InviteSheetState extends State<InviteSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _inviteCodeController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void dispose() {
    _inviteCodeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _handlePaste() async {
    final pastedText = await ClipboardUtils.paste();
    if (pastedText.isEmpty) return;
    setState(() {
      _inviteCodeController.text = pastedText.trim();
      _errorMessage = null;
    });
  }

  Future<void> _handleBind() async {
    if (_isLoading) return;

    final s = S.of(context);
    final inviteCode = _inviteCodeController.text.trim();

    if (inviteCode.isEmpty) {
      setState(() => _errorMessage = s.inviteCodeInputError);
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await getIt<InviteCubit>().bindInviteCode(inviteCode);

      if (!mounted) return;

      _focusNode.unfocus();
      ToastUtils.showSuccessToast(context, message: s.bindSuccess);
      Navigator.maybePop(context);
    } catch (e) {
      setState(() => _errorMessage =
          e.toString().isEmpty ? s.inviteCodeInputError : e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  OutlineInputBorder _border(BuildContext context, {required bool focused}) {
    final Color color = _errorMessage != null
        ? Colors.red
        : (focused ? AppColors.quaternary : AppColors.border(context));
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.r),
      borderRadius: BorderRadius.circular(10.r),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  s.bindReferrerInviteCode,
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
                      TextSpan(text: s.earn),
                      const TextSpan(text: ' '),
                      const TextSpan(
                        text: '100 \$GOLD',
                        style: TextStyle(
                          color: AppColors.quaternary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(text: s.reward),
                    ],
                  ),
                ),

                25.verticalSpace,

                // Form(child: null,),
                Focus(
                    onFocusChange: (_) => setState(() {}),
                    child: TextField(
                      controller: _inviteCodeController,
                      focusNode: _focusNode,
                      enabled: !_isLoading,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _handleBind(),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        UpperCaseTextFormatter(),
                      ],
                      decoration: InputDecoration(
                        hintText: s.inputInviteCode,
                        hintStyle: TextStyle(
                          color: AppColors.textQuaternary(context),
                          fontSize: 16.sp,
                          height: 1.4,
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(16.w, 14.h, 0.w, 14.h),
                        // 不用 suffixIcon，改用 suffix
                        suffixIcon: GestureDetector(
                          onTap: !_isLoading ? _handlePaste : null,
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.w),
                            child: Icon(
                              Icons.copy,
                              color: AppColors.textTertiary(context),
                              size: 20.w,
                            ),
                          ),
                        ),
                        border: _border(context, focused: false),
                        enabledBorder: _border(context, focused: false),
                        focusedBorder: _border(context, focused: true),
                      ),
                      onChanged: (value) {
                        if (_errorMessage != null) {
                          setState(() {
                            _errorMessage = null;
                          });
                        }
                      },
                    )),
                6.verticalSpace,
                // 说明文字
                Text(
                  s.goldDesc,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textTertiary(context),
                  ),
                ),
                10.verticalSpace,
                // 错误提示
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.secondary,
                    ),
                  ),

                100.verticalSpace,
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
                            width: 24.w,
                            height: 24.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            s.bind,
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                  ),
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ));
  }
}

/// 将输入自动转为大写（如无需要可移除）
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}
