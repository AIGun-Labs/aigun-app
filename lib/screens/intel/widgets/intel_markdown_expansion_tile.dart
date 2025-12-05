import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/url.dart';

class IntelMarkdownExpansionTile extends StatefulWidget {
  const IntelMarkdownExpansionTile({
    super.key,
    required this.text,
    required this.isExpanded,
    required this.onTap,
  });

  final String text;
  final bool isExpanded;
  final Function(bool) onTap;

  @override
  State<IntelMarkdownExpansionTile> createState() =>
      _IntelMarkdownExpansionTileState();
}

class _IntelMarkdownExpansionTileState
    extends State<IntelMarkdownExpansionTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  void didUpdateWidget(IntelMarkdownExpansionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      setState(() {
        _isExpanded = widget.isExpanded;
      });
    }
  }

  String _getPreviewText(String text, int maxLines) {
    final lines = text.split('\n');
    if (lines.length <= maxLines) {
      return text;
    }
    return '${lines.take(maxLines).join('\n')}...';
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

    // return Theme(
    //   data: Theme.of(context).copyWith(
    //     dividerColor: Colors.transparent,
    //   ),
    //   child: ExpansionTile(
    //     tilePadding: EdgeInsets.zero,
    //     childrenPadding: EdgeInsets.zero,
    //     initiallyExpanded: _isExpanded,
    //     onExpansionChanged: (expanded) {
    //       setState(() {
    //         _isExpanded = expanded;
    //       });
    //       widget.onTap(expanded);
    //     },
    //     trailing: AnimatedRotation(
    //       turns: _isExpanded ? 0.5 : 0,
    //       duration: const Duration(milliseconds: 200),
    //       child: Icon(
    //         Icons.keyboard_arrow_down,
    //         size: 20.sp,
    //         color: AppColors.textSecondary(context),
    //       ),
    //     ),
    //     title: MarkdownBody(
    //       data: _isExpanded ? '' : _getPreviewText(widget.text, 3),
    //       shrinkWrap: true,
    //       styleSheet: markdownStyle,
    //       onTapLink: (text, href, title) {
    //         if (href != null) {
    //           launchUrl(href);
    //         }
    //       },
    //     ),
    //     children: [
    //       if (_isExpanded)
    //         MarkdownBody(
    //           data: widget.text,
    //           shrinkWrap: true,
    //           styleSheet: markdownStyle,
    //           onTapLink: (text, href, title) {
    //             if (href != null) {
    //               launchUrl(href);
    //             }
    //           },
    //         ),
    //     ],
    //   ),
    // );

    return MarkdownBody(
      data: widget.text,
      shrinkWrap: true,
      styleSheet: markdownStyle,
      onTapLink: (text, href, title) {
        if (href != null) {
          launchUrl(href);
        }
      },
    );
  }
}
