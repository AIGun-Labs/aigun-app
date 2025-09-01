import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/intel_x_group/widgets/group_list_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubits/index.dart';
import '../../../widgets/loading_indicator/index.dart';
import '../../../widgets/toast.dart';
import 'edit_group_dialog.dart';

class GroupListView extends StatelessWidget {
  final TextEditingController controller;

  const GroupListView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitorGroupCubit, MonitorGroupState>(
      builder: (context, state) {
        return state.maybeWhen(
            loading: () => const LoadingIndicator(
                  type: LoadingIndicatorType.wave,
                ),
            error: (message) {
              showSimpleToast(message);
              return const LoadingIndicator(
                type: LoadingIndicatorType.wave,
              );
            },
            orElse: () => const LoadingIndicator(
                  type: LoadingIndicatorType.wave,
                ),
            loaded: (monitorGroupList) => ReorderableListView.builder(
                  buildDefaultDragHandles: false,
                  shrinkWrap: true,
                  proxyDecorator: (child, index, animation) => Material(
                    elevation: 0,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    child: child,
                  ),
                  footer: Padding(
                    padding: EdgeInsets.only(top: 90.h),
                    child: Column(
                      children: [
                        SizedBox(height: 12.h),
                        Image.asset(
                          'assets/images/new-coin.png',
                          width: 163.w,
                          height: 163.h,
                        ),
                        SizedBox(height: 27.h),
                        Text(
                          S.of(context).intelGroups_intelXGroupTip1,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        Text(
                          S.of(context).intelGroups_intelXGroupTip2,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemCount: monitorGroupList.length,
                  onReorderStart: (index) {
                    FocusScope.of(context).unfocus();
                  },
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    context.read<MonitorGroupCubit>().onReorderGroup(
                          oldIndex,
                          newIndex,
                        );
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.w),
                      key: ValueKey(monitorGroupList[index].id),
                      child: CustomDragHandle(
                        index: index,
                        child: GroupListItem(
                          title: monitorGroupList[index].name ??
                              S.of(context).wallet_defaultGroup,
                          isDefault: index == 0,
                          onDelete: () {
                            context
                                .read<MonitorGroupCubit>()
                                .deleteMonitorGroup(
                                  id: monitorGroupList[index].id ?? '',
                                );
                          },
                          onEdit: () {
                            final dialog = EditGroupDialog(
                              controller: controller,
                              group: monitorGroupList[index],
                            );
                            dialog.showDialog(context);
                          },
                        ),
                      ),
                    );
                  },
                ));
      },
    );
  }
}

class CustomDragHandle extends StatelessWidget {
  final int index;
  final Widget child;

  const CustomDragHandle({
    super.key,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          right: 5.w,
          top: 0,
          bottom: 0,
          child: ReorderableDragStartListener(
            index: index,
            child: SizedBox(
              width: 30.w,
              height: double.infinity,
              child: Center(
                child: Icon(
                  Icons.drag_handle_rounded,
                  size: 20.w,
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withValues(alpha: 0.55),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
