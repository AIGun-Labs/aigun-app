import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/intel_ai_agents/widgets/monitor_card.dart';
import 'package:flutter_aigun/screens/intel_ai_agents/widgets/monitor_info.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/intel_tab_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class IntelAIAgentsScreen extends StatefulWidget {
  const IntelAIAgentsScreen({super.key});

  @override
  State<IntelAIAgentsScreen> createState() => _IntelAIAgentsScreenState();
}

class _IntelAIAgentsScreenState extends State<IntelAIAgentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = const [
    'All',
    'Memecoin',
    'RGB',
    'Large Cap',
    'User',
    'Macro & Policy',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).intel_intelAiAgent),
      backgroundColor: AppColors.background(context),
      body: Column(
        children: [
          IntelTabBar(
            tabs: _tabs,
            controller: _tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabs.map(_buildTabContent).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(String tab) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
          children: [
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5.w, bottom: 10.h),
                  child: _buildSmartWallet(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, bottom: 10.h),
                  child: _buildTelegram(),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: _buildX(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: _buildNewCoin(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartWallet() {
    return MonitorCard(
      onTap: () => context.push(Routes.intelXGroup),
      imageUrl: 'assets/images/smart-wallet.png',
      title: S.of(context).intel_smartWalletTitle,
      description: S.of(context).intel_smartWalletDesc,
      monitorInfo: MonitorInfo(
        status: MonitorStatus.enabled,
        type: S.of(context).form_address,
        count: 200,
      ),
    );
  }

  Widget _buildX() {
    return MonitorCard(
      onTap: () => context.push(Routes.intelX),
      imageUrl: 'assets/images/x.png',
      title: S.of(context).intel_xTitle,
      description: S.of(context).intel_xDesc,
      monitorInfo: MonitorInfo(
        status: MonitorStatus.enabled,
        type: S.of(context).branding_createNewAccount,
        count: 200,
      ),
    );
  }

  Widget _buildTelegram() {
    return MonitorCard(
      onTap: () => context.push(Routes.intelXGroup),
      imageUrl: 'assets/images/tg.png',
      title: S.of(context).intel_telegramTitle,
      description: S.of(context).intel_telegramDesc,
      monitorInfo: const MonitorInfo(
        status: MonitorStatus.notEnabled,
      ),
    );
  }

  Widget _buildNewCoin() {
    return MonitorCard(
      onTap: () => context.push(Routes.intelXGroup),
      imageUrl: 'assets/images/new-coin.png',
      title: S.of(context).intel_newCoinTitle,
      description: S.of(context).intel_newCoinDesc,
      monitorInfo: MonitorInfo(
        status: MonitorStatus.autoTrading,
        type: S.of(context).form_address,
        count: 200,
      ),
    );
  }
}
