import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/themes.dart';

class ChoiceItem {
  final String label;
  final String value;

  const ChoiceItem({
    required this.label,
    required this.value,
  });
}

class ExpandableScrollableWrap extends StatefulWidget {
  final List<ChoiceItem> items;

  final double spacing;
  final double runSpacing;
  final Widget? expandButton; // 可选，默认在使用时提供
  final Widget? collapseButton; // 可选，默认在使用时提供
  final String? selectedValue;
  final void Function(String)? onSelected;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  const ExpandableScrollableWrap({
    super.key,
    required this.items,
    this.selectedValue,
    this.onSelected,
    this.spacing = 8.0,
    this.runSpacing = 4.0,
    this.backgroundColor,
    this.expandButton,
    this.collapseButton,
    this.padding = EdgeInsets.zero,
  });

  @override
  _ExpandableScrollableWrapState createState() =>
      _ExpandableScrollableWrapState();
}

class _ExpandableScrollableWrapState extends State<ExpandableScrollableWrap>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late String _currentSelectedValue;
  final ScrollController _scrollController = ScrollController();
  bool _needsExpansion = false;
  OverlayEntry? _overlayEntry;
  OverlayEntry? _expandedOverlayEntry;
  final GlobalKey _collapsedKey = GlobalKey();
  final GlobalKey _expandedContentKey = GlobalKey();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isDisposed = false;

  List<GlobalKey> _itemKeys = [];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _currentSelectedValue = widget.selectedValue ??
        (widget.items.isNotEmpty ? widget.items.first.value : '');

    _itemKeys = List.generate(widget.items.length, (index) => GlobalKey());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfExpansionNeeded();
      _scrollToSelectedItem();
    });
  }

  @override
  void didUpdateWidget(ExpandableScrollableWrap oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 如果选项数量变化，重新生成 keys
    if (widget.items.length != oldWidget.items.length) {
      _itemKeys = List.generate(widget.items.length, (index) => GlobalKey());
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkIfExpansionNeeded();
      });
    }

    if (widget.selectedValue != null &&
        widget.selectedValue != oldWidget.selectedValue) {
      _currentSelectedValue = widget.selectedValue!;
    }

    if (widget.items.length != oldWidget.items.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkIfExpansionNeeded();
      });
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _removeOverlay();
    _removeExpandedOverlay();
    _scrollController.dispose();
    _animationController.dispose();

    super.dispose();
  }

  void _showExpandedOverlay() {
    _removeExpandedOverlay();
    _removeOverlay();

    final RenderBox? renderBox =
        _collapsedKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _expandedOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy,
        left: offset.dx,
        right: MediaQuery.of(context).size.width - offset.dx - size.width,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            key: _expandedContentKey,
            color: Colors.transparent,
            child: _buildExpandedView(),
          ),
        ),
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(_expandedOverlayEntry!);

    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _createBackgroundOverlay(offset.dy);
    });
  }

  void _createBackgroundOverlay(double collapsedTop) {
    if (!mounted) return;

    final RenderBox? expandedBox =
        _expandedContentKey.currentContext?.findRenderObject() as RenderBox?;

    double maskTop;
    if (expandedBox != null) {
      final expandedOffset = expandedBox.localToGlobal(Offset.zero);
      final expandedHeight = expandedBox.size.height;
      maskTop = expandedOffset.dy + expandedHeight;
    } else {
      maskTop = collapsedTop + 100;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: maskTop,
        left: 0,
        right: 0,
        bottom: 0,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: GestureDetector(
            onTap: _closeExpanded,
            behavior: HitTestBehavior.opaque,
            child: Container(
              color: Colors.black.withValues(alpha: .5),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void _closeExpanded() {
    _animationController.reverse().then((_) {
      if (mounted) {
        setState(() {
          _isExpanded = false;
        });
        _removeOverlay();
        _removeExpandedOverlay();
      }
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _removeExpandedOverlay() {
    _expandedOverlayEntry?.remove();
    _expandedOverlayEntry = null;
    // 只有在未 dispose 时才重置 controller
    if (!_isDisposed) {
      _animationController.reset();
    }
  }

  void _checkIfExpansionNeeded() {
    if (!mounted) return;

    if (_scrollController.hasClients) {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final needsExpansion = maxScrollExtent > 0;

      if (_needsExpansion != needsExpansion) {
        setState(() {
          _needsExpansion = needsExpansion;
        });
      }
    }
  }

  void _handleItemTap(ChoiceItem item) {
    setState(() {
      _currentSelectedValue = item.value;
    });

    if (_isExpanded) {
      // 改为检查是否处于展开状态
      _closeExpanded();
    }

    widget.onSelected?.call(item.value);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedItem();
    });
  }

  void _scrollToSelectedItem() {
    if (!mounted || !_scrollController.hasClients) return;

    // 找到选中项的索引
    final selectedIndex = widget.items.indexWhere(
      (item) => item.value == _currentSelectedValue,
    );

    if (selectedIndex == -1 || selectedIndex >= _itemKeys.length) return;

    final itemKey = _itemKeys[selectedIndex];
    final itemContext = itemKey.currentContext;

    if (itemContext == null) return;

    // 获取选中项的 RenderBox
    final RenderBox itemBox = itemContext.findRenderObject() as RenderBox;
    final itemPosition = itemBox.localToGlobal(Offset.zero);
    final itemWidth = itemBox.size.width;

    // 获取滚动容器的信息
    final scrollPosition = _scrollController.position;
    final viewportWidth = scrollPosition.viewportDimension;
    final currentOffset = scrollPosition.pixels;

    // 计算选中项相对于滚动容器的位置
    final collapsedContext = _collapsedKey.currentContext;
    if (collapsedContext == null) return;

    final RenderBox collapsedBox =
        collapsedContext.findRenderObject() as RenderBox;
    final collapsedPosition = collapsedBox.localToGlobal(Offset.zero);

    // 计算选中项在滚动内容中的偏移
    final itemOffsetInScroll =
        itemPosition.dx - collapsedPosition.dx + currentOffset;

    // 计算目标滚动位置（让选中项居中或可见）
    double targetOffset;

    // 如果选项在视口右侧之外
    if (itemOffsetInScroll + itemWidth > currentOffset + viewportWidth) {
      targetOffset =
          itemOffsetInScroll + itemWidth - viewportWidth + 20; // 20 为右侧边距
    }
    // 如果选项在视口左侧之外
    else if (itemOffsetInScroll < currentOffset) {
      targetOffset = itemOffsetInScroll - 20; // 20 为左侧边距
    }
    // 选项已在可见范围内
    else {
      return;
    }

    // 确保目标偏移在有效范围内
    targetOffset = targetOffset.clamp(0.0, scrollPosition.maxScrollExtent);

    // 平滑滚动到目标位置
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfExpansionNeeded();
    });

    return _buildCollapsedView();
  }

  Widget _buildCollapsedView() {
    return Padding(
      padding: widget.padding,
      child: Row(
        key: _collapsedKey,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white, // 左边不透明
                    Colors.white, // 中间不透明
                    Colors.transparent, // 右边缘透明（产生遮挡效果）
                  ],
                  stops: [0.0, 0.95, 1.0], // 右侧15%区域渐变
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification ||
                      notification is ScrollEndNotification) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _checkIfExpansionNeeded();
                    });
                  }
                  return false;
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: widget.spacing,
                    children: List.generate(widget.items.length, (index) {
                      final item = widget.items[index];
                      final isSelected = item.value == _currentSelectedValue;

                      return Container(
                        key: _itemKeys[index],
                        child: _buildChoiceChip(item, isSelected),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          if (_needsExpansion)
            InkWell(
              onTap: () {
                if (_isExpanded) return;

                setState(() {
                  _isExpanded = true;
                });
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _showExpandedOverlay();
                });
              },
              child: widget.expandButton ??
                  Icon(
                    Icons.expand_more,
                    color: AppColors.textQuaternary(context),
                    size: 28.w,
                  ),
            ),
        ],
      ),
    );
  }

  Widget _buildExpandedView() {
    return Container(
      // padding: widget.padding,
      color:
          widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 13.h),
              child: Wrap(
                spacing: widget.spacing,
                runSpacing: widget.runSpacing,
                children: widget.items.map((item) {
                  final isSelected = item.value == _currentSelectedValue;
                  return _buildChoiceChip(item, isSelected);
                }).toList(),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          InkWell(
            onTap: _closeExpanded,
            child: widget.collapseButton ??
                Icon(
                  Icons.expand_less,
                  color: AppColors.textQuaternary(context),
                  size: 28.w,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceChip(ChoiceItem item, bool isSelected) {
    return GestureDetector(
      onTap: () => _handleItemTap(item),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : AppColors.quinary,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          item.label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 12.sp,
            height: 1.2.h,
          ),
        ),
      ),
    );
  }
}
