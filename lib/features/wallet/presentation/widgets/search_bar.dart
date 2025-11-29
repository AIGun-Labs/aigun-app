import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/widgets/search_bar_widget.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/clipboard.dart';

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
    return SearchBarWidget(
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
        overflow: TextOverflow.visible,
      ),
      // suffix: SvgPicture.asset(
      //   "assets/images/icons/copy.svg",
      //   width: 18.w,
      //   height: 16.h,
      //   colorFilter: ColorFilter.mode(
      //       AppColors.textTertiary(context), BlendMode.srcIn),
      // ),
    );
  }
}
