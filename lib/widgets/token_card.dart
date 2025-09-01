import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/format/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  Widget _buildNetworkImage(String url) {
    // 检查是否为SVG格式
    if (url.toLowerCase().endsWith('.svg')) {
      return SvgPicture.network(
        url,
        fit: BoxFit.cover,
        placeholderBuilder: (context) => Container(
          width: 18.w,
          height: 18.w,
          color: AppColors.pageBg2Dark,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorBuilder: (context, error, stackTrace) => Container(
          width: 18.w,
          height: 18.w,
          color: AppColors.pageBg2Dark,
          child: const Icon(Icons.error),
        ),
      );
    }

    // 对于位图格式，使用CachedNetworkImage
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: 18.w,
        height: 18.w,
        color: AppColors.pageBg2Dark,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: 18.w,
        height: 18.w,
        color: AppColors.pageBg2Dark,
        child: const Icon(Icons.error),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 45.w,
                      height: 45.w,
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        // color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(22.5.w),
                      ),
                      // child: ClipOval(
                      //   child: CachedImage(
                      //     imageUrl: token.symbol,
                      //     fit: BoxFit.cover,
                      //     width: 45.w,
                      //     height: 45.w,
                      //   ),
                      // ),
                      child: Text(
                        token.symbol.split('').first,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 18.w,
                        height: 18.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1.w,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: _buildNetworkImage(token.chainLogo),
                        ),
                        // child: Text(token.chainLogo),
                      ),
                    ),
                  ],
                ),
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
                              ),
                            ),
                            Text(
                              CurrencyFormatter.format(
                                double.tryParse(token.balance) ?? 0.0,
                              ),
                              style: TextStyle(
                                fontSize: 18.sp,
                                height: 1.2,
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
                                      : CurrencyFormatter.formatWithSymbol(
                                          double.tryParse(token.tokenPrice) ??
                                              0.0,
                                          CommonCurrencies().usd.isoCode,
                                        ),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  '+0',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.green,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              // 代币价值
                              CurrencyFormatter.formatWithSymbol(
                                (double.tryParse(token.tokenPrice) ?? 0.0) *
                                    (double.tryParse(token.balance) ?? 0.0),
                                CommonCurrencies().usd.isoCode,
                              ),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
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
