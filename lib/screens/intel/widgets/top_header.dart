import 'package:flutter/material.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_cubit.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/trending/trending_state.dart';
import 'package:flutter_aigun/data/models/trending/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/format/string.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart'
    as common_token_model;
import 'package:flutter_aigun/widgets/token_skeleton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LatestDiscoveriesSection extends StatelessWidget {
  const LatestDiscoveriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 13.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildTitle(context),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildItems(context),
                  )),
                  GestureDetector(
                    onTap: () {
                      context.push(Routes.home, extra: NavIndex.trending);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      size: 24.sp,
                      color: AppColors.textQuaternary(context),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItems(BuildContext context) {
    return BlocBuilder<TrendingCubit, TrendingState>(builder: (context, state) {
      final items = Row(
        spacing: 8.w,
        children: [
          ...state.lastestTokens.map((token) => _buildItem(context, token)),
        ],
      );

      return state.status.maybeWhen(
        orElse: () {
          return const HeaderTokenSkeleton(itemCount: 6);
        },
        loading: () {
          // 成功状态，显示真实数据
          if (state.lastestTokens.isEmpty) {
            return const HeaderTokenSkeleton(itemCount: 6);
          }
          return items;
        },
        success: (tokens) {
          // 成功状态，显示真实数据
          if (state.lastestTokens.isEmpty) {
            return const HeaderTokenSkeleton(itemCount: 6);
          }
          return items;
        },
      );
    });
  }

  Widget _buildTitle(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text: S.of(context).latestDiscoveries,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        WidgetSpan(
          child: SizedBox(width: 6.w),
        ),
        TextSpan(
          text: S.of(context).app_title,
          style: TextStyle(
              fontSize: 12.sp, color: AppColors.textQuaternary(context)),
        ),
      ]),
    );
  }

  Widget _buildItem(BuildContext context, LastestToken token) {
    final tokenName = token.name?.split('').first.toUpperCase();
    if (tokenName?.isEmpty ?? true) return const SizedBox.shrink();
    return GestureDetector(
      onTap: () {
        final convertedToken = common_token_model.Token.fromLastestToken(token);
        context.read<FavoriteTokenCubit>().handleFavoriteToken(convertedToken);
        context.read<TokenDetailCubit>().updateToken(convertedToken);
        context.push(Routes.tokenDetail, extra: 'trending');
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          SizedBox(
            width: 40.w,
            height: 40.h,
            child: ClipOval(
              child: SmartNetworkImage(
                url: getImageUrl(token.logo) ?? "",
                width: 40.w,
                height: 40.h,
                errorWidget: Container(
                  width: 40.w,
                  height: 40.h,
                  color: AppColors.tokenPlaceholderColor,
                  child: Center(
                    child: Text(
                      tokenName ?? "",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: AppColors.background(context)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            StringFormatter.truncateWithEllipsis(token.name ?? ""),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11.sp, color: AppColors.textTertiary(context)),
          )
        ],
      ),
    );
  }
}

class TopHeaderTitle extends StatelessWidget {
  const TopHeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text: S.of(context).latestDiscoveries,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        WidgetSpan(
          child: SizedBox(width: 6.w),
        ),
        TextSpan(
          text: S.of(context).app_title,
          style: TextStyle(
              fontSize: 12.sp, color: AppColors.textQuaternary(context)),
        ),
      ]),
    );
  }
}
