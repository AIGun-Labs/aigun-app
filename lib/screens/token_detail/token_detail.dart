import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/language/language_cubit.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_cubit.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/ai_tab_content.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/market_tab_content.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/risk_tab_content.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/token_header_bar.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/trade_buttons.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TokenDetailTabbar extends StatelessWidget implements PreferredSizeWidget {
  const TokenDetailTabbar({super.key, required this.tabs});
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final language = context.watch<LanguageCubit>().state.locale.languageCode;

    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: language == 'en' ? 280.w : 220.w,
            child: TabBar(
                // 点击tabbar时，背景颜色不变
                overlayColor:
                    WidgetStateProperty.all(AppColors.background(context)),
                unselectedLabelColor: AppColors.textTertiary(context),
                labelColor: AppColors.textPrimary(context),
                indicatorColor: AppColors.textPrimary(context),
                dividerHeight: 0.h,
                dividerColor: AppColors.border(context),
                tabs: tabs),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 1.h,
            color: AppColors.border(context),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.h + 1.h);
}

class TokenDetailScreen extends StatefulWidget {
  const TokenDetailScreen({super.key});

  @override
  State<TokenDetailScreen> createState() => _TokenDetailScreenState();
}

class _TokenDetailScreenState extends State<TokenDetailScreen> {
  @override
  void initState() {
    super.initState();

    _refreshTokenData();
  }

  void _refreshTokenData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TokenDetailCubit>().loadData();
    });
  }

  List<Widget> _buildTabs(
      BuildContext context, String aiTabCount, String riskTabCount) {
    final s = S.of(context);
    return [
      Tab(
          child: Text.rich(TextSpan(children: [
        TextSpan(
            text: s.marketTab,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
      ]))),
      Tab(
          child: Text.rich(TextSpan(children: [
        TextSpan(
            text: s.aiTab,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        WidgetSpan(child: SizedBox(width: 4.w)),
        if (aiTabCount.isNotEmptyAndZeroValue)
          TextSpan(
              text: aiTabCount,
              style: TextStyle(color: AppColors.quaternary, fontSize: 12.sp)),
      ]))),
      Tab(
          child: Text.rich(TextSpan(children: [
        TextSpan(
            text: s.riskTab,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        WidgetSpan(child: SizedBox(width: 4.w)),
        // TODO： 先等后端返回数据字段
        if (riskTabCount.isNotEmptyAndZeroValue)
          TextSpan(
              text: riskTabCount,
              style: TextStyle(color: AppColors.secondary, fontSize: 12.sp)),
      ]))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final aiTabCount = context.read<TokenDetailCubit>().riskAmount;
    final riskTabCount = context.read<TokenDetailCubit>().warningAmount;

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TokenHeaderBar(
              tabbar: TokenDetailTabbar(
                  tabs: _buildTabs(context, aiTabCount.toString(),
                      riskTabCount.toString()))),
          body: const TabBarView(
            children: [
            MarketTabContent(),
            AITabContent(),
            RiskTabContent(),
          ]),
          bottomNavigationBar: BlocBuilder<TokenDetailCubit, TokenDetailState>(
              builder: (context, state) {
            return SafeArea(
                child: Padding(
                    padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
                    child: const TradeButtons()));
          }),
        ));
  }
}
