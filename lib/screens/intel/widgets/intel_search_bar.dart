import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/l10n.dart';
import '../../../themes/themes.dart';
import '../../../utils/clipboard.dart';
import '../../../widgets/search_bar/widgets/top_search_bar.dart';

class IntelSearchBar extends StatelessWidget {
  const IntelSearchBar(
      {super.key, required this.openDrawer, this.searchController});
  final VoidCallback openDrawer;
  final TextEditingController? searchController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: TopSearchBar(
      isRead: true,
      openDrawer: openDrawer,
      searchController: searchController,
      leftSpacing: true,
      suffixOnPressed: () {
        ClipboardUtils.paste().then((value) {
          searchController?.text = value;
        });
      },
      suffix: Text(
        S.of(context).paste,
        style: TextStyle(color: AppColors.quaternary, fontSize: 12.sp),
      ),
    ));
  }
}
