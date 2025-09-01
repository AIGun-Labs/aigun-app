import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/intel_x_group/widgets/group_list_view.dart';
import 'package:flutter_aigun/themes/theme.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/bottom_button.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/add_group_dialog.dart';

class IntelXGroupScreen extends StatefulWidget {
  const IntelXGroupScreen({super.key});

  @override
  State<IntelXGroupScreen> createState() => _IntelXGroupScreenState();
}

class _IntelXGroupScreenState extends State<IntelXGroupScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitorGroupCubit, MonitorGroupState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppTheme.pageBg2(context),
          appBar: CustomAppBar(
            title: S.of(context).intelGroups_intelXGroupTitle,
          ),
          body: Container(
            width: double.infinity,
            color: AppTheme.pageBg2(context),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            child: Column(
              children: [
                Expanded(
                  child: GroupListView(
                    controller: _controller,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomButton(
            child: CustomButton(
              onPressed: () {
                final dialog = AddGroupDialog(controller: _controller);
                dialog.showDialog(context);
              },
              height: 45.h,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              isBottomButton: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 20.w,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.w),
                  Text(S.of(context).intelGroups_intelXGroupAdd)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
