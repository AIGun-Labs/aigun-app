import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/count.dart';
import '../../../../cubits/sound_effect/sound_effect_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/clipboard.dart';
import '../../../../utils/toast.dart';
import '../cubits/invite_cubit.dart';

class InviteSheet extends StatefulWidget {
  const InviteSheet({super.key});

  @override
  State<InviteSheet> createState() => _InviteSheetState();
}

class _InviteSheetState extends State<InviteSheet> {
  final TextEditingController _inviteCodeController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _inviteCodeController.dispose();
    _focusNode.dispose();
    // BlocProvider.of<InviteCubit>(context).reset();
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
      await BlocProvider.of<InviteCubit>(context).bindInviteCode(inviteCode);

      if (!mounted) return;

      // _focusNode.unfocus();
      // ToastUtils.showSuccessToast(context, message: s.bindSuccess);
      // Navigator.maybePop(context);
    } catch (e) {
      setState(() => _errorMessage = s.inviteCodeInputError);
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
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BlocListener<InviteCubit, InviteState>(
            listenWhen: (previous, current) {
              return previous.inviteCodeStatus !=
                      const InviteCodeStatus.success() &&
                  current.inviteCodeStatus == const InviteCodeStatus.success();
            },
            listener: (context, state) {
              state.inviteCodeStatus.whenOrNull(
                success: () {
                  _focusNode.unfocus();
                  // ToastUtils.showSuccessToast(context, message: s.bindSuccess);
                  ToastUtils.showCenterToast(context, s.bindSuccess);
                  BlocProvider.of<SoundEffectCubit>(context).playBonus();
                  Navigator.maybePop(context);
                },
              );
            },
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
                Text(
                  s.bindReferrerInviteCode,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textPrimary(context),
                  ),
                ),

                6.verticalSpace,
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

                Focus(
                  onFocusChange: (_) => setState(() {}),
                  child: TextField(
                    controller: _inviteCodeController,
                    focusNode: _focusNode,
                    enabled: !_isLoading,
                    keyboardType: .text,
                    textCapitalization: .characters,
                    textInputAction: .done,
                    onSubmitted: (_) => _handleBind(),
                    maxLength: NumericConstants.five, //  5
                    inputFormatters: [
                      if (Platform.isAndroid)
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    decoration: InputDecoration(
                      counter: const SizedBox.shrink(),
                      hintText: s.inputInviteCode,
                      hintStyle: TextStyle(
                        color: AppColors.textQuaternary(context),
                        fontSize: 16.sp,
                        height: 1.4,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(
                        16.w,
                        14.h,
                        0.w,
                        14.h,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: !_isLoading
                            ? () async => {
                                BlocProvider.of<InviteCubit>(context).reset(),
                                await _handlePaste(),
                              }
                            : null,
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
                      BlocProvider.of<InviteCubit>(
                        context,
                      ).setInviteCode(value);

                      if (_errorMessage != null) {
                        setState(() {
                          _errorMessage = null;
                        });
                      }
                    },
                  ),
                ),
                6.verticalSpace,
                Text(
                  s.goldDesc,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textTertiary(context),
                  ),
                ),
                10.verticalSpace,
                // if (_errorMessage != null)
                //   Text(
                //     _errorMessage!,
                //     textAlign: TextAlign.left,
                //     style: TextStyle(
                //       fontSize: 16.sp,
                //       color: AppColors.secondary,
                //     ),
                //   ),
                InviteErrorMessage(),

                100.verticalSpace,
                SizedBox(
                  height: 45.w,
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
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(s.bind, style: TextStyle(fontSize: 16.sp)),
                  ),
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

class InviteErrorMessage extends StatelessWidget {
  const InviteErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InviteCubit, InviteState>(
      buildWhen: (previous, current) =>
          previous.inviteCodeStatus != current.inviteCodeStatus,
      builder: (context, state) {
        return state.inviteCodeStatus.whenOrNull(
              error: (type) => switch (type) {
                // InviteFailureType.format => Text(
                //   S.of(context).inviteCodeFormatterError,
                //   textAlign: TextAlign.left,
                //   style: TextStyle(fontSize: 16.sp, color: AppColors.secondary),
                // ),
                _ => Text(
                  S.of(context).inviteCodeInputError,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16.sp, color: AppColors.secondary),
                ),
              },
            ) ??
            Text(
              '',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16.sp, color: Colors.transparent),
            );
      },
    );
  }
}
