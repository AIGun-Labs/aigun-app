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
        child: TopSearchBar(
          searchController: searchController,
          openDrawer: widget.openDrawer,
          prefix: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          suffixOnPressed: () async {
            ClipboardUtils.paste().then((value) {
              searchController.text = value;
            });
          },
          suffix: SvgPicture.asset(
            "assets/images/icons/copy.svg",
            width: 18.w,
            height: 16.h,
            colorFilter: ColorFilter.mode(
                AppColors.textTertiary(context), BlendMode.srcIn),
          ),
        ));
  }
}
