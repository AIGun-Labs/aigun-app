import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "../../../../data/models/intel/intel.dart";

class IntellgenceBase extends StatefulWidget {
  const IntellgenceBase(
      {super.key,
      required this.intel,
      this.index = 0,
      this.original,
      this.header,
      this.tokenList,
      this.markdown,
      this.playerList,
      this.resourcesGrid,
      this.messageInfo});

  final Intel intel;
  final int index;

  final Widget? original;
  final Widget? header;
  final Widget? tokenList;
  final Widget? markdown;
  final Widget? playerList;
  final Widget? resourcesGrid;
  final Widget? messageInfo;

  @override
  State<IntellgenceBase> createState() => _IntellgenceBaseState();
}

class _IntellgenceBaseState extends State<IntellgenceBase> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.index == 0 ? 10.h : 0),
      child: Container(
        color: Colors.white,
        key: ValueKey(widget.intel.id),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            spacing: 8.h,
            children: [
              if (widget.header != null) widget.header!,
              if (widget.tokenList != null) widget.tokenList!,
              if (widget.original != null) widget.original!,
              if (widget.markdown != null) widget.markdown!,
              if (widget.playerList != null) widget.playerList!,
              if (widget.resourcesGrid != null) widget.resourcesGrid!,
              if (widget.messageInfo != null) widget.messageInfo!,
            ],
          ),
        ),
      ),
    );
  }
}
