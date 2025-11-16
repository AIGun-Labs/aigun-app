import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/l10n.dart';
import '../../../themes/themes.dart';
import '../../../utils/clipboard.dart';
import '../../../widgets/search_bar/widgets/top_search_bar.dart';

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
          suffix: Text(
            S.of(context).paste,
            style: TextStyle(color: AppColors.quaternary, fontSize: 12.sp),
          ),
          // suffix: SvgPicture.asset(
          //   "assets/images/icons/copy.svg",
          //   width: 18.w,
          //   height: 16.h,
          //   colorFilter: ColorFilter.mode(
          //       AppColors.textTertiary(context), BlendMode.srcIn),
          // ),
        ));
  }
}
