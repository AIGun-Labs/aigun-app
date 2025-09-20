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
          _buildTaxSection(context),
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
            'assets/images/icons/skull-outline.svg',
            '8',
            '风险项',
            AppColors.secondary,
          ),
          SizedBox(width: 115.w),
          _buildRiskIndicator(
            context,
            'assets/images/icons/shield-warning.svg',
            '2',
            '注意项',
            AppColors.secondary,
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
            color: AppColors.card(context),
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
                color: AppColors.textSecondary(context),
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
          const ContractAnalysisItem(),
          SizedBox(height: 10.h),
          const ContractAnalysisItem(),
          SizedBox(height: 10.h),
          const ContractAnalysisItem(),
        ],
      ),
    );
  }
}

class ContractAnalysisItem extends StatelessWidget {
  const ContractAnalysisItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 3.h),
            child: SvgPicture.asset(
              'assets/images/icons/safe-filled.svg',
              width: 20.w,
              height: 20.h,
              colorFilter:
                  const ColorFilter.mode(AppColors.tipColor, BlendMode.srcIn),
            )),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '符合 SPL 代币标准',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary(context),
              ),
            ),
            Text(
              '此代币为官方程序发行，符合 SPL 标准',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textTertiary(context),
              ),
            ),
          ],
        )
      ],
    );
  }
}
