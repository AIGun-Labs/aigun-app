import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSettingCard extends StatelessWidget {
  const CustomSettingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.background(context),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(color: AppColors.border(context), width: 1.r)),
      child: Padding(
        padding: EdgeInsetsGeometry.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CachedImage(
                    width: 50.w,
                    height: 50.h,
                    imageUrl: "assets/images/icons/custom-trade-setting.png"),
                Column(
                  children: [
                    Text(
                      "Custom Solana Trade",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary(context)),
                    ),
                    Text(
                      "Suitable for experienced veterans",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textSecondary(context)),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 16.h),
            LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = (constraints.maxWidth - 60) / 2; // 动态计算宽度
                return Wrap(
                  spacing: 60.0, // 水平间距
                  runSpacing: 28.0, // 垂直间距
                  children: [
                    SizedBox(
                      width: itemWidth,
                      child: _buildGridItem(
                        context,
                        "滑点",
                        _buildInput(context, "%"),
                      ),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: _buildGridItem(
                        context,
                        "防夹功能",
                        Switch(value: true, onChanged: (value) {}),
                      ),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: _buildGridItem(
                          context, "Gas 实时平均为 5", _buildInput(context, "")),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, Widget control) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // 关键：让Column根据内容自适应高度
      spacing: 6.h,
      children: [
        Text(
          title,
          style:
              TextStyle(fontSize: 16.sp, color: AppColors.textPrimary(context)),
        ),
        control,
      ],
    );
  }

  Widget _buildInput(BuildContext context, String? suffixText) {
    return TextField(
      decoration: _buildInputDecoration(context, suffixText),
    );
  }

  InputDecoration _buildInputDecoration(
      BuildContext context, String? suffixText) {
    return InputDecoration(
      hintText: "1.0",
      hintStyle:
          TextStyle(fontSize: 16.sp, color: AppColors.textQuinary(context)),
      // 后缀文本和样式
      suffixText: suffixText,
      suffixStyle:
          TextStyle(fontSize: 16, color: AppColors.textPrimary(context)),

      // 内容内边距，让输入框看起来更紧凑
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      // 边框样式
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),

      // 启用状态下的边框
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
      // 聚焦时（用户正在输入时）的边框
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide:
            BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
      ),
    );
  }
}
