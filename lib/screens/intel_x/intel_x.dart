import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/widgets/loading_indicator/index.dart';
import 'package:flutter_aigun/widgets/toast.dart';

import 'widgets/intel_x_body.dart';

class IntelXScreen extends StatefulWidget {
  const IntelXScreen({super.key});

  @override
  State<IntelXScreen> createState() => _IntelXScreenState();
}

class _IntelXScreenState extends State<IntelXScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  // 保存对MonitorCubit的引用
  MonitorCubit? _monitorCubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 在这里安全地获取MonitorCubit的引用
    _monitorCubit = context.read<MonitorCubit>();
  }

  void _initTabController(int length) {
    _tabController?.dispose();
    _tabController = TabController(
      initialIndex: 0,
      length: length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    try {
      _tabController?.dispose();
      _tabController = null;

      if (_monitorCubit != null) {
        _monitorCubit!.clearCache();
      }
    } finally {
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: BlocBuilder<MonitorGroupCubit, MonitorGroupState>(
        builder: (context, state) {
          return state.maybeWhen(
              // 这里必须保证全页面包裹，否则会屏闪
              loading: () => Container(
                    color: AppColors.background(context),
                    width: double.infinity,
                    height: double.infinity,
                    child: const Center(
                      child: LoadingIndicator(),
                    ),
                  ),
              error: (message) {
                showSimpleToast(message);
                return Container(
                  color: AppColors.background(context),
                  width: double.infinity,
                  height: double.infinity,
                  child: const Center(
                    child: LoadingIndicator(),
                  ),
                );
              },
              orElse: () => Container(
                    color: AppColors.background(context),
                    width: double.infinity,
                    height: double.infinity,
                    child: const Center(
                      child: LoadingIndicator(),
                    ),
                  ),
              loaded: (monitorGroupList) {
                // 数据加载后初始化TabController
                if (_tabController == null ||
                    _tabController!.length != monitorGroupList.length) {
                  _initTabController(monitorGroupList.length);
                }

                return IntelXBody(
                  monitorGroupList: monitorGroupList,
                  tabController: _tabController!,
                );
              });
        },
      ),
    );
  }
}
