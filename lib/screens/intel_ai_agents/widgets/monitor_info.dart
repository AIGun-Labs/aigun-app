import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum MonitorStatus {
  notEnabled, // 未启用监控
  enabled, // 已启用监控(无自动交易)
  autoTrading, // 已启用监控(自动交易中)
}

class MonitorStatusConfig {
  final String firstRowText;
  final String? secondRowText;
  final bool showCount;
  final bool showSecondRow;

  const MonitorStatusConfig({
    required this.firstRowText,
    this.secondRowText,
    this.showCount = false,
    this.showSecondRow = false,
  });

  static Map<MonitorStatus, MonitorStatusConfig> getTexts(
          BuildContext context) =>
      {
        MonitorStatus.notEnabled: MonitorStatusConfig(
          firstRowText: S.of(context).monitor_monitorNotEnabled,
          secondRowText: S.of(context).monitor_aiAgentNotConfigured,
          showSecondRow: true,
        ),
        MonitorStatus.enabled: MonitorStatusConfig(
          firstRowText: S.of(context).monitor_monitorEnabled,
          secondRowText: S.of(context).monitor_aiAgentNotConfigured,
          showCount: true,
          showSecondRow: true,
        ),
        MonitorStatus.autoTrading: MonitorStatusConfig(
          firstRowText: S.of(context).monitor_monitorEnabled,
          secondRowText: S.of(context).monitor_aiAgentNotConfigured,
          showCount: true,
          showSecondRow: true,
        ),
      };
}

class MonitorInfo extends StatelessWidget {
  final MonitorStatus status;
  final String? type;
  final int? count;

  const MonitorInfo({
    super.key,
    required this.status,
    this.type,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    final texts = MonitorStatusConfig.getTexts(context);
    final config = texts[status]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFirstRow(context, config),
        if (config.showSecondRow && config.secondRowText != null) ...[
          SizedBox(height: 5.h),
          _buildSecondRow(context, config.secondRowText!),
        ],
      ],
    );
  }

  Widget _buildFirstRow(BuildContext context, MonitorStatusConfig config) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: _buildDot(),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: config.showCount
              ? RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 12.sp, height: 1.2),
                    children: [
                      TextSpan(
                        text: config.firstRowText,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      TextSpan(
                        text: '$count ',
                        style: const TextStyle(color: AppColors.quinary),
                      ),
                      TextSpan(
                        text: type ?? '',
                        style: TextStyle(color: AppColors.textPrimary(context)),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              : Text(
                  config.firstRowText,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ],
    );
  }

  Widget _buildSecondRow(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: _buildDot(),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDot() {
    return Container(
      width: 5.w,
      height: 5.w,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5.r),
      ),
    );
  }
}
