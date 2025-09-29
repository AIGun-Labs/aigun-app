import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'dart:math' as math;

// 定义公共接口
abstract class TrendingTabBarController {
  void updateShrinkRatio(double ratio);
}

class TrendingTabBarDelegate extends StatefulWidget {
  final double minHeight;
  final double maxHeight;
  final Function(TrendingTabBarController)? onTabBarCreated;

  const TrendingTabBarDelegate({
    super.key,
    required this.minHeight,
    required this.maxHeight,
    this.onTabBarCreated,
  });

  @override
  State<TrendingTabBarDelegate> createState() => _TrendingTabBarDelegateState();
}

class _TrendingTabBarDelegateState extends State<TrendingTabBarDelegate>
    implements TrendingTabBarController {
  double _shrinkRatio = 0.0;
  List<Widget>? _cachedTabs;
  double _lastCachedRatio = -1.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadImages();
      if (widget.onTabBarCreated != null) {
        widget.onTabBarCreated!(this);
      }
    });
  }

  void _preloadImages() {
    const imagePaths = [
      'assets/images/trending/hot_icon.png',
      'assets/images/trending/ai_agent_icon.png',
      'assets/images/trending/trend_icon.png',
    ];

    for (final path in imagePaths) {
      if (mounted) {
        precacheImage(AssetImage(path), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentHeight = math.max(
      widget.minHeight,
      widget.maxHeight - (widget.maxHeight - widget.minHeight) * _shrinkRatio,
    );

    return RepaintBoundary(
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: AppColors.foreground(context),
        indicatorWeight: 0,
        indicator: UnderlineTabIndicator(
          insets: EdgeInsets.symmetric(horizontal: 46.w),
          borderSide: BorderSide(
            width: 3.h,
            color: AppColors.foreground(context),
          ),
        ),
        labelColor: AppColors.foreground(context),
        unselectedLabelColor: AppColors.textSecondary(context),
        tabs: [
          _buildAdaptiveTab(
            title: S.of(context).hot,
            iconPath: 'assets/images/trending/hot_icon.png',
            shrinkRatio: _shrinkRatio,
            currentHeight: currentHeight,
          ),
          _buildAdaptiveTab(
            title: S.of(context).aiAgent,
            iconPath: 'assets/images/trending/ai_agent_icon.png',
            shrinkRatio: _shrinkRatio,
            currentHeight: currentHeight,
          ),
          _buildAdaptiveTab(
            title: S.of(context).trending,
            iconPath: 'assets/images/trending/trend_icon.png',
            shrinkRatio: _shrinkRatio,
            currentHeight: currentHeight,
          ),
        ],
      ),
    );
  }

  Widget _buildAdaptiveTab({
    required String title,
    required String iconPath,
    required double shrinkRatio,
    required double currentHeight,
  }) {
    // 计算CachedImage的动画高度和透明度
    final imageHeight = (1.0 - shrinkRatio) * 30.h;
    final imageOpacity = math.max(0.0, 1.0 - shrinkRatio * 2.0);

    return Tab(
      height: currentHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 图标容器 - 直接控制CachedImage的高度和透明度
          Opacity(
            opacity: imageOpacity,
            child: SizedBox(
              height: imageHeight, // 动画控制图片高度
              width: 30.w,
              child: imageHeight > 2.h
                  ? CachedImage(
                      imageUrl: iconPath,
                      width: 30.w,
                      height: imageHeight,
                      fit: BoxFit.contain,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          // 文字
          Text(title,
              style: TextStyle(
                  fontSize: (14 + 6 * shrinkRatio).sp,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  // 更新收缩比例，实时变化无动画
  void updateShrinkRatio(double ratio) {
    if (mounted) {
      final newRatio = math.min(1.0, math.max(0.0, ratio));
      if (newRatio != _shrinkRatio) {
        setState(() {
          _shrinkRatio = newRatio;
        });
      }
    }
  }
}
