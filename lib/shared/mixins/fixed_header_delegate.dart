import 'package:flutter/material.dart';

mixin FixedHeaderDelegateMixin on SliverPersistentHeaderDelegate {
  double get height;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
