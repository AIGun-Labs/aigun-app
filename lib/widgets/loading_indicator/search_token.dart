// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/query_token/query_token_cubit.dart';
import '../../cubits/query_token/query_token_state.dart';
import '../../l10n/l10n.dart';
import '../../themes/colors.dart';
import '../../utils/clipboard.dart';

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
    searchController.addListener(_onTextChanged);
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
          // context.read<QueryTokenCubit>().updateKeyword(value.trim());
          context.read<QueryTokenCubit>().queryTokens(value.trim());
        } else if (value.trim().isEmpty) {
          context.read<QueryTokenCubit>().reset();
        }
      }
    });
  }

  void _onTextChanged() {
    setState(() {
      _debouncedSearch(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueryTokenCubit, QueryTokenState>(
        builder: (context, state) {
      return TextField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          if (value.trim().isNotEmpty) {
            context.read<QueryTokenCubit>().queryTokens(value.trim());
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.card(context),
          contentPadding: EdgeInsets.zero, // 去掉内边距 才能让文本居中
          hintText: S.of(context).searchToken,
          hintStyle: TextStyle(
              color: AppColors.textSecondary(context), fontSize: 16.sp),
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
                context.read<QueryTokenCubit>().queryTokens(pastedText);
              }
            },
            child: GestureDetector(
              onTap: () async {
                final pastedText = await ClipboardUtils.paste();
                if (pastedText.isNotEmpty) {
                  searchController.text = pastedText;
                }
              },
              child: Container(
                margin: EdgeInsets.all(6.w),
                padding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(S.of(context).paste,
                        style: TextStyle(
                            color: AppColors.quaternary, fontSize: 12.sp)),
                  ],
                ),
              ),
            ),
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
      );
    });
  }
}
