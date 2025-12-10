import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

// import 'package:provider/provider.dart';

import '../../../core/router/constants.dart';
import '../../../core/router/routes/app_routes.dart';
import '../../../core/service_locator.dart';
import '../../../cubits/index.dart';
import '../../../data/models/token/query_token/query_token.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/domain/mappers/query_token_mapper.dart';
import '../../../themes/colors.dart';
import '../../../utils/colors.dart';
import '../../../utils/extensions/string.dart';
import '../../../utils/format/currency.dart';
import '../../../utils/format/number.dart';
import '../../../utils/format/numeric.dart';
import '../../../utils/validators/token_validator.dart';
import '../../../widgets/avatar/widget/token.dart';
import '../../../widgets/token/models/token.dart';

class QueryTokenItem extends StatelessWidget {
  const QueryTokenItem({super.key, required this.token});

  final QueryToken token;

  void _handleTokenTap(BuildContext context) {
    final isLoggedIn = getIt<UserCubit>().state.isLoggedIn;

    if (!isLoggedIn) {
      context.pushNamed(RouteNames.login);
      return;
    }

    getIt<QuickTradeCubit>().updateSelectedToken(Token.fromQueryToken(token));
    TokenDetailRoute(token.toTokenEntity(), type: 'query').push(context);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleTokenTap(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarToken(
              avatar: token.logo,
              chainLogo: token.networkLogo,
              chainLogoWidth: 24.w,
              chainLogoHeight: 24.w,
              tokenName: token.symbol,
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          token.symbol ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                          double.tryParse(token.priceUsd ?? '') ?? 0.0,
                        ),
                        style: TextStyle(
                          color: AppColors.foreground(context),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TokenValidator.shouldShowAddress(
                            token.isNative ?? false,
                            token.network ?? '',
                          )
                          ? Text(
                              // Web3Address.desensitization(token?.address ?? ""),
                              token.address?.splitStartAndEnd(4, 4) ?? '',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textTertiary(context),
                              ),
                            )
                          : const SizedBox.shrink(),
                      Text(
                        NumericFormatter.formatWithSign(
                          double.tryParse(
                                token.priceChange24h
                                        ?.toDouble()
                                        .toStringAsFixed(2) ??
                                    '',
                              ) ??
                              0.0,
                          suffix: '%',
                        ),
                        style: TextStyle(
                          color: ColorsHelper.getColorByValueWithZeroColor(
                            double.tryParse(token.priceChange24h ?? '') ?? 0.0,
                            zeroColor: AppColors.textTertiary(context),
                          ),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${S.of(context).liquidity}: ${formatPriceEnglish(double.tryParse(token.liquidity ?? "") ?? 0.0) ?? ""}",
                          style: TextStyle(
                            color: AppColors.textTertiary(context),
                            fontSize: 14.sp,
                          ),
                        ),
                        Container(
                          height: 10.w,
                          width: 1.w,
                          color: AppColors.textTertiary(context),
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                        ),
                        Text(
                          "${S.of(context).volume24h}: ${formatPriceEnglish(double.tryParse(token.volume24h ?? "") ?? 0.0) ?? ""}",
                          style: TextStyle(
                            color: AppColors.textTertiary(context),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class QueryTokenItemInfo extends StatelessWidget {
//   const QueryTokenItemInfo({super.key, this.token});

//   final Token? token;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'BTC',
//           style: TextStyle(
//               color: Colors.black,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w700),
//         ),
//         Text(
//           Web3Address.desensitization(token?.address ?? ""),
//           style: TextStyle(
//               fontSize: 14.sp, color: AppColors.textTertiary(context)),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               "流动性: \$592",
//               style: TextStyle(color: AppColors.textTertiary(context)),
//             ),
//             Container(
//               height: 10.h,
//               width: 1.w,
//               color: AppColors.textTertiary(context),
//               margin: EdgeInsets.symmetric(horizontal: 10.w),
//             ),
//             Text(
//               "24h  成交额：\$8,690",
//               style: TextStyle(color: AppColors.textTertiary(context)),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// // }

// class QueryTokenItemAmounts extends StatelessWidget {
//   const QueryTokenItemAmounts({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           "\$1.39",
//           style: TextStyle(
//               color: Colors.black,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.bold),
//         ),
//         Text(
//           "-13.9",
//           style: TextStyle(color: AppColors.secondary, fontSize: 14.sp),
//         )
//       ],
//     );
//   }
// }
