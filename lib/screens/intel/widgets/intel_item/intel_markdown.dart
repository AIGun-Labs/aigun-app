import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "../../../../l10n/l10n.dart";
import "../../../../themes/themes.dart";
import "../../../../utils/url.dart";

class IntelMarkdownContent extends StatefulWidget {
  const IntelMarkdownContent({
    super.key,
    required this.text,
    required this.isExpanded,
    required this.onTap,
  });

  final String text;
  final bool isExpanded;
  final Function(bool) onTap;

  @override
  State<IntelMarkdownContent> createState() => _IntelMarkdownContentState();
}

class _IntelMarkdownContentState extends State<IntelMarkdownContent> {
  final _key = GlobalKey();
  bool _needsExpansion = false; // 标记是否需要展开按钮

  @override
  void initState() {
    super.initState();
    // 延迟检查内容高度
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfNeedsExpansion();
    });
  }

  @override
  void didUpdateWidget(IntelMarkdownContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果文本内容变化，重新检查
    if (oldWidget.text != widget.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkIfNeedsExpansion();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 检查内容是否需要展开功能
  void _checkIfNeedsExpansion() {
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final actualHeight = renderBox.size.height;
      final lineHeight = 16.sp * 1.4;
      const maxLines = 3;
      final maxCollapsedHeight = lineHeight * maxLines;

      // 缓冲区比例，用于处理高度计算误差和特殊字符
      const bufferRate = 1.1;

      if (mounted) {
        setState(() {
          _needsExpansion = actualHeight > maxCollapsedHeight * bufferRate;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final markdownStyle = MarkdownStyleSheet(
      p: TextStyle(fontSize: 16.sp, height: 1.4),
      h1: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, height: 1.4),
      h2: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, height: 1.4),
      h3: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, height: 1.4),
      a: const TextStyle(
          height: 1.4,
          color: Colors.blue,
          decoration: TextDecoration.underline),
      blockquote: TextStyle(
        height: 1.4,
        color: Colors.grey[600],
        fontStyle: FontStyle.italic,
      ),
      code: TextStyle(
        height: 1.4,
        backgroundColor: Colors.grey[200],
        fontFamily: 'monospace',
      ),
      pPadding: EdgeInsets.zero,
      blockSpacing: 0,
      listIndent: 24,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            // 基于字体大小计算收起时的最大高度
            final lineHeight = 16.sp * 1.4; // 行高 = 字体大小 * 行间距系数
            const maxLines = 3.2; // 0.2的微调因子解决下沉部问题
            final maxCollapsedHeight = lineHeight * maxLines;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              constraints: widget.isExpanded || !_needsExpansion
                  ? null
                  : BoxConstraints(maxHeight: maxCollapsedHeight),
              clipBehavior: Clip.hardEdge, // 裁剪超出的内容
              decoration:
                  const BoxDecoration(), // 需要添加decoration才能使clipBehavior生效
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(), // 禁用滚动
                child: MarkdownBody(
                  key: _key,
                  data: widget.text,
                  shrinkWrap: true,
                  styleSheet: markdownStyle,
                  onTapLink: (text, href, title) {
                    if (href != null) {
                      launchUrl(href);
                    }
                  },
                ),
              ),
            );
          },
        ),
        // 只有在需要时才显示展开/收起按钮
        if (_needsExpansion) ...[
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () => widget.onTap(!widget.isExpanded),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.isExpanded
                      ? S.of(context).collapse
                      : S.of(context).expand,
                  style: TextStyle(
                    color: AppColors.textSecondary(context),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4.w),
                AnimatedRotation(
                  turns: widget.isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 18.sp,
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
