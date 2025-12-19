import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../themes/colors.dart';
import '../cubits/invite_cubit.dart';
import '../widgets/invite_sheet.dart';

Future<void> showInviteSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    useSafeArea: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    backgroundColor: AppColors.background(context),
    builder: (_) => BlocProvider.value(
      value: BlocProvider.of<InviteCubit>(context),
      child: const InviteSheet(),
    ),
  ).whenComplete(
    () =>
        context.mounted ? BlocProvider.of<InviteCubit>(context).reset() : null,
  );
}
