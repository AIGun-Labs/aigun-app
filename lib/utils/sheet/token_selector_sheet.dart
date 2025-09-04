import 'package:flutter/material.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_aigun/widgets/token/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 选择交易币种
/// [tokens] 可用币种列表
/// [onSelect] 选择回调函数
/// 返回 Future<Token?> 以便调用者处理选择结果
Future<Token?> showTokenSelectorSheet(
    BuildContext context, List<Token> tokens) async {
  final result = await showModalBottomSheet<Token?>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.6,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            builder: (_, scrollController) {
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ListTile(
                      // contentPadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0.w, vertical: 0.0.w),
                      minVerticalPadding: 0.0.w,
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close,
                            size: 24.sp, color: AppColors.textPrimary(context)),
                      ),
                      title: Text(
                        "选择卖出的代币",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w700),
                      ),
                      // subtitle: Text(
                      //   "AIGun支持跨链交易",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       fontSize: 14.sp,
                      //       color: AppColors.textQuaternary(context)),
                      // ),
                      // trailing: IconButton(
                      //     onPressed: () {
                      //       Navigator.pop(context);
                      //     },
                      //     icon: Icon(
                      //       Icons.close,
                      //       size: 24.sp,
                      //       color: AppColors.textPrimary(context),
                      //     )),
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        // child: Icon(Icons.close,
                        //     size: 24.sp, color: AppColors.textPrimary(context)),
                        child: SizedBox.shrink(),
                      ),
                    ),
                  ),
                  Expanded(
                      child: TokenList(
                          tokens: tokens,
                          onTap: (token) {
                            Navigator.pop(context, token); // 关闭弹窗并返回选择的 token
                          }))
                ],
              );
            });
      });
  return result;
}
