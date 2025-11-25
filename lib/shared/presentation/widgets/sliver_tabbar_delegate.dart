import 'package:flutter/material.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  const SliverAppBarDelegate(this.tabBar, {required this.backgroundColor});

  final PreferredSizeWidget tabBar;
  final Color backgroundColor;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class SliverWidgetsDelegate extends SliverPersistentHeaderDelegate {
  const SliverWidgetsDelegate(
      {required this.backgroundColor, required this.children});

  final List<PreferredSizeWidget> children;
  final Color backgroundColor;

  @override
  double get minExtent =>
      children.fold(0.0, (sum, widget) => sum + widget.preferredSize.height);

  @override
  double get maxExtent =>
      children.fold(0.0, (sum, widget) => sum + widget.preferredSize.height);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: children,
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
