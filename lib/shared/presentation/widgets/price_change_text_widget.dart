import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors.dart';

class PriceChangeTextWidget extends StatelessWidget {
  final String priceChange;

  const PriceChangeTextWidget({super.key, required this.priceChange});

  double get priceChangePercent => double.tryParse(priceChange) ?? 0.0;

  String get formattedPriceChange {
    if (priceChange.isEmpty) return '0%';

    return '${priceChangePercent.toStringAsFixed(2)}%';
  }

  Color color(BuildContext context) {
    if (priceChangePercent == 0.0) return AppColors.textTertiary(context);

    if (priceChangePercent > 0) return AppColors.septenary;
    return AppColors.secondary;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedPriceChange,
      style: TextStyle(fontSize: 14.sp, color: color(context)),
    );
  }
}
