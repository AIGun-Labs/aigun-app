import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/themes.dart';

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
    Key? key,
    required this.items,
    this.selectedValue,
    this.onSelected,
    this.spacing = 8.0,
    this.runSpacing = 4.0,
    this.backgroundColor,
    this.expandButton,
    this.collapseButton,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfExpansionNeeded();
    });
  }

  @override
  void didUpdateWidget(ExpandableScrollableWrap oldWidget) {
    super.didUpdateWidget(oldWidget);
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
    _scrollController.dispose();
    _animationController.dispose();
    _removeOverlay();
    _removeExpandedOverlay();
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
    _animationController.reset();
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
    widget.onSelected?.call(item.value);
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
                  children: List.generate(widget.items.length, (index) {
                    final item = widget.items[index];
                    final isSelected = item.value == _currentSelectedValue;

                    return Padding(
                      padding: EdgeInsets.only(right: widget.spacing),
                      child: _buildChoiceChip(item, isSelected),
                    );
                  }),
                ),
              ),
            ),
          ),
          if (_needsExpansion) ...[
            const SizedBox(width: 8),
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
                    size: 20.w,
                  ),
            ),
          ],
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
              padding: EdgeInsets.only(bottom: 6.w),
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
          const SizedBox(width: 8),
          InkWell(
            onTap: _closeExpanded,
            child: widget.collapseButton ??
                Icon(
                  Icons.expand_less,
                  color: AppColors.textQuaternary(context),
                  size: 20.w,
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : AppColors.quinary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          item.label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
