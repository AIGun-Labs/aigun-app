import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/search_bar/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
