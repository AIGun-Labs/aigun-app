import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/widgets/search_bar/widgets/top_search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchInternalSearchBar extends StatefulWidget {
  const SearchInternalSearchBar({
    super.key,
    this.openDrawer,
    this.initialText,
  });

  final VoidCallback? openDrawer;
  final String? initialText;

  @override
  State<SearchInternalSearchBar> createState() =>
      SearchInternalSearchBarState();
}

class SearchInternalSearchBarState extends State<SearchInternalSearchBar> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialText != null && widget.initialText!.isNotEmpty) {
      searchController.text = widget.initialText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Row(
          children: [
            Expanded(
                child: TopSearchBar(
              prefixIconColor: Colors.black,
              borderColor: AppColors.senary,
              backgroundColor: AppColors.senary,
              searchController: searchController,
              openDrawer: widget.openDrawer,
              prefix: const SizedBox.shrink(),
              suffixOnPressed: () async {
                ClipboardUtils.paste().then((value) {
                  searchController.text = value;
                });
              },
              suffix: Text(
                S.of(context).paste,
                style: TextStyle(color: AppColors.quaternary, fontSize: 12.sp),
              ),
            )),
            SizedBox(
              width: 15.w,
            ),
            GestureDetector(
              child: Text(
                "取消",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ));
  }
}
