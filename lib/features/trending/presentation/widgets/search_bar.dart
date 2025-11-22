import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/clipboard.dart';
import '../../../../widgets/search_bar/widgets/top_search_bar.dart';

class TrendingSearchBar extends StatelessWidget {
  TrendingSearchBar({super.key, required this.openDrawer});
  final VoidCallback openDrawer;

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TopSearchBar(
      isRead: true,
      openDrawer: openDrawer,
      searchController: searchController,
      leftSpacing: true,
      suffixOnPressed: () {
        ClipboardUtils.paste().then((value) {
          searchController.text = value;
        });
      },
      suffix: Text(
        S.of(context).paste,
        style: TextStyle(color: AppColors.quaternary, fontSize: 12.sp),
      ),
    );
  }
}
