import 'package:flutter/material.dart';
import 'package:flutter_aigun/features/bonus/presentation/widgets/bonus_view_skeleton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/router/constants.dart';
import '../../../../core/service_locator.dart';
import '../../../bonus/presentation/cubits/invite_cubit.dart';
import '../cubits/invite_state.dart';
import '../widgets/bonus_view.dart';

class BonusScreen extends StatefulWidget {
  const BonusScreen({super.key});

  @override
  State<BonusScreen> createState() => _BonusScreenState();
}

class _BonusScreenState extends State<BonusScreen> {
  late final InviteCubit _inviteCubit;

  @override
  void initState() {
    super.initState();
    _inviteCubit = getIt<InviteCubit>()..init();
  }

  @override
  void dispose() {
    _inviteCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VisibilityDetector(
          key: const Key(RouteNames.bonus),
          onVisibilityChanged: (visibilityInfo) {
            if (visibilityInfo.visibleFraction > 0) {
              _inviteCubit.refreshInviteInfo();
            }
          },
          child: BlocBuilder<InviteCubit, InviteState>(
            builder: (context, state) {
              return state.when(
                  initial: () => const BonusViewSkeleton(),
                  loading: () => const BonusViewSkeleton(),
                  success: (inviteInfo) => BonusView(inviteInfo: inviteInfo),
                  error: (error) => Center(child: Text(error)));
            },
          )),
    );
  }
}
