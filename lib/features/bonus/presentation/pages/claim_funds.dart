import 'package:flutter/material.dart';
import 'package:flutter_aigun/widgets/error/error_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/service_locator.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../themes/colors.dart';
import '../cubits/claim_token_cubit.dart';
import '../cubits/claim_token_state.dart';
import '../widgets/claim_funds_card.dart';
import '../widgets/claim_funds_card_skeleton.dart';
import '../widgets/claim_funds_header.dart';
import '../widgets/claim_funds_view.dart';
import '../widgets/claim_funds_view_skeleton.dart';

class ClaimFundsScreen extends StatefulWidget {
  const ClaimFundsScreen({super.key});

  @override
  State<ClaimFundsScreen> createState() => _ClaimFundsScreenState();
}

class _ClaimFundsScreenState extends State<ClaimFundsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface(context),
      appBar: SimpleAppBar(title: S.of(context).claimFunds),
      body: CustomScrollView(
        slivers: <Widget>[
          const ClaimFundsHeader(),
          SliverPadding(
              padding: EdgeInsets.all(20.w),
              sliver: BlocBuilder<ClaimTokenCubit, ClaimTokenState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const ClaimFundsViewSkeleton(),
                    loading: () => const ClaimFundsViewSkeleton(),
                    success: (tokens) => ClaimFundsView(
                        tokens: tokens,
                        onClaim: getIt<ClaimTokenCubit>().claimToken),
                    error: (String message) => SliverFillRemaining(
                      child: GlobalErrorWidget(
                        title: 'Error',
                        message: message,
                        onRetry: () {
                          getIt<ClaimTokenCubit>().init();
                        },
                      ),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
