import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/monitor/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/toast.dart';
import 'add_group_bottom_sheet.dart';

class EditGroupDialog extends StatelessWidget {
  final TextEditingController controller;
  final MonitorGroup group;

  const EditGroupDialog({
    super.key,
    required this.controller,
    required this.group,
  });

  void showDialog(BuildContext context) {
    final cubit = context.read<MonitorGroupCubit>();
    controller.text = group.name ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: AddGroupBottomSheet(
          controller: controller,
          title: S.of(context).intelGroups_intelXGroupEdit,
          onConfirm: () {
            if (controller.text.isNotEmpty) {
              cubit.updateMonitorGroup(
                id: group.id ?? '',
                name: controller.text,
              );
              controller.clear();
              Navigator.pop(context);
            } else {
              showSimpleToast(
                S.of(context).validation_intelXGroupEmpty,
                context: context,
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(context),
      icon: Icon(
        Icons.edit,
        size: 20.w,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
