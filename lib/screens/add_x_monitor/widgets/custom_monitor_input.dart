import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/button.dart';

enum MonitorInputState {
  normal,
  loading,
}

class CustomMonitorInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onConfirm;
  final MonitorInputState? state;

  const CustomMonitorInput({
    super.key,
    required this.controller,
    this.onConfirm,
    this.state = MonitorInputState.normal,
  });

  @override
  State<CustomMonitorInput> createState() => _CustomMonitorInputState();
}

class _CustomMonitorInputState extends State<CustomMonitorInput> {
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();
    _isEmpty = widget.controller.text.isEmpty;
    widget.controller.addListener(_textListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_textListener);
    super.dispose();
  }

  void _textListener() {
    final newIsEmpty = widget.controller.text.isEmpty;
    if (_isEmpty != newIsEmpty) {
      setState(() {
        _isEmpty = newIsEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final disable = widget.state == MonitorInputState.loading || _isEmpty;

    return Container(
      color: AppColors.indicatorColor,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.w,
        bottom: MediaQuery.of(context).viewInsets.bottom > 0
            ? 16.h
            : 16.h + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: double.infinity),
                  Text(
                    S.of(context).intelGroups_intelXGroupCustomMonitor,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    S.of(context).form_intelXGroupInputUsername,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Image.asset(
                  'assets/images/new-coin.png',
                  width: 112.w,
                  height: 112.w,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomInput(
                  controller: widget.controller,
                  height: 50.h,
                  fontSize: 16.sp,
                  hintText: S.of(context).form_intelXGroupUsernameHint,
                  borderRadius: BorderRadius.circular(8.r),
                  prefixIcon: Container(
                    width: 30.w,
                    padding: EdgeInsets.only(left: 5.w),
                    child: Text(
                      '@',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  suffixIcon: Transform.translate(
                    offset: Offset(5.w, 0),
                    child: CustomButton(
                      onPressed: disable
                          ? null
                          : () =>
                              widget.onConfirm?.call(widget.controller.text),
                      backgroundColor: Colors.black,
                      borderRadius: BorderRadius.circular(8.r),
                      width: 60.w,
                      height: 35.h,
                      child: widget.state == MonitorInputState.loading
                          ? SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              S.of(context).intelGroups_intelXGroupConfirmAdd,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
