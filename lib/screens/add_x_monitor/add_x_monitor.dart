import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/add_x_monitor/widgets/custom_monitor_input.dart';
import 'package:flutter_aigun/screens/add_x_monitor/widgets/monitor_card.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class AddXMonitorScreen extends StatefulWidget {
  const AddXMonitorScreen({super.key});

  @override
  State<AddXMonitorScreen> createState() => _AddXMonitorScreenState();
}

class _AddXMonitorScreenState extends State<AddXMonitorScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void showSuccess() {
      showSimpleToast(S.of(context).authMessages_addSuccess,
          type: ToastificationType.success, alignment: Alignment.topCenter);
    }

    final groupId = context.read<MonitorCubit>().currentGroupId;
    return BlocBuilder<MonitorCubit, MonitorState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: S.of(context).intelGroups_intelXGroupAddMonitor,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: 10,
                  itemBuilder: (context, index) =>
                      index == 9 ? SizedBox(height: 100.h) : const MonitorCard(),
                ),
              ),
            ],
          ),
          bottomNavigationBar: AnimatedPadding(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: CustomMonitorInput(
              controller: _controller,
              onConfirm: (value) async {
                await context.read<MonitorCubit>().addMonitor(
                      groupId: groupId!,
                      description: value,
                    );

                showSuccess();
              },
            ),
          ),
        );
      },
    );
  }
}
