import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/intel_back/intel.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'investment_item.dart';

class InvestmentOpportunities extends StatefulWidget {
  final List<IntelEntity> entities;

  const InvestmentOpportunities({
    super.key,
    required this.entities,
  });

  @override
  State<InvestmentOpportunities> createState() =>
      _InvestmentOpportunitiesState();
}

class _InvestmentOpportunitiesState extends State<InvestmentOpportunities> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final displayCount = _isExpanded ? widget.entities.length : 2;
    final remainingCount = widget.entities.length - 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.entities.isNotEmpty) ...[
          Text(
            S.of(context).market_investmentOpportunities,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary(context),
            ),
          ),
          SizedBox(height: 10.h),
          ...widget.entities.take(displayCount).map((entity) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: InvestmentItem(entity: entity),
              )),
          if (remainingCount > 0) ...[
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Center(
                child: Text(
                  _isExpanded
                      ? S.of(context).market_investmentOpportunitiesDesc2
                      : S
                          .of(context)
                          .market_investmentOpportunitiesDesc(remainingCount),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.quinary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ],
      ],
    );
  }
}
