import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import '../l10n/l10n.dart';
import 'refresh_header.dart';

class PullToRefreshHeader extends StatelessWidget {
  const PullToRefreshHeader(this.info, {super.key});

  final PullToRefreshScrollNotificationInfo? info;

  @override
  Widget build(BuildContext context) {
    if (info == null) {
      return Container();
    }
    final double dragOffset = info?.dragOffset ?? 0.0;
    final double top = -78.h + dragOffset;

    return SizedBox(
      height: dragOffset,
      child: Stack(
        children: <Widget>[
          Positioned(
              left: 0.0,
              right: 0.0,
              top: top,
              child: Column(
                children: <Widget>[
                  const RefreshLoading(),
                  RefreshText(
                    text: S.of(context).app_title,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
