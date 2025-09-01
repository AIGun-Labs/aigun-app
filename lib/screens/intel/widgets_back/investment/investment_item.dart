import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/intel_back/intel.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/intel/widgets_back/trade_modal.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvestmentItem extends StatelessWidget {
  final IntelEntity entity;

  const InvestmentItem({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.pageBg,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.pageBg,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: CachedImage(
                  imageUrl: 'assets/images/token.webp',
                  width: 20.w,
                  height: 20.w,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entity.symbol ?? '',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    entity.address != null && entity.address != ''
                        ? entity.address!
                        : '0x1234567890abcdef',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // TODO: 待添加数据，市值，风险，推荐到现在涨幅
            children: [
              Text(
                "${S.of(context).market_marketCap}: 1M",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                "${S.of(context).market_risk}: 高",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.red,
                ),
              ),
              Text(
                "推荐到现在涨幅45%",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          CustomButton(
            width: double.infinity,
            height: 30.h,
            fontSize: 15.sp,
            backgroundColor: AppColors.black,
            textColor: AppColors.white,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => TradeModal(
                  tokenSymbol: entity.symbol ?? '',
                  reserveSymbol: entity.network ?? '',
                  balance: '88888',
                  reserveBalance: '20',
                ),
              );
            },
            text: S.of(context).common_buy,
          ),
        ],
      ),
    );
  }
}
