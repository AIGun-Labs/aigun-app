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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenDetailTabbar extends StatelessWidget implements PreferredSizeWidget {
  const TokenDetailTabbar(
      {super.key, required this.tabs, required this.controller});
  final List<Widget> tabs;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final language = context.watch<LanguageCubit>().state.locale.languageCode;

    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: language == 'en' ? 280.w : 230.w,
            child: TabBar(
                controller: controller,
                indicator: UnderlineTabIndicator(
                   borderSide: BorderSide(
                    width: 2.h,
                    color: Colors.black,
                  ),
                ),
                // 点击tabbar时，背景颜色不变
                overlayColor:
                    WidgetStateProperty.all(AppColors.background(context)),
                unselectedLabelColor: AppColors.textTertiary(context),
                labelColor: AppColors.textPrimary(context),
                indicatorColor: AppColors.textPrimary(context),
                dividerHeight: 0.h,
                dividerColor: AppColors.black,
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

class _TokenDetailScreenState extends State<TokenDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    _refreshTokenData();
  }

  void _refreshTokenData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TokenDetailCubit>().loadData();
    });
  }

  List<Widget> _buildTabs(BuildContext context, TokenDetailState state) {
    final s = S.of(context);

    return [
      Tab(
          child: Text.rich(TextSpan(children: [
        TextSpan(
            text: s.marketTab,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
      ]))),
      Tab(
          child: Text.rich(
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.visible,
              TextSpan(children: [
                TextSpan(
                    text: s.aiTab,
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                WidgetSpan(child: SizedBox(width: 4.w)),
                if (state.tokenIntelCount > 0)
                  TextSpan(
                      text: state.tokenIntelCount.toString(),
                      style: TextStyle(
                          color: AppColors.quaternary,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold)),
              ]))),
      Tab(
          child: Text.rich(
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.visible,
              TextSpan(children: [
                TextSpan(
                    text: s.riskTab,
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                WidgetSpan(child: SizedBox(width: 4.w)),
                if (state.tokenRiskCount > 0)
                  TextSpan(
                      text: state.tokenRiskCount.toString(),
                      style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold)),
              ]))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
        builder: (context, state) {
      return Scaffold(
        appBar: TokenHeaderBar(
            tabbar: TokenDetailTabbar(
                controller: _tabController, tabs: _buildTabs(context, state))),
        body: TabBarView(controller: _tabController, children: [
          MarketTabContent(tabController: _tabController),
          const AITabContent(),
          const RiskTabContent(),
        ]),
        bottomNavigationBar: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
                child: const TradeButtons())),
      );
    });
  }
}
