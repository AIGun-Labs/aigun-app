import 'package:flutter/material.dart';

mixin FixedHeaderDelegateMixin on SliverPersistentHeaderDelegate {
  double get height;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  // 默认返回 true 确保热重载或状态变更时能刷新
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
