import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/intel_x/widgets/monitor_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubits/index.dart';
import '../../../data/models/monitor/index.dart';
import '../../../widgets/loading_indicator/index.dart';
import '../../../widgets/toast.dart';

class MonitorList extends StatelessWidget {
  const MonitorList({super.key, required this.groupId});
  final String groupId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitorCubit, MonitorState>(
      buildWhen: (previous, current) {
        // 只有当状态变化且与当前groupId相关时才重建
        final cubit = context.read<MonitorCubit>();
        return cubit.currentGroupId == groupId;
      },
      builder: (context, state) {
        final cubit = context.read<MonitorCubit>();

        // 如果当前Cubit的groupId与组件的groupId不匹配，
        // 尝试从缓存中获取数据
        if (cubit.currentGroupId != groupId) {
          // 如果有缓存数据，显示缓存数据
          final cachedMonitor = cubit.getCachedMonitor(groupId);
          if (cachedMonitor != null) {
            return _buildContent(context, cachedMonitor);
          }

          // 没有缓存数据，获取数据
          cubit.setCurrentGroupId(groupId);
          return const LoadingIndicator(
            type: LoadingIndicatorType.wave,
          );
        }

        return state.maybeWhen(
            orElse: () => const LoadingIndicator(
                  type: LoadingIndicatorType.wave,
                ),
            loading: () => const LoadingIndicator(
                  type: LoadingIndicatorType.wave,
                ),
            error: (message) {
              showSimpleToast(message, alignment: Alignment.topCenter);
              return const LoadingIndicator(
                type: LoadingIndicatorType.wave,
              );
            },
            loaded: (monitors) => _buildContent(context, monitors));
      },
    );
  }

  Widget _buildContent(BuildContext context, Monitor monitors) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).intelGroups_intelXGroupMonitorList(
                monitors.totalCount.toString()),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          if (monitors.totalCount == 0)
            Center(
              child: Text(
                S.of(context).ui_noData,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: monitors.totalCount,
              itemBuilder: (context, index) => MonitorItem(
                monitorList: monitors.monitorList?[index],
              ),
            ),
        ],
      ),
    );
  }
}
