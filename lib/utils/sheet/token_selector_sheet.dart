import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/themes.dart';
import '../../widgets/loading_indicator/search_token.dart';
import '../../widgets/token/index.dart';
import '../../widgets/token/models/token.dart';
import '../toast/trade_status_toast.dart';

Future<Token?> showTokenSelectorSheet(
  BuildContext context,
  List<Token> tokens, {
  required String title,
  required bool isSearch,
  String? subTitle,
  Widget? suffix,
  Widget? leading,
  bool isShowRight = true,
}) async {
  final result = await showModalBottomSheet<Token?>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: AppColors.background(context),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 18.w,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 32.w,
                        child:
                            leading ??
                            GestureDetector(
                              onTap: () {
                                TradeStatusToastUtils.dismissToast();
                                Navigator.pop(context);

                                // final tradeCubit = context.read<TradeCubit>();
                              },
                              child: Icon(
                                Icons.close,
                                size: 24.sp,
                                color: AppColors.textPrimary(context),
                              ),
                            ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            if (subTitle?.trim().isNotEmpty ?? false)
                              Text(
                                subTitle?.trim() ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.textSecondary(context),
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 32.w,
                        child:
                            suffix ??
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
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const InputSearchToken(),
                    )
                  : const SizedBox.shrink(),

              Expanded(child: _buildTokenList(context, tokens, isShowRight)),
            ],
          ),
        ),
      );
    },
  );
  return result;
}

Widget _buildTokenList(
  BuildContext context,
  List<Token> tokens,
  bool isShowRight,
) {
  return TokenList(
    tokens: tokens,
    isShowRight: isShowRight,
    onTap: (token) {
      Navigator.pop(context, token);
    },
  );
}
