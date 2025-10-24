import "package:flutter/material.dart";
import "package:flutter_aigun/l10n/l10n.dart";
import "package:flutter_aigun/themes/themes.dart";
import "package:flutter_aigun/utils/url.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(IntelMarkdownContent oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
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
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            // 基于字体大小计算收起时的最大高度
            final lineHeight = 16.sp * 1.4; // 行高 = 字体大小 * 行间距系数
            const maxLines = 3; // 收起时最多显示的行数
            final maxCollapsedHeight = lineHeight * maxLines;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              constraints: widget.isExpanded
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
    );
  }
}
