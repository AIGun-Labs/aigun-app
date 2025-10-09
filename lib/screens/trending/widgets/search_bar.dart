import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/widgets/search_bar/widgets/top_search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrendingSearchBar extends StatefulWidget {
  const TrendingSearchBar({super.key, required this.openDrawer});

  final VoidCallback? openDrawer;

  @override
  State<TrendingSearchBar> createState() => _TrendingSearchBarState();
}

class _TrendingSearchBarState extends State<TrendingSearchBar> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: TopSearchBar(
          suffixOnPressed: () {
            ClipboardUtils.paste().then((value) {
              searchController.text = value;
            });
          },
          suffix: Text(
            S.of(context).paste,
            style: TextStyle(color: AppColors.quaternary, fontSize: 12.sp),
          ),
        ));
  }
}
