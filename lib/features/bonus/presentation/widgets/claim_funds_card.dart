import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../shared/utils/rate_limit.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/toast.dart';
import '../../../../widgets/avatar/widget/token.dart';
import '../../domain/entities/claim_token_entity.dart';
import 'card_widget.dart';

class ClaimFundsCard extends StatefulWidget {
  final ClaimTokenEntity token;
  const ClaimFundsCard({super.key, required this.token, required this.onClaim});
  final Future<void> Function(ClaimTokenEntity token) onClaim;

  @override
  State<ClaimFundsCard> createState() => _ClaimFundsCardState();
}

class _ClaimFundsCardState extends State<ClaimFundsCard> {
  bool _isLoading = false;

  late double amountValue;

  bool get isDisabled => amountValue <= 0;

  final Throttle _throttle = Throttle(
    period: const Duration(seconds: 1),
    leading: true,
    trailing: false,
  );

  Future<void> _onClaim() async {
    if (_isLoading) return;

    await _throttle.run(() async {
      if (!mounted || _isLoading) return;

      setState(() => _isLoading = true);

      try {
        await widget.onClaim(widget.token);
        if (!mounted) return;
        setState(() => amountValue = 0.0);
        ToastUtils.showCenterToast(context, S.of(context).claimWaiting);
      } on Exception catch (e) {
        if (!mounted) return;
        ToastUtils.showFailureToast(context, message: e.toString());
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    amountValue = widget.token.claimableAmountDouble;
  }

  @override
  void dispose() {
    _throttle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        paddingValue: 14,
        backgroundColor: AppColors.background(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AvatarToken(
                  avatar: widget.token.logo,
                  tokenName: widget.token.network,
                  width: 40.w,
                  height: 40.w,
                ),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.token.chainName,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '\$${widget.token.price}',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary(context)),
                    ),
                  ],
                )
              ],
            ),
            8.verticalSpace,
            RichText(
                text: TextSpan(
                    spellOut: true,
                    style: TextStyle(
                      color: AppColors.textPrimary(context),
                    ),
                    children: [
                  TextSpan(
                      text: amountValue.toString(),
                      style: TextStyle(
                        fontSize: 20.sp,
                      )),
                  WidgetSpan(child: SizedBox(width: 4.w)),
                  TextSpan(
                      text: widget.token.symbol,
                      style: TextStyle(
                        fontSize: 14.sp,
                      )),
                ])),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).minimumClaim(
                      widget.token.minClaimAmount, widget.token.symbol),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textTertiary(context),
                  ),
                ),
              ),
            ),
            4.verticalSpace,
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(isDisabled
                        ? AppColors.textTertiary(context)
                        : AppColors.foreground(context)),
                    foregroundColor:
                        WidgetStateProperty.all(AppColors.background(context)),
                    textStyle: WidgetStateProperty.all(TextStyle(
                      fontSize: 14.sp,
                      height: 1.2,
                    )),
                  ),
                  onPressed: isDisabled ? null : _onClaim,
                  child: _isLoading
                      ? const AspectRatio(
                          aspectRatio: 1,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(S.of(context).claim)),
            )
          ],
        ));
  }
}
