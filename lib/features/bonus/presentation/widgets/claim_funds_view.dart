import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/claim_token_entity.dart';
import 'claim_funds_card.dart';

class ClaimFundsView extends StatelessWidget {
  final List<ClaimTokenEntity> tokens;
  const ClaimFundsView(
      {super.key, required this.tokens, required this.onClaim});
  final Future<void> Function(ClaimTokenEntity token) onClaim;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.h,
          crossAxisSpacing: 14.w,
          childAspectRatio: 0.96),
      itemCount: tokens.length,
      itemBuilder: (context, index) =>
          ClaimFundsCard(token: tokens[index], onClaim: onClaim),
    );
  }
}
