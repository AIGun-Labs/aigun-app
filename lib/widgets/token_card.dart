import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/format/index.dart';
import 'package:flutter_aigun/widgets/token/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2/money2.dart';

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
    final tokenName = token.tokenName.isEmpty ? token.symbol : token.tokenName;
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
                    chainLogoWidth: 20.w,
                    chainLogoHeight: 20.h,
                    width: 50.w,
                    height: 50.w,
                    avatar: token.tokenAvatar,
                    tokenName: token.symbol.isNotEmpty ? token.symbol : '?',
                    chainName:
                        token.chainName.isNotEmpty ? token.chainName : '?',
                    chainLogo: token.chainLogo),
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
                                  double.tryParse(token.tokenPrice
                                          .safeMultiply(token.balance)) ??
                                      0.0),
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
                                      ? token.tokenAddress.isNotEmpty
                                          ? AddressFormatter.formatAddress(
                                              token.tokenAddress)
                                          : token.tokenAddress
                                      : CurrencyFormatter
                                          .abbreviateTokenPriceWithSymbol(
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
                                fontSize: 14.sp,
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
