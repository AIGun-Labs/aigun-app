import 'package:flutter/material.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/widgets/search.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_aigun/widgets/token/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

/// 选择交易币种
/// [tokens] 可用币种列表
/// [onSelect] 选择回调函数
/// 返回 Future<Token?> 以便调用者处理选择结果
Future<Token?> showTokenSelectorSheet(
    BuildContext context, List<Token> tokens) async {
  final TextEditingController controller = TextEditingController();

  final result = await showModalBottomSheet<Token?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background(context),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: _buildSearchInput(context),
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

Widget _buildSearchInput(BuildContext context) {
  final TextEditingController searchController = TextEditingController();
  return SizedBox(
    height: 46.h,
    child: TextField(
      controller: searchController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.card(context),
        contentPadding: EdgeInsets.zero, // 去掉内边距 才能让文本居中
        hintText: "搜索名称或合约地址",
        hintStyle: TextStyle(color: AppColors.textSecondary(context)),
        // prefixIcon: const Icon(Icons.search_sharp),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Icon(Icons.search,
              size: 25.w, color: AppColors.textSecondary(context)),
        ),
        suffixIcon: Container(
          margin: EdgeInsets.all(6.w),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.quaternary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.copy_all_outlined,
                color: Colors.white,
              ),
              Text("Paste",
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15))),
      ),
    ),
  );
}
