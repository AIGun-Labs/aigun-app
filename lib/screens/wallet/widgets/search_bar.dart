import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/widgets/search_bar/widgets/top_search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletSearchBar extends StatefulWidget {
  const WalletSearchBar({super.key, required this.openDrawer});

  final VoidCallback? openDrawer;

  @override
  State<WalletSearchBar> createState() => WalletSearchBarState();
}

class WalletSearchBarState extends State<WalletSearchBar> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: TopSearchBar(
          isRead: true,
          leftSpacing: true,
          searchController: searchController,
          openDrawer: widget.openDrawer,
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
