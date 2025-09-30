import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_item/intel_message.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_token_list.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/format/date.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_item/intel_header.dart';

class IntelItemRadarSignal extends StatefulWidget {
  const IntelItemRadarSignal(
      {super.key, required this.intel, required this.index});

  final Intel intel;
  final int index;

  @override
  _IntelItemRadarSignalState createState() => _IntelItemRadarSignalState();
}

class _IntelItemRadarSignalState extends State<IntelItemRadarSignal> {
  @override
  Widget build(BuildContext context) {

    final intelCreateAt = DateUtilsHelper.formatUtcToLocal(
        widget.intel.createdAt ?? DateTime.now(), "HH:mm MM-dd");
    return Padding(
      padding: EdgeInsets.only(top: widget.index == 0 ? 10.h : 0),
      child: Container(
        color: Colors.white,
        key: ValueKey(widget.intel.id),
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            spacing: 8.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntelHeader(
                  aiAgent: widget.intel.aiAgent,
                  createAt: intelCreateAt,
                  author: widget.intel.author),
              IntelTags(tags: widget.intel.signalTags ?? []),
              IntelSmartMoneyContent(text: widget.intel.content ?? ""),
              IntelTokenList(tokens: widget.intel.entities),
              IntelMessageInfo(
                  // analyzedTime: widget.intel.analyzedTime,
                  monitorTime: widget.intel.monitorTime)
            ],
          ),
        ),
      ),
    );
  }
}

class IntelSmartMoneyContent extends StatelessWidget {
  const IntelSmartMoneyContent({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16.sp, color: AppColors.textPrimary(context)),
    );
  }
}

class IntelTags extends StatelessWidget {
  const IntelTags({super.key, required this.tags});
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 0,
      spacing: 8.w,
      children: tags.map((tag) => _buildTag(tag)).toList(),
    );
  }

  Widget _buildTag(String tag) {
    return SizedBox(
      height: 30.h,
      child: Chip(
        padding: EdgeInsets.all(4.r),
        backgroundColor: AppColors.quinary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
        side: const BorderSide(
          color: Colors.transparent,
          width: 0,
        ),
        label: Text(
          tag,
          style: TextStyle(color: AppColors.quaternary, fontSize: 14.sp),
        ),
      ),
    );
  }
}
