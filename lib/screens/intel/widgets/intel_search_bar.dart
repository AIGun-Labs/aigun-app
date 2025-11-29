import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/l10n.dart';
import '../../../shared/presentation/widgets/search_bar_widget.dart';
import '../../../themes/themes.dart';
import '../../../utils/clipboard.dart';

class IntelSearchBar extends StatefulWidget {
  const IntelSearchBar({super.key, this.searchController, this.openDrawer});

  final TextEditingController? searchController;
  final VoidCallback? openDrawer;
  @override
  State<IntelSearchBar> createState() => _IntelSearchBarState();
}

class _IntelSearchBarState extends State<IntelSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchBarWidget(
      isRead: true,
      openDrawer: widget.openDrawer,
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
    );
  }
}
