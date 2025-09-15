// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubits/search_token/search_token_cubit.dart';
import '../../../cubits/search_token/search_token_state.dart';

class InputSearchToken extends StatefulWidget {
  const InputSearchToken({super.key});

  @override
  State<InputSearchToken> createState() => _InputSearchTokenState();
}

class _InputSearchTokenState extends State<InputSearchToken> {
  late TextEditingController searchController;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _debouncedSearch(String value) {
    // 取消之前的定时器
    _debounceTimer?.cancel();

    // 设置新的定时器，500ms 后执行搜索
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        if (value.trim().isNotEmpty) {
          // 同时更新关键词和执行搜索，避免重复调用
          context.read<SearchTokenCubit>().updateSearchKeyword(value.trim());
          context.read<SearchTokenCubit>().searchTokenByKeyword(value.trim());
        } else {
          context.read<SearchTokenCubit>().clear();
        }
      }
    });
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
            // 使用防抖搜索，500ms 延迟，避免频繁API调用
            _debouncedSearch(value);
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
                  if (mounted) {
                    context
                        .read<SearchTokenCubit>()
                        .updateSearchKeyword(pastedText);

                    // 触发搜索逻辑
                    context
                        .read<SearchTokenCubit>()
                        .searchTokenByKeyword(pastedText);
                  }
                }
              },
              child: Text(S.of(context).paste,
                  style: const TextStyle(color: Colors.white, fontSize: 14)),
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
