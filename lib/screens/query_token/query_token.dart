import 'package:flutter/material.dart';
import 'package:flutter_aigun/screens/query_token/widgets/query_token_item.dart';
import 'package:flutter_aigun/screens/query_token/widgets/search_bar.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class QueryTokenScreen extends StatelessWidget {
  const QueryTokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String keyworkd = '';
    try {
      keyworkd = GoRouterState.of(context).extra?.toString() ?? '';
    } catch (e) {
      debugPrint('GoRouterState.of failed in QueryTokenScreen: $e');
    }
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20.w,
        automaticallyImplyLeading: false,
        title: SearchInternalSearchBar(
          initialText: keyworkd,
        ),
        backgroundColor: AppColors.background(context),
      ),
      body: SafeArea(
          child: ListView(
        children: [QueryTokenItem()],
      )),
    );
  }
}
