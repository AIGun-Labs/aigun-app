import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';
import '../utils/extensions/string.dart';
import '../utils/format/currency.dart';
import '../utils/format/index.dart';
import 'token/index.dart';
import 'token/models/token.dart';

class TokenCard extends StatelessWidget {
  final Token token;
  final bool showAddress;
  final VoidCallback onTap;
  // final Address addressInfo;

  const TokenCard({
    super.key,
    // required this.addressInfo,
    required this.token,
    required this.showAddress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tokenName = token.symbol.isEmpty ? token.tokenName : token.symbol;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AvatarToken(
                  // chainLogoWidget: DynamicImage(imageUrl: chainLogo),
                  // tokenAvatarWidget: DynamicImage(imageUrl: tokenAvatar),
                  chainLogoWidth: 20.w,
                  chainLogoHeight: 20.h,
                  width: 50.w,
                  height: 50.w,
                  avatar: token.tokenAvatar,
                  tokenName: token.symbol.isNotEmpty ? token.symbol : '?',
                  chainName: token.chainName.isNotEmpty ? token.chainName : '?',
                  chainLogo: token.chainLogo,
                ),
                SizedBox(width: 16.w),
                Flexible(
                  child: SizedBox(
                    height: 45.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tokenName.truncateWithCharCount(12),
                              style: TextStyle(
                                fontSize: 18.sp,
                                height: 1.1,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary(context),
                              ),
                            ),
                            Text(
                              CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                                double.tryParse(
                                      token.tokenPrice.safeMultiply(
                                        token.balance,
                                      ),
                                    ) ??
                                    0.0,
                              ),
                              style: TextStyle(
                                fontSize: 18.sp,
                                height: 1.2,
                                color: AppColors.textPrimary(context),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  showAddress
                                      ? token.address.isNotEmpty
                                            ? AddressFormatter.formatAddress(
                                                token.address,
                                              )
                                            : token.address
                                      : CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                                          double.tryParse(token.tokenPrice) ??
                                              0.0,
                                        ),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.textSecondary(context),
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                              ],
                            ),
                            Text(
                              CurrencyFormatter.abbreviateTokenPrice(
                                double.tryParse(token.balance) ?? 0.0,
                              ),
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.textSecondary(context),
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.w),
          ],
        ),
      ),
    );
  }
}
