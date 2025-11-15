import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../themes/colors.dart';
import '../../search_bar/index.dart';

class UserProfileWithSearchBar extends StatefulWidget {
  const UserProfileWithSearchBar({super.key, required this.openDrawer});
  final VoidCallback? openDrawer;

  @override
  State<UserProfileWithSearchBar> createState() =>
      _UserProfileWithSearchBarState();
}

class _UserProfileWithSearchBarState extends State<UserProfileWithSearchBar> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
      child: TopSearchBar(
        openDrawer: widget.openDrawer,
        suffix: SvgPicture.asset(
          "assets/images/icons/copy.svg",
          width: 18.w,
          height: 16.h,
          colorFilter: ColorFilter.mode(
              AppColors.textTertiary(context), BlendMode.srcIn),
        ),
      ),
    );
  }
}
