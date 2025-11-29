import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class RefreshNotification extends StatefulWidget {
  const RefreshNotification({
    super.key,
    required this.child,
    required this.onRefresh,
  });
  final Widget child;
  final Future<bool> Function() onRefresh;

  @override
  State<RefreshNotification> createState() => _RefreshNotificationState();
}

class _RefreshNotificationState extends State<RefreshNotification> {
  @override
  Widget build(BuildContext context) {
    return PullToRefreshNotification(
      onRefresh: widget.onRefresh,
      maxDragOffset: 100.h,
      refreshOffset: 90.h,
      reachToRefreshOffset: 90.h,
      child: widget.child,
    );
  }
}
