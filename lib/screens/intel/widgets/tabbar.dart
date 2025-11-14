import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/language/language_cubit.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntelTabbar extends StatelessWidget implements PreferredSizeWidget {
  const IntelTabbar(
      {super.key, required this.tabController, required this.tabs});

  final TabController tabController;
  final List<Tab> tabs;
  @override
  Widget build(BuildContext context) {
    final language = context.watch<LanguageCubit>().state.locale.languageCode;

    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            // width: language == 'en' ? 280.w : 190.w,
            child: TabBar(
              padding: EdgeInsets.zero,
              controller: tabController,
              tabs: tabs,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2.w, color: Colors.black)),
              overlayColor:
                  WidgetStateProperty.all(AppColors.background(context)),
              unselectedLabelColor: AppColors.textTertiary(context),
              labelColor: AppColors.textPrimary(context),
              indicatorColor: AppColors.textPrimary(context),
              dividerHeight: 0.h,
              dividerColor: Colors.transparent,
            ),
          ),
        ),
        // Positioned(
        //   left: 0,
        //   right: 0,
        //   bottom: 0,
        //   child: Container(height: 1.h, color: AppColors.border(context)),
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.h + 1.h);
}

class IntelTabbarItem extends StatelessWidget {
  const IntelTabbarItem({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16.sp,
            // fontWeight: FontWeight.bold,
            color: AppColors.textPrimary(context)),
      ),
    );
  }
}
