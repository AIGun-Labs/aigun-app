import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';

class InfiniteScrollList<T> extends StatefulWidget {
  final List<T> items;
  final bool isLoading;
  final Future<void> Function() onLoadMore;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;
  final Widget? loadingIndicator;
  final double loadTriggerOffset;
  final Widget? noItemsWidget;

  const InfiniteScrollList({
    super.key,
    required this.items,
    required this.onLoadMore,
    required this.itemBuilder,
    this.isLoading = false,
    this.loadingIndicator,
    this.loadTriggerOffset = 200.0,
    this.noItemsWidget,
  });

  @override
  State<InfiniteScrollList<T>> createState() => _InfiniteScrollListState<T>();
}

class _InfiniteScrollListState<T> extends State<InfiniteScrollList<T>> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void didUpdateWidget(InfiniteScrollList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 检查是否是加载更多完成的情况
    if (oldWidget.items.length < widget.items.length &&
        oldWidget.items.isNotEmpty &&
        _isLoadingMore) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _scrollController.hasClients) {
          // 保持在加载更多之前的位置
          final double previousScrollPosition =
              _scrollController.position.pixels;
          _scrollController.jumpTo(previousScrollPosition);
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  /// 滚动到列表顶部
  void scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollListener() {
    if (!_scrollController.hasClients || widget.items.isEmpty) return;

    // 检查是否需要加载更多
    if (!_isLoadingMore &&
        !widget.isLoading &&
        !_hasError &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent -
                widget.loadTriggerOffset) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    if (!mounted) return;

    if (!_isLoadingMore && !widget.isLoading && widget.items.isNotEmpty) {
      setState(() {
        _isLoadingMore = true;
        _hasError = false;
      });

      try {
        await widget.onLoadMore();
      } catch (e) {
        if (mounted) {
          setState(() {
            _hasError = true;
          });
        }
      } finally {
        // 确保无论如何都会重置加载状态
        if (mounted) {
          setState(() {
            _isLoadingMore = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty && !widget.isLoading) {
      return widget.noItemsWidget ?? const SizedBox.shrink();
    }

    return ListView.builder(
      controller: _scrollController,
      // 关键设置: 保持滚动位置
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: widget.items.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.items.length) {
          return widget.loadingIndicator ??
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    color: AppColors.quinary,
                  ),
                ),
              );
        }

        return widget.itemBuilder(context, index, widget.items[index]);
      },
    );
  }
}
