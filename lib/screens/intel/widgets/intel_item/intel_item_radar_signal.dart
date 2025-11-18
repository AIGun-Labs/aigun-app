import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/intel/intel.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/language_utils.dart';
import '../chain_single_tags.dart';
import '../intel_token_list.dart';
import 'intel_header.dart';
import 'intel_message.dart';

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
                  onShare: () async {},
                  aiAgent: widget.intel.aiAgent,
                  createAt: widget.intel.createdAtLocal(context),
                  author: widget.intel.author),
              ChainSingleTags(tags: widget.intel.signalTags ?? []),
              IntelSmartMoneyContent(
                text: _isAlphaText(text),
              ),
              IntelTokenList(
                tokens: widget.intel.entities,
              ),
              IntelMessageInfo(
                  // analyzedTime: widget.intel.analyzedTime,
                  monitorTime: widget.intel.monitorTime,
                  type: widget.intel.type)
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
