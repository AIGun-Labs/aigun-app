// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        if (value.trim().isNotEmpty) {
          // context.read<QueryTokenCubit>().updateKeyword(value.trim());
        } else if (value.trim().isEmpty) {}
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
    return SizedBox(
      height: 46.h,
      child: TextField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {},
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.card(context),
          contentPadding: EdgeInsets.zero,
          hintText: S.of(context).searchToken,
          hintStyle: TextStyle(
            color: AppColors.textSecondary(context),
            fontSize: 16.sp,
          ),
          // prefixIcon: const Icon(Icons.search_sharp),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Icon(
              Icons.search,
              size: 25.w,
              color: AppColors.textSecondary(context),
            ),
          ),

          suffixIcon: GestureDetector(
            onTap: () async {
              final pastedText = await ClipboardUtils.paste();
              if (pastedText.isNotEmpty) {
                searchController.text = pastedText;
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
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      S.of(context).paste,
                      style: TextStyle(
                        color: AppColors.quaternary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
      ),
    );
  }
}
