import 'package:flutter/material.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubits/search_token/search_token_cubit.dart';
import '../../../cubits/search_token/search_token_state.dart';

class InputSearchToken extends StatefulWidget {
  InputSearchToken({Key? key}) : super(key: key);

  @override
  _InputSearchTokenState createState() => _InputSearchTokenState();
}

class _InputSearchTokenState extends State<InputSearchToken> {
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchTokenCubit, SearchTokenState>(
        builder: (context, state) {
      return SizedBox(
        height: 46.h,
        child: TextField(
          controller: searchController,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              // 触发搜索逻辑
              context
                  .read<SearchTokenCubit>()
                  .searchTokenByKeyword(value.trim());
            }
          },
          onChanged: (value) {
            searchController.text = value;
            // 实时搜索 - 可选，根据需求添加
            if (value.trim().isNotEmpty) {
              context
                  .read<SearchTokenCubit>()
                  .updateSearchKeyword(value.trim());
            }
          },
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
            suffixIcon: GestureDetector(
              onTap: () async {
                final pastedText = await ClipboardUtils.paste();
                if (pastedText.isNotEmpty) {
                  searchController.text = pastedText;

                  context
                      .read<SearchTokenCubit>()
                      .updateSearchKeyword(pastedText);

                  // 触发搜索逻辑
                  context
                      .read<SearchTokenCubit>()
                      .searchTokenByKeyword(pastedText);
                }
              },
              child: Container(
                margin: EdgeInsets.all(6.w),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
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
                    Text("粘贴",
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
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
    });
  }
}
