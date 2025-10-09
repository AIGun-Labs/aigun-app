import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_cubit.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_state.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/widgets/custom_popup.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_aigun/widgets/token/token_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      return const Center(child: Text("No tokens"));
    }

    return SafeArea(
        child: ListView.builder(
            itemCount: tokens?.length,
            itemBuilder: (context, index) {
              if (tokens == null) {
                return const SizedBox.shrink();
              }
              return _buildTokenItem(context, tokens![index]);
            }));
  }

  Widget _buildTokenItem(BuildContext context, Token token) {
    final trailing = CurrencyFormatter.abbreviateTokenPrice(
        double.tryParse(token.tokenPrice.safeMultiply(token.balance)) ?? 0.0);
    final trailingSubtitle = CurrencyFormatter.abbreviateTokenPrice(
        double.tryParse(token.balance) ?? 0.0);

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
          BlocBuilder<FavoriteTokenCubit, FavoriteTokenState>(
            builder: (context, state) {
              final isFavorite =
                  context.read<FavoriteTokenCubit>().isFavoriteToken(token);
              final isActionLoading = state.actionStatus.maybeWhen(
                adding: () => true,
                removing: () => true,
                orElse: () => false,
              );
              return GestureDetector(
                //收藏功能
                onTap: isActionLoading
                    ? null
                    : () {
                        Navigator.of(context).pop();
                        context
                            .read<FavoriteTokenCubit>()
                            .handleFavoriteToken(token);
                      },
                child: SvgPicture.asset(
                  isFavorite
                      ? "assets/images/icons/star-filled.svg"
                      : "assets/images/icons/star-outline.svg",
                  height: 24.w,
                  width: 24.w,
                  colorFilter: ColorFilter.mode(
                    isFavorite ? Colors.yellow : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              );
            },
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
                color: AppColors.textPrimary(context)),
          ),
          subtitleWidget: Text(
            token.tokenName,
            style: TextStyle(
                fontSize: 12.sp, color: AppColors.textQuaternary(context)),
          ),
          trailingWidget: Text(
              CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                  double.tryParse(trailing) ?? 0.0),
              style: TextStyle(
                  fontSize: 16.sp, color: AppColors.textPrimary(context))),
          trailingSubtitleWidget: Text(trailingSubtitle,
              style: TextStyle(
                  fontSize: 14.sp, color: AppColors.textQuaternary(context))),
          onTap: (token) => onTap?.call(token),
          isShowRight: isShowRight),
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
            }));
  }
}
