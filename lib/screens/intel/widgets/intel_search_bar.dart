import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/widgets/search_bar/widgets/top_search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntelSearchBar extends StatelessWidget {
  const IntelSearchBar(
      {Key? key, required this.openDrawer, this.searchController})
      : super(key: key);
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
