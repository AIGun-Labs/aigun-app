import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RiskTabContent extends StatelessWidget {
  const RiskTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRiskSummary(context),
          const Divider(height: 1, color: Color(0xFFDDE3E1)),
          _buildTaxSection(context),
          const Divider(height: 1, color: Color(0xFFDDE3E1)),
          _buildContractAnalysisSection(context),
        ],
      ),
    );
  }

  Widget _buildRiskSummary(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        children: [
          _buildRiskIndicator(
            context,
            'assets/images/icons/skull-crossbones.svg',
            '8',
            '风险项',
            const Color(0xFFFE6256),
          ),
          SizedBox(width: 115.w),
          _buildRiskIndicator(
            context,
            'assets/images/icons/shield-exclamation.svg',
            '2',
            '注意项',
            const Color(0xFFFE6256),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskIndicator(
    BuildContext context,
    String iconPath,
    String value,
    String label,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(3.r),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            iconPath,
            width: 20.w,
            height: 20.h,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary(context),
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF565656),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTaxSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '交易税',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary(context),
            ),
          ),
          SizedBox(height: 28.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '买入税',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF565656),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '——',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF565656),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '卖出税',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF565656),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '——',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF565656),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContractAnalysisSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '合约分析',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary(context),
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            width: double.infinity,
            height: 484.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: const DecorationImage(
                image: AssetImage('assets/images/contract-analysis-placeholder.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Container(
                    width: 26.w,
                    height: 26.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFF000),
                    ),
                    child: Icon(
                      Icons.star,
                      size: 20.w,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}