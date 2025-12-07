import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/widgets/search_bar_widget.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/clipboard.dart';

/// Intel Search Bar Widget
///
/// Search bar for the intelligence feature with paste functionality.
class IntelligenceSearchBarWidget extends StatefulWidget {
  const IntelligenceSearchBarWidget({
    super.key,
    this.searchController,
    this.onMenuPressed,
  });

  final TextEditingController? searchController;
  final VoidCallback? onMenuPressed;

  @override
  State<IntelligenceSearchBarWidget> createState() =>
      _IntelSearchBarWidgetState();
}

class _IntelSearchBarWidgetState extends State<IntelligenceSearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 15.w),
      height: 56.w,
      color: AppColors.background(context),
      child: SearchBarWidget(
        isRead: true,
        openDrawer: widget.onMenuPressed,
        searchController: widget.searchController,
        leftSpacing: true,
        suffixOnPressed: () {
          ClipboardUtils.paste().then((value) {
            widget.searchController?.text = value;
          });
        },
        suffix: Text(
          S.of(context).paste,
          style: TextStyle(color: AppColors.quaternary, fontSize: 12.sp),
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
