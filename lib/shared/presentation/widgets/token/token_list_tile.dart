import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../themes/colors.dart';
import '../../../../utils/format/currency.dart';
import '../../../../utils/format/number.dart';
import '../../../../widgets/avatar/widget/token.dart';
import '../../../../widgets/custom_popup.dart';
import '../../../../widgets/token/models/token.dart';


class TokenListTile extends StatefulWidget {
  final int index;
  final Token token;
  final VoidCallback? onTap;
  final VoidCallback? onTopTap;

  const TokenListTile({
    super.key,
    required this.index,
    required this.token,
    this.onTap,
    this.onTopTap,
  });

  @override
  State<TokenListTile> createState() => _TokenListTileState();
}

class _TokenListTileState extends State<TokenListTile> {
  _buildFavoriteButton(BuildContext context, Token token) {
    return GestureDetector(
      
      onTap: null,
      child: SvgPicture.asset(
        'assets/images/icons/star-outline.svg',
        height: 24.w,
        width: 24.w,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPopup(
        offsetY: 90.h,
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
            if (widget.onTopTap != null)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  widget.onTopTap?.call();
                },
                child: SvgPicture.asset(
                  'assets/images/icons/top-line-outline.svg',
                  height: 24.w,
                  width: 24.w,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            _buildFavoriteButton(context, widget.token),
          ],
        ),
        child: InkWell(
          onTap: widget.onTap,
          child: ListTile(
            key: ValueKey('trending_item_${widget.index}'),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            horizontalTitleGap: 12.w,
            leading: ClipOval(
              child: AvatarToken(
                avatar: widget.token.tokenAvatar,
                tokenName: widget.token.symbol,
                width: 40.w,
                height: 40.w,
              ),
            ),
            title: Text(
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary(context),
              ),
              maxLines: 1,
              widget.token.symbol,
            ),
            subtitle: Text(
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary(context),
              ),
              formatPriceEnglish(widget.token.marketCap ?? 0),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary(context),
                  ),
                  CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                    double.tryParse(widget.token.tokenPrice) ?? 0.0,
                  ),
                ),
                Text(
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: (widget.token.priceChange24h ?? 0) > 0
                        ? AppColors.septenary
                        : AppColors.secondary,
                  ),
                  '${widget.token.priceChange24h?.toString()}%',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
