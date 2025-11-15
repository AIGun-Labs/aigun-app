import 'package:flutter/material.dart';

import 'refresh_binder.dart';
import 'refresh_controller.dart';
import 'refresh_physics.dart';
import 'sliver_refresh_header.dart';

class RefreshableScrollView extends StatefulWidget {
  const RefreshableScrollView({
    super.key,
    required this.slivers,
    required this.onRefresh,
    this.triggerDistance = 100,
    this.indicatorExtent = 56,
    this.physicsDamping = 0.5,
    this.headerBuilder,
    this.scrollController,
    this.scrollBehavior,
  });

  final List<Widget> slivers;
  final Future<void> Function() onRefresh;

  final double triggerDistance;
  final double indicatorExtent;
  final double physicsDamping;

  final RefreshHeaderBuilder? headerBuilder;
  final ScrollController? scrollController;
  final ScrollBehavior? scrollBehavior;

  @override
  State<RefreshableScrollView> createState() => _RefreshableScrollViewState();
}

class _RefreshableScrollViewState extends State<RefreshableScrollView> {
  late final RefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RefreshController(
      triggerDistance: widget.triggerDistance,
      indicatorExtent: widget.indicatorExtent,
    )..onRefresh = widget.onRefresh;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final view = CustomScrollView(
      controller: widget.scrollController,
      physics: RefreshPhysics(
        controller: _controller,
        damping: widget.physicsDamping,
        parent: const AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        SliverRefreshHeader(
          controller: _controller,
          builder: widget.headerBuilder,
        ),
        ...widget.slivers,
      ],
    );

    return RefreshBinder(
      controller: _controller,
      child: widget.scrollBehavior == null
          ? view
          : ScrollConfiguration(
              behavior: widget.scrollBehavior!,
              child: view,
            ),
    );
  }
}
