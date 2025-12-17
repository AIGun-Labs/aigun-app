import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/intel/intel.dart';

enum ContentLayout { tokenFirst, markdownFirst, custom }

class IntellgenceBase extends StatefulWidget {
  const IntellgenceBase({
    super.key,
    required this.intel,
    this.index = 0,
    this.original,
    this.header,
    this.tokenList,
    this.markdown,
    this.videos,
    this.tags,
    this.images,
    this.messageInfo,
    this.layout = ContentLayout.tokenFirst,
  });

  final Intel intel;
  final int index;

  final Widget? original;
  final Widget? tags;
  final Widget? header;
  final Widget? tokenList;
  final Widget? markdown;
  final Widget? videos;
  final Widget? images;
  final Widget? messageInfo;
  final ContentLayout layout;

  @override
  State<IntellgenceBase> createState() => _IntellgenceBaseState();
}

class _IntellgenceBaseState extends State<IntellgenceBase> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      key: ValueKey(widget.intel.id),
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.header != null) ...[
              widget.header!,
              SizedBox(height: 8.h),
            ],
            if (widget.tags != null) ...[widget.tags!, SizedBox(height: 8.h)],
            ..._buildContentWidgets(),
            if (widget.videos != null) widget.videos!,
            if (widget.images != null) widget.images!,
            if (widget.messageInfo != null) widget.messageInfo!,
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContentWidgets() {
    switch (widget.layout) {
      case ContentLayout.tokenFirst:
        return [
          if (widget.tokenList != null) ...[
            widget.tokenList!,
            SizedBox(height: 8.h),
          ],
          if (widget.original != null) ...[
            widget.original!,
            SizedBox(height: 8.h),
          ],
          if (widget.markdown != null) widget.markdown!,
        ];
      case ContentLayout.markdownFirst:
        return [
          if (widget.markdown != null) ...[
            widget.markdown!,
            SizedBox(height: 8.h),
          ],
          if (widget.original != null) ...[
            widget.original!,
            SizedBox(height: 8.h),
          ],
          if (widget.tokenList != null) ...[
            widget.tokenList!,
            SizedBox(height: 8.h),
          ],
        ];

      default:
        return [
          if (widget.tokenList != null) ...[
            widget.tokenList!,
            SizedBox(height: 8.h),
          ],
          if (widget.original != null) ...[
            widget.original!,
            SizedBox(height: 8.h),
          ],
          if (widget.markdown != null) widget.markdown!,
        ];
    }
  }
}
