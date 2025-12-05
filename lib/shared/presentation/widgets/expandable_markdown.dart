import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/themes.dart';

class ExpandableMarkdown extends StatefulWidget {
  final String data;
  final double maxCollapsedHeight; 
  final String expandText;
  final String collapseText;
  final Function(bool)? onTap;
  final bool isExpanded;
  const ExpandableMarkdown({
    super.key,
    required this.data,
    this.maxCollapsedHeight = 100.0, 
    this.expandText = '',
    this.collapseText = '',
    this.onTap,
    this.isExpanded = false,
  });

  @override
  _ExpandableMarkdownState createState() => _ExpandableMarkdownState();
}

class _ExpandableMarkdownState extends State<ExpandableMarkdown> {
  final markdownStyle = MarkdownStyleSheet(
    p: TextStyle(fontSize: 16.sp),
    h1: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
    h2: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
    h3: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    a: const TextStyle(
        color: Colors.blue, decoration: TextDecoration.underline),
    blockquote: TextStyle(
      color: Colors.grey[600],
      fontStyle: FontStyle.italic,
    ),
    code: TextStyle(
      backgroundColor: Colors.grey[200],
      fontFamily: 'monospace',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: widget.isExpanded
                ? const BoxConstraints() 
                : BoxConstraints(maxHeight: widget.maxCollapsedHeight),
            child: ClipRect(
              child: Stack(
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.topLeft,
                children: [
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: MarkdownBody(
                      data: widget.data,
                      styleSheet: markdownStyle,
                      shrinkWrap: true,
                      
                    ),
                  ),

                  
                  if (!widget.isExpanded)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 30, 
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(alpha: 0.0),
                              Colors.white, 
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        
        GestureDetector(
          onTap: widget.onTap != null
              ? () => widget.onTap!(widget.isExpanded)
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.isExpanded ? widget.collapseText : widget.expandText,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textSecondary(context),
                ),
              ),
              AnimatedRotation(
                  turns: widget.isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.expand_more,
                    size: 20.sp,
                    color: AppColors.textSecondary(context),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
