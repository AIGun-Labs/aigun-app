import 'package:flutter/material.dart';
import 'package:flutter_aigun/screens/search/widgets/search_bar.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SearchInternalScreen extends StatelessWidget {
  const SearchInternalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keyworkd = GoRouterState.of(context).extra;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20.w,
        automaticallyImplyLeading: false,
        title: SearchInternalSearchBar(
          
          initialText: keyworkd.toString(),
        ),
        backgroundColor: AppColors.background(context),
      ),
    );
  }
}
