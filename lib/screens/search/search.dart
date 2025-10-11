import 'package:flutter/material.dart';
import 'package:flutter_aigun/screens/search/widgets/search_bar.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SearchInternalScreen extends StatelessWidget {
  const SearchInternalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keyword = GoRouterState.of(context).extra;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20.w,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.h),
          child: SearchInternalSearchBar(
            initialText: keyword.toString(),
          ),
        ),
        backgroundColor: AppColors.background(context),
      ),
    );
  }
}
