import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 选择项数据模型
class ChoiceItem {
  final String label;
  final String value;

  const ChoiceItem({
    required this.label,
    required this.value,
  });
}

class MultipleChoiceWidget extends StatefulWidget {
  const MultipleChoiceWidget({
    super.key,
    required this.items,
    this.selectedValue,
    this.padding,
    this.onSelected,
  });

  final List<ChoiceItem> items;
  final String? selectedValue;
  final EdgeInsetsGeometry? padding;
  final void Function(String)? onSelected;

  @override
  State<MultipleChoiceWidget> createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
  late final ExpandableController _expandableController;
  late final ValueNotifier<String> _selectedValueNotifier;
  late final ScrollController _scrollController;
  OverlayEntry? _overlayEntry;
  final GlobalKey _expandedKey = GlobalKey();
  final Map<String, GlobalKey> _buttonKeys = {};

  @override
  void initState() {
    super.initState();
    _expandableController = ExpandableController();
    _selectedValueNotifier =
        ValueNotifier<String>(widget.selectedValue ?? widget.items.first.value);
    _scrollController = ScrollController();

    // 为每个按钮创建 GlobalKey
    for (var item in widget.items) {
      _buttonKeys[item.value] = GlobalKey();
    }

    // 监听展开状态变化
    _expandableController.addListener(_onExpandChanged);
  }

  @override
  void didUpdateWidget(MultipleChoiceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当外部传入的 selectedValue 变化时，更新内部状态
    if (widget.selectedValue != null &&
        widget.selectedValue != oldWidget.selectedValue) {
      _selectedValueNotifier.value = widget.selectedValue!;
    }
  }

  @override
  void dispose() {
    _expandableController.removeListener(_onExpandChanged);
    _expandableController.dispose();
    _selectedValueNotifier.dispose();
    _scrollController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onExpandChanged() {
    if (_expandableController.expanded) {
      // 展开时显示遮罩层
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showOverlay();
        }
      });
    } else {
      _removeOverlay();
      // 收起时滚动到选中的按钮
      _scrollToSelectedButton();
    }
  }

  void _scrollToSelectedButton() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final selectedValue = _selectedValueNotifier.value;
      final buttonKey = _buttonKeys[selectedValue];
      if (buttonKey == null) return;

      final RenderBox? renderBox =
          buttonKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      // 获取按钮在滚动视图中的位置
      final buttonPosition = renderBox.localToGlobal(Offset.zero);
      final scrollViewBox = context.findRenderObject() as RenderBox?;
      if (scrollViewBox == null) return;

      final scrollViewPosition = scrollViewBox.localToGlobal(Offset.zero);
      final buttonWidth = renderBox.size.width;
      final viewportWidth = scrollViewBox.size.width;

      // 计算按钮相对于滚动视图的偏移
      final relativeOffset = buttonPosition.dx - scrollViewPosition.dx;

      // 如果按钮不在可见区域，滚动到按钮位置（居中显示）
      if (relativeOffset < 0 || relativeOffset + buttonWidth > viewportWidth) {
        final targetOffset = _scrollController.offset +
            relativeOffset -
            (viewportWidth - buttonWidth) / 2;

        _scrollController.animateTo(
          targetOffset.clamp(
            0.0,
            _scrollController.position.maxScrollExtent,
          ),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _showOverlay() {
    _removeOverlay();

    // 等待展开动画完成后再获取准确位置
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 添加额外延迟确保 expandable 动画完成
      if (!mounted || !_expandableController.expanded) return;

      // 使用 GlobalKey 获取展开内容的准确位置和大小
      final RenderBox? renderBox =
          _expandedKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      final offset = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;

      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          // 从展开内容底部到屏幕底部
          top: offset.dy + size.height,
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              _expandableController.toggle();
            },
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ),
        ),
      );

      Overlay.of(context).insert(_overlayEntry!);
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ExpandableNotifier(
        controller: _expandableController,
        child: Expandable(
          collapsed: _buildCollapsedView(),
          expanded: _buildExpandedView(),
        ),
      ),
    );
  }

  // 收起状态 - 水平滚动视图
  Widget _buildCollapsedView() {
    return Container(
      color: AppColors.background(context),
      child: Row(
        children: [
          // 左侧滚动区域
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: widget.padding ??
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              child: Row(
                spacing: 8.w,
                children: widget.items
                    .map((item) => _buildButton(item, false))
                    .toList(),
              ),
            ),
          ),
          // 右侧展开按钮
          GestureDetector(
            onTap: () {
              _expandableController.toggle();
            },
            child: Container(
              width: 30.w,
              color: AppColors.background(context),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: const Icon(Icons.expand_more),
            ),
          ),
        ],
      ),
    );
  }

  // 展开状态 - 多行显示
  Widget _buildExpandedView() {
    return Container(
      key: _expandedKey,
      color: AppColors.background(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左侧内容区域
          Expanded(
            child: Container(
              padding: widget.padding ??
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: widget.items
                    .map((item) => _buildButton(item, true))
                    .toList(),
              ),
            ),
          ),
          // 右侧收起按钮 - 固定在右上
          GestureDetector(
            onTap: () {
              _expandableController.toggle();
            },
            child: Container(
              width: 30.w,
              height: 46.h,
              color: AppColors.background(context),
              alignment: Alignment.center,
              child: const Icon(Icons.expand_less),
            ),
          ),
        ],
      ),
    );
  }

  // 构建按钮
  Widget _buildButton(ChoiceItem item, bool isExpanded) {
    final buttonKey = _buttonKeys[item.value];

    return ValueListenableBuilder(
      valueListenable: _selectedValueNotifier,
      builder: (context, value, child) {
        final isSelected = value.toString() == item.value;
        return SizedBox(
          key: !isExpanded ? buttonKey : null, // 只在收起状态添加 key 用于定位
          height: 30.h,
          child: TextButton(
            onPressed: () {
              _selectedValueNotifier.value = item.value;
              widget.onSelected?.call(item.value);
              // 只在展开状态下才收起
              if (_expandableController.expanded) {
                _expandableController.toggle();
              }
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                isSelected ? AppColors.foreground(context) : AppColors.quinary,
              ),
              foregroundColor: WidgetStateProperty.all(
                isSelected
                    ? AppColors.background(context)
                    : AppColors.foreground(context),
              ),
              textStyle: WidgetStateProperty.all(
                  TextStyle(fontSize: 14.sp, height: 1.2)),
            ),
            child: Text(
              item.label,
            ),
          ),
        );
      },
    );
  }
}
