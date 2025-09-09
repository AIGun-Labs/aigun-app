import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/search_token/search_token_state.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/loading_indicator/index.dart';
import 'package:flutter_aigun/widgets/loading_indicator/search_token.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_aigun/widgets/token/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 选择交易币种
/// [tokens] 可用币种列表
/// [onSelect] 选择回调函数
/// 返回 Future<Token?> 以便调用者处理选择结果
Future<Token?> showTokenSelectorSheet(BuildContext context, List<Token> tokens,
    {required String title,
    required bool isSearch,
    String? subTitle,
    Widget? suffix,
    Widget? leading,
    bool isShowRight = true}) async {
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
              return BlocBuilder<SearchTokenCubit, SearchTokenState>(
                  builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ListTile(
                        // contentPadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0.w, vertical: 0.0.w),
                        minVerticalPadding: 0.0.w,
                        leading: leading ??
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                // 关闭弹窗后清空搜索结果
                                context.read<SearchTokenCubit>().clear();
                              },
                              child: Icon(Icons.close,
                                  size: 24.sp,
                                  color: AppColors.textPrimary(context)),
                            ),
                        title: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          subTitle ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary(context)),
                        ),

                        trailing: suffix ??
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              // child: Icon(Icons.close,
                              //     size: 24.sp, color: AppColors.textPrimary(context)),
                              child: SizedBox.shrink(),
                            ),
                      ),
                    ),
                    isSearch
                        // 搜索输入框
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: InputSearchToken(),
                          )
                        : const SizedBox.shrink(),
                    // 显示token列表
                    Expanded(
                        child: _buildTokenList(context, tokens, isShowRight))
                  ],
                );
              });
            });
      });
  return result;
}

Widget _buildTokenList(
    BuildContext context, List<Token> tokens, bool isShowRight) {
  final searchState = context.watch<SearchTokenCubit>().state;

  // 如果正在搜索，显示加载中
  if (searchState.status == SearchTokenStatus.loading) {
    return const LoadingIndicator();
  }

  // 如果有搜索结果且搜索成功，显示搜索结果
  if (searchState.matchedTokens.isNotEmpty &&
      searchState.status == SearchTokenStatus.success) {
    return TokenList(
      tokens: searchState.matchedTokens,
      isShowRight: isShowRight,
      onTap: (token) {
        Navigator.pop(context, token);
      },
    );
  }

  // 否则显示原始tokens列表
  return TokenList(
    tokens: tokens,
    isShowRight: isShowRight,
    onTap: (token) {
      Navigator.pop(context, token);
    },
  );
}
