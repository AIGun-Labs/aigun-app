import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../l10n/l10n.dart';
import '../../shared/presentation/widgets/no_data_widget.dart';
import '../../themes/colors.dart';
import '../../utils/extensions/string.dart';
import '../../utils/format/currency.dart';
import '../custom_popup.dart';
import 'models/token.dart';
import 'token_item.dart';

class TokenList extends StatelessWidget {
  const TokenList({
    super.key,
    required this.onTap,
    this.tokens,
    this.isShowRight = true,
  });

  final Function(Token?)? onTap;
  final List<Token>? tokens;
  final bool isShowRight;

  @override
  Widget build(BuildContext context) {
    // if no tokens, show no tokens text
    if (tokens == null || tokens!.isEmpty) {
      return NoDataWidget(errorTextDesc: S.of(context).noTokens);
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.only(right: 10.w),
        child: ListView.builder(
          itemCount: tokens?.length,
          itemBuilder: (context, index) {
            if (tokens == null) {
              return const SizedBox.shrink();
            }

            return _buildTokenItem(context, tokens![index]);
          },
        ),
      ),
    );
  }

  Widget _buildTokenItem(BuildContext context, Token token) {
    final trailing = CurrencyFormatter.abbreviateTokenPriceWithSymbol(
      double.tryParse(token.tokenPrice.safeMultiply(token.balance)) ?? 0.0,
    );
    final trailingSubtitle = CurrencyFormatter.abbreviateTokenPrice(
      double.tryParse(token.balance) ?? 0.0,
    );

    return CustomPopup(
      contentRadius: 3.r,
      showArrow: true,
      arrowColor: Colors.black.withValues(alpha: 0.8),
      barrierColor: Colors.transparent,
      backgroundColor: Colors.black.withValues(alpha: 0.8),
      isLongPress: true,
      position: PopupPosition.top,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 15.w,
        children: [
          GestureDetector(
            onTap: null,
            child: SvgPicture.asset(
              'assets/images/icons/star-outline.svg',
              height: 24.w,
              width: 24.w,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ],
      ),
      child: TokenItem(
        token: token,
        titleWidget: Text(
          token.symbol,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary(context),
          ),
        ),
        subtitleWidget: Text(
          token.tokenName,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textQuaternary(context),
          ),
        ),
        trailingWidget: Text(
          // CurrencyFormatter.abbreviateTokenPriceWithSymbol(
          //     double.tryParse(trailing) ?? 0.0),
          trailing,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textPrimary(context),
          ),
        ),
        trailingSubtitleWidget: Text(
          trailingSubtitle,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textQuaternary(context),
          ),
        ),
        onTap: (token) => onTap?.call(token),
        isShowRight: isShowRight,
      ),
    );
  }
}

class TokenListSkeleton extends StatelessWidget {
  const TokenListSkeleton({super.key, this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return const TokenItemSkeleton();
        },
      ),
    );
  }
}
