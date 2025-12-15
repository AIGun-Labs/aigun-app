import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/format/currency.dart';
import '../../../../widgets/avatar/widget/token.dart';
import '../price_change_text_widget.dart';

class TokenListTile extends StatelessWidget {
  const TokenListTile({
    super.key,
    required this.token,
    this.onTap,
    this.onLongPress,
    this.realtimeToken,
  });
  final BaseTokenEntity token;
  final VoidCallback? onTap;
  final void Function(BuildContext context)? onLongPress;
  final BaseTokenEntity? realtimeToken;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress == null ? null : () => onLongPress!(context),
        child: Padding(
          padding: .symmetric(horizontal: 15.w, vertical: 8.w),
          child: Row(
            children: [
              ClipOval(
                child: AvatarToken(
                  avatar: token.tokenLogo,
                  tokenName: token.symbol,
                  width: 40.w,
                  height: 40.w,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      token.symbol,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: .w700,
                        color: AppColors.textPrimary(context),
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      realtimeToken?.formattedMarketCap ??
                          token.formattedMarketCap,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .end,
                children: [
                  Text(
                    CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                      double.tryParse(realtimeToken?.price ?? token.price) ??
                          0.0,
                    ),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: .w700,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                  PriceChangeTextWidget(
                    priceChange:
                        realtimeToken?.priceChange24h ?? token.priceChange24h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
