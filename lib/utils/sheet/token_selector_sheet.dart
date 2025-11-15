import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/index.dart';
import '../../cubits/query_token/query_token_state.dart';
import '../../themes/themes.dart';
import '../../widgets/loading_indicator/search_token.dart';
import '../../widgets/token/index.dart';
import '../../widgets/token/models/token.dart';
import '../toast/trade_status_toast.dart';

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
      useRootNavigator: true,
      backgroundColor: AppColors.background(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return BlocBuilder<SearchTokenCubit, SearchTokenState>(
            builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 18.w),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 32.w,
                            child: leading ??
                                GestureDetector(
                                  onTap: () {
                                    // 关闭弹窗后清空搜索结果
                                    context.read<SearchTokenCubit>().clear();
                                    TradeStatusToastUtils.dismissToast();
                                    Navigator.pop(context);
                                    // 执行 tradeCubit 操作
                                    // final tradeCubit = context.read<TradeCubit>();
                                  },
                                  child: Icon(Icons.close,
                                      size: 24.sp,
                                      color: AppColors.textPrimary(context)),
                                ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                                if (subTitle?.trim().isNotEmpty ?? false)
                                  Text(
                                    subTitle?.trim() ?? "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color:
                                            AppColors.textSecondary(context)),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 32.w,
                            child: suffix ??
                                GestureDetector(
                                  onTap: () {
                                    TradeStatusToastUtils.dismissToast();
                                    Navigator.pop(context);
                                  },
                                  child: const SizedBox.shrink(),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  isSearch
                      // 搜索输入框
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: const InputSearchToken(),
                        )
                      : const SizedBox.shrink(),
                  // 显示token列表
                  Expanded(child: _buildTokenList(context, tokens, isShowRight))
                ],
              ),
            ),
          );
        });
      });
  return result;
}

Widget _buildTokenList(
    BuildContext context, List<Token> tokens, bool isShowRight) {
  final queryTokenState = context.watch<QueryTokenCubit>().state;

  // 如果正在搜索，显示加载中
  if (queryTokenState.isLoading) {
    return const TokenListSkeleton();
  }

  // 如果有搜索结果且搜索成功，显示搜索结果
  if (queryTokenState.tokens.isNotEmpty &&
      queryTokenState.status == QueryTokenStatus.success) {
    return TokenList(
      tokens:
          queryTokenState.tokens.map((e) => Token.fromQueryToken(e)).toList(),
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
