import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_item/intel_message.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_token_list.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/format/date.dart';
import 'package:flutter_aigun/utils/language_utils.dart';
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
    // createdAt 已在数据层转换为本地时间，直接格式化即可
    final intelCreateAt = formatDate(widget.intel.createdAt ?? DateTime.now(),
        format: "HH:mm MM-dd");

    final text = LanguageUtils.getAnalyzedText(context, widget.intel.analyzed);
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
                  onShare: () async {
                    // await SharePlus.instance.share(ShareParams(
                    //   text: widget.intel.content ?? "",
                    //   subject: widget.intel.content ?? "",
                    //   title: widget.intel.title ?? "",
                    // ));
                  },
                  aiAgent: widget.intel.aiAgent,
                  createAt: intelCreateAt,
                  author: widget.intel.author),
              IntelTags(tags: widget.intel.signalTags ?? []),
              IntelSmartMoneyContent(
                text: _isAlphaText(text),
              ),
              IntelTokenList(
                  tokens: widget.intel.entities,
                  score: widget.intel.score ?? 0),
              IntelMessageInfo(
                  // analyzedTime: widget.intel.analyzedTime,
                  monitorTime: widget.intel.monitorTime)
            ],
          ),
        ),
      ),
    );
  }

  String _isAlphaText(String analyzed) {
    if (widget.intel.extraDatas?.isAlpha == false) {
      return analyzed;
    }
    final tokenKeys = widget.intel.tokenKeys ?? [];

    final newTokenKeys =
        tokenKeys.isNotEmpty ? tokenKeys.join(",") : S.of(context).relatedToken;

    final newText = (widget.intel.entities?.length ?? 0) > 0
        ? analyzed
        : "$analyzed ${S.of(context).tokenNotTrading(newTokenKeys)}";
    return newText;
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
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      runSpacing: 0,
      spacing: 8.w,
      children: tags.map((tag) => _buildTag(tag)).toList(),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      height: 30.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.quinary,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: AppColors.quaternary,
          fontSize: 14.sp,
          height: 1,
        ),
      ),
    );
    // return SizedBox(
    //   height: 30.h,
    //   child: Chip(
    //     padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0),
    //     labelPadding: EdgeInsets.zero,
    //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //     backgroundColor: AppColors.quinary,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(5.r),
    //     ),
    //     side: const BorderSide(
    //       color: Colors.transparent,
    //       width: 0,
    //     ),
    //     label: Text(
    //       tag,
    //       style: TextStyle(
    //         color: AppColors.quaternary,
    //         fontSize: 14.sp,
    //         height: 1,
    //       ),
    //     ),
    //   ),
    // );
  }
}
