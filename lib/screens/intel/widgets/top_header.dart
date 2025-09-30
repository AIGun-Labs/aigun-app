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

class LatestDiscoveriesSection extends StatefulWidget {
  final ScrollController? scrollController;
  const LatestDiscoveriesSection({super.key, this.scrollController});

  @override
  State<LatestDiscoveriesSection> createState() =>
      _LatestDiscoveriesSectionState();
}

class _LatestDiscoveriesSectionState extends State<LatestDiscoveriesSection> {
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (mounted) {
      setState(() {
        _scrollOffset = widget.scrollController?.position.pixels ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 计算标题的缩放和透明度
    const double maxScroll = 100.0; // 最大滚动距离
    final double scrollProgress = (_scrollOffset / maxScroll).clamp(0.0, 1.0);
    final double scale = 1.0 - scrollProgress; // 缩放从1.0到0.0
    final double opacity = 1.0 - scrollProgress; // 透明度从1.0到0.0
    final double titleHeight = 30.h * (1.0 - scrollProgress); // 标题高度从30.h到0

    // 计算头像的缩放 - 从40到30的大小
    final double avatarSize = 40.w - (10.w * scrollProgress); // 从40.w缩小到30.w
    final double avatarScale = avatarSize / 40.w; // 缩放比例

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 13.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 16), // 流畅动画
                height: titleHeight,
                child: titleHeight > 0
                    ? Opacity(
                        opacity: opacity,
                        child: Transform.scale(
                          scale: scale,
                          alignment: Alignment.centerLeft,
                          child: _buildTitle(context),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 16),
                height: 10.h * (1.0 - scrollProgress), // 间距也随滚动减小
              ),
              Row(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildItems(context, avatarScale),
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

  Widget _buildItems(BuildContext context, double avatarScale) {
    return BlocBuilder<TrendingCubit, TrendingState>(builder: (context, state) {
      final items = Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width - 50.w,
        ),
        padding: EdgeInsets.only(right: 8.w),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...state.lastestTokens
                .map((token) => _buildItem(context, token, avatarScale)),
          ],
        ),
      );

      return state.status.maybeWhen(
        orElse: () {
          return HeaderTokenSkeleton(itemCount: 6, avatarScale: avatarScale);
        },
        loading: () {
          // 成功状态，显示真实数据
          if (state.lastestTokens.isEmpty) {
            return HeaderTokenSkeleton(itemCount: 6, avatarScale: avatarScale);
          }
          return items;
        },
        success: (tokens) {
          // 成功状态，显示真实数据
          if (state.lastestTokens.isEmpty) {
            return HeaderTokenSkeleton(itemCount: 6, avatarScale: avatarScale);
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

  Widget _buildItem(
      BuildContext context, LastestToken token, double avatarScale) {
    final tokenName = token.name?.split('').first.toUpperCase();
    if (tokenName?.isEmpty ?? true) return const SizedBox.shrink();
    final double avatarSize = 40.w * avatarScale;
    final double fontSize = 20.sp * avatarScale;

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
          AnimatedContainer(
            duration: const Duration(milliseconds: 16),
            width: avatarSize,
            height: avatarSize,
            child: ClipOval(
              child: SmartNetworkImage(
                url: getImageUrl(token.logo) ?? "",
                width: avatarSize,
                height: avatarSize,
                errorWidget: Container(
                  width: avatarSize,
                  height: avatarSize,
                  color: AppColors.tokenPlaceholderColor,
                  child: Center(
                    child: Text(
                      tokenName ?? "",
                      style: TextStyle(
                          fontSize: fontSize,
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
