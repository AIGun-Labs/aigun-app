import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/data/models/token_detail/security/security_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class RiskTabContent extends StatelessWidget {
  const RiskTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
        builder: (context, state) {
      return SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRiskSummary(context, state),
              _buildTaxSection(context, state),
              _buildContractAnalysisSection(context, state),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildRiskSummary(BuildContext context, TokenDetailState state) {
    final s = S.of(context);
    final isLoading = state.tokenDetailSecurityState
        .maybeWhen(loading: () => true, orElse: () => false);

    final riskAmount = context.read<TokenDetailCubit>().riskAmount;
    final warningAmount = context.read<TokenDetailCubit>().warningAmount;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        children: [
          /// TODO: 等后端接口返回数据
          Expanded(
            child: _buildRiskIndicator(
              context,
              'assets/images/icons/skull-outline.svg',
              riskAmount.toString(),
              s.riskItems,
              AppColors.secondary,
              isLoading,
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: _buildRiskIndicator(
              context,
              'assets/images/icons/shield-warning.svg',
              warningAmount.toString(),
              s.warningItems,
              AppColors.secondary,
              isLoading,
            ),
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
    bool isLoading,
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
            isLoading
                ? const TextSekeleton()
                : Text(
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

  Widget _buildTaxSection(BuildContext context, TokenDetailState state) {
    final s = S.of(context);
    final isLoading = state.tokenDetailSecurityState
        .maybeWhen(loading: () => true, orElse: () => false);
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.tradeTax,
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
                      s.buyTax,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF565656),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    isLoading
                        ? const TextSekeleton()
                        : Text(
                            !(state.securitys?.tradeTax?.buyTax
                                        .isNotEmptyAndZeroValue ??
                                    false)
                                ? '——'
                                : state.securitys?.tradeTax?.buyTax ?? '——',
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
                      s.sellTax,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF565656),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    isLoading
                        ? const TextSekeleton()
                        : Text(
                            !(state.securitys?.tradeTax?.sellTax
                                        .isNotEmptyAndZeroValue ??
                                    false)
                                ? '——'
                                : state.securitys?.tradeTax?.sellTax ?? '——',
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

  Widget _buildContractAnalysisSection(
      BuildContext context, TokenDetailState state) {
    final s = S.of(context);
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.contractAnalysis,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary(context),
            ),
          ),
          SizedBox(height: 20.h),
          const RiskContractAnalysisList(),
        ],
      ),
    );
  }
}

class RiskContractAnalysisList extends StatelessWidget {
  const RiskContractAnalysisList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
        builder: (context, state) {
      return state.tokenDetailSecurityState.when(
          initial: () => const SizedBox.shrink(),
          loading: () => _buildLoadingSkeleton(),
          success: (success) => _buildSuccess(success),
          error: (error) => _buildError(context, state));
    });
  }

  Widget _buildSuccess(TokenDetailSecurity securitys) {
    return Column(
      spacing: 18.h,
      children: [
        ..._getContractAnalysisItems(securitys),
      ],
    );
  }

  Widget _buildError(BuildContext context, TokenDetailState state) {
    final s = S.of(context);
    return Center(
      child: Text(s.noContractAnalysis),
    );
  }

  List<Widget> _getContractAnalysisItems(TokenDetailSecurity securitys) {
    return securitys.contractAnaly
        .map((e) => ContractAnalysisItem(
              title: e.title,
              description: e.description,
              isSafe: e.isSafe,
            ))
        .toList();
  }

  // 骨架屏组件
  Widget _buildLoadingSkeleton() {
    return Column(
      children:
          List.generate(3, (index) => const ContractAnalysisSkeletonItem())
              .toList(),
    );
  }
}

// 骨架屏占位符组件
class ContractAnalysisSkeletonItem extends StatelessWidget {
  const ContractAnalysisSkeletonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 图标骨架
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: AppColors.shimmerBaseColor(context),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: 10.w),
          // 文本内容骨架
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题骨架
                Shimmer.fromColors(
                    baseColor: AppColors.shimmerBaseColor(context),
                    highlightColor: AppColors.shimmerHighlightColor(context),
                    child: Container(
                      width: double.infinity,
                      height: 16.h,
                      decoration: BoxDecoration(
                        color: AppColors.shimmerBaseColor(context),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    )),
                SizedBox(height: 8.h),
                // 描述骨架 - 两行
                Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor(context),
                  highlightColor: AppColors.shimmerHighlightColor(context),
                  child: Container(
                    width: double.infinity,
                    height: 12.h,
                    margin: EdgeInsets.only(bottom: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.shimmerBaseColor(context),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor(context),
                  highlightColor: AppColors.shimmerHighlightColor(context),
                  child: Container(
                    width: 200.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: AppColors.shimmerBaseColor(context),
                      borderRadius: BorderRadius.circular(4.r),
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

class ContractAnalysisItem extends StatelessWidget {
  const ContractAnalysisItem(
      {super.key,
      required this.title,
      required this.description,
      required this.isSafe});

  final String title;
  final String description;
  final bool isSafe;

  @override
  Widget build(BuildContext context) {
    final prefixIconColor = isSafe ? AppColors.tipColor : AppColors.secondary;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 3.h),
            child: SvgPicture.asset(
              isSafe
                  ? 'assets/images/icons/safe-filled.svg'
                  : "assets/images/icons/danger-filled.svg",
              width: 20.w,
              height: 20.h,
              colorFilter: ColorFilter.mode(prefixIconColor, BlendMode.srcIn),
            )),
        SizedBox(width: 10.w),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary(context),
              ),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textTertiary(context),
                ),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ))
      ],
    );
  }
}

// 整个风险分析页面的骨架屏
class RiskTabContentSkeleton extends StatelessWidget {
  const RiskTabContentSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRiskSummarySkeleton(context),
            _buildTaxSectionSkeleton(context),
            _buildContractAnalysisSectionSkeleton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskSummarySkeleton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        children: [
          Expanded(child: _buildRiskIndicatorSkeleton(context)),
          SizedBox(width: 20.w),
          Expanded(child: _buildRiskIndicatorSkeleton(context)),
        ],
      ),
    );
  }

  Widget _buildRiskIndicatorSkeleton(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.textQuaternary(context),
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppColors.textQuaternary(context),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 4.h),
            Container(
              width: 40.w,
              height: 12.h,
              decoration: BoxDecoration(
                color: AppColors.textQuaternary(context),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTaxSectionSkeleton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: AppColors.textQuaternary(context),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 28.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: AppColors.textQuaternary(context),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: 50.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: AppColors.textQuaternary(context),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: AppColors.textQuaternary(context),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: 50.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: AppColors.textQuaternary(context),
                        borderRadius: BorderRadius.circular(4.r),
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

  Widget _buildContractAnalysisSectionSkeleton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: AppColors.textQuaternary(context),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 20.h),
          // 合约分析项骨架屏
          Column(
            children: List.generate(
                3, (index) => const ContractAnalysisSkeletonItem()).toList(),
          ),
        ],
      ),
    );
  }
}

class TextSekeleton extends StatelessWidget {
  const TextSekeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor(context),
      highlightColor: AppColors.shimmerHighlightColor(context),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.shimmerBaseColor(context),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          "-----",
          style: TextStyle(
              fontSize: 12.sp, color: AppColors.textQuaternary(context)),
        ),
      ),
    );
  }
}
