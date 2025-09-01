import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Intel页面的浮动操作按钮
class IntelFloatingButton extends StatelessWidget {
  const IntelFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.pirmary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(99.r),
      ),
      splashColor: AppColors.pirmary.withValues(alpha: .5),
      onPressed: () {
        final isLoggedIn = context.read<UserCubit>().state.isLoggedIn;

        if (isLoggedIn) {
          context.push(Routes.intelAIAgents);
        } else {
          showSimpleToast(S.of(context).authMessages_loginFirst,
              alignment: Alignment.topCenter);
          context.push(Routes.login);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).common_add,
            style: TextStyle(color: AppColors.white),
          ),
          Text(
            S.of(context).intel_intelAiAgent,
            style: TextStyle(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
