import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart';
import 'package:flutter_aigun/themes/colors.dart';
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
                    tokenName: token.symbol.isNotEmpty ? token.symbol : '?',
                    chainName:
                        token.chainName.isNotEmpty ? token.chainName : '?',
                    chainLogo: token.chainLogo),
                SizedBox(width: 10.w),
                Flexible(
                  child: SizedBox(
                    height: 45.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              token.symbol,
                              style: TextStyle(
                                fontSize: 18.sp,
                                height: 1.1,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary(context),
                              ),
                            ),
                            Text(
                              CurrencyFormatter.formatWithSymbol(
                                (double.tryParse(token.tokenPrice) ?? 0.0) *
                                    (double.tryParse(token.balance) ?? 0.0),
                                CommonCurrencies().usd.isoCode,
                              ),
                              style: TextStyle(
                                fontSize: 18.sp,
                                height: 1.2,
                                color: AppColors.textPrimary(context),
                              ),
                            ),
                          ],
                        ),
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
                                      : CurrencyFormatter.formatPriceWithSymbol(
                                          token.tokenPrice,
                                        ),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.textSecondary(context),
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                              ],
                            ),
                            Text(
                              CurrencyFormatter.format(
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
