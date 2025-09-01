import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/toast.dart';
import 'add_group_bottom_sheet.dart';

class AddGroupDialog extends StatelessWidget {
  final TextEditingController controller;

  const AddGroupDialog({
    super.key,
    required this.controller,
  });

  void showDialog(BuildContext context) {
    final cubit = context.read<MonitorGroupCubit>();

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
          title: S.of(context).intelGroups_intelXGroupAdd,
          onConfirm: () {
            if (controller.text.isNotEmpty) {
              cubit.addMonitorGroup(name: controller.text);
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
        Icons.add,
        size: 24.w,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
