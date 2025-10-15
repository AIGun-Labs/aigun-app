import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/token/query_token/query_token.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/address_utils.dart';
import 'package:flutter_aigun/utils/colors.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/format/desensitization.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/utils/format/numeric.dart';
import 'package:flutter_aigun/utils/web3/address.dart';
import 'package:flutter_aigun/widgets/avatar/widget/token.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class QueryTokenItem extends StatelessWidget {
  const QueryTokenItem({
    super.key,
    required this.token,
  });

  final QueryToken token;

  void _handleTokenTap(BuildContext context) {
    final isLoggedIn = context.read<UserCubit>().state.isLoggedIn;

    if (!isLoggedIn) {
      context.push(Routes.login);
      return;
    }

    context.read<TokenDetailCubit>().updateToken(Token.fromQueryToken(token));

    context
        .read<QuickTradeCubit>()
        .updateSelectedToken(Token.fromQueryToken(token));
    context.push(Routes.tokenDetail, extra: "query");
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
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        token.name ?? "",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                          double.tryParse(token.priceUsd ?? "") ?? 0.0),
                      style: TextStyle(
                          color: AppColors.foreground(
                            context,
                          ),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // Web3Address.desensitization(token?.address ?? ""),
                      token.address?.splitStartAndEnd(4, 4) ?? "",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textTertiary(context)),
                    ),
                    Text(
                      "${NumericFormatter.formatWithSign(double.tryParse(token.priceChange24h ?? "") ?? 0.0)}%",
                      style: TextStyle(
                          color: ColorsHelper.getColorByValueWithZeroColor(
                              double.tryParse(token.priceChange24h ?? "") ??
                                  0.0,
                              zeroColor: AppColors.textTertiary(context)),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "流动性: ${formatPriceEnglish(double.tryParse(token.liquidity ?? "") ?? 0.0) ?? ""}",
                      style: TextStyle(color: AppColors.textTertiary(context)),
                    ),
                    Container(
                      height: 10.h,
                      width: 1.w,
                      color: AppColors.textTertiary(context),
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                    ),
                    Text(
                      "24h  成交额：${formatPriceEnglish(double.tryParse(token.volume24h ?? "") ?? 0.0) ?? ""}",
                      style: TextStyle(color: AppColors.textTertiary(context)),
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class QueryTokenItemInfo extends StatelessWidget {
  const QueryTokenItemInfo({super.key, this.token});

  final Token? token;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BTC',
          style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700),
        ),
        Text(
          Web3Address.desensitization(
              "werjklsudjfqwkjlwerjklsudjfqwkjlwerjklsudjfqwkjl"),
          style: TextStyle(
              fontSize: 14.sp, color: AppColors.textTertiary(context)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "流动性: \$592",
              style: TextStyle(color: AppColors.textTertiary(context)),
            ),
            Container(
              height: 10.h,
              width: 1.w,
              color: AppColors.textTertiary(context),
              margin: EdgeInsets.symmetric(horizontal: 10.w),
            ),
            Text(
              "24h  成交额：\$8,690",
              style: TextStyle(color: AppColors.textTertiary(context)),
            ),
          ],
        )
      ],
    );
  }
}

class QueryTokenItemAmounts extends StatelessWidget {
  const QueryTokenItemAmounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "\$1.39",
          style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "-13.9",
          style: TextStyle(color: AppColors.secondary, fontSize: 14.sp),
        )
      ],
    );
  }
}
