import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/l10n.dart';
import '../../../themes/themes.dart';
import '../../../utils/url.dart';

class IntelMarkdownAnimated extends StatefulWidget {
  const IntelMarkdownAnimated({
    super.key,
    required this.text,
    required this.isExpanded,
    required this.onTap,
    this.collapsedMaxLines = 3,
  });

  final String text;
  final bool isExpanded;
  final Function(bool) onTap;
  final int collapsedMaxLines;

  @override
  State<IntelMarkdownAnimated> createState() => _IntelMarkdownAnimatedState();
}

class _IntelMarkdownAnimatedState extends State<IntelMarkdownAnimated>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  double _expandedHeight = 0;
  final GlobalKey _contentKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateHeight();
    });
  }

  void _calculateHeight() {
    final RenderBox? renderBox =
        _contentKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _expandedHeight = renderBox.size.height;
      });
    }
  }

  @override
  void didUpdateWidget(IntelMarkdownAnimated oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      setState(() {
        _isExpanded = widget.isExpanded;
      });
    }
    if (widget.text != oldWidget.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _calculateHeight();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final markdownStyle = MarkdownStyleSheet(
      p: TextStyle(fontSize: 16.sp),
      h1: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
      h2: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      h3: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      a: const TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
      blockquote: TextStyle(
        color: Colors.grey[600],
        fontStyle: FontStyle.italic,
      ),
      code: TextStyle(
        backgroundColor: Colors.grey[200],
        fontFamily: 'monospace',
      ),
    );

    final collapsedHeight = widget.collapsedMaxLines * 24.0.sp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Visibility(
              visible: false,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: MarkdownBody(
                key: _contentKey,
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

            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: _isExpanded
                  ? _expandedHeight > 0
                        ? _expandedHeight
                        : null
                  : collapsedHeight,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: MarkdownBody(
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

                  if (!_isExpanded)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(
                                context,
                              ).scaffoldBackgroundColor.withValues(alpha: 0),
                              Theme.of(
                                context,
                              ).scaffoldBackgroundColor.withValues(alpha: 0.8),
                              Theme.of(context).scaffoldBackgroundColor,
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
            widget.onTap(_isExpanded);
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _isExpanded ? S.of(context).collapse : S.of(context).expand,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4.w),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.expand_more,
                    size: 20.sp,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
