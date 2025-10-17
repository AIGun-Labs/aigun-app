import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/query_token/query_token.dart';
import 'package:flutter_aigun/cubits/query_token/query_token_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/debouncer.dart';
import 'package:flutter_aigun/widgets/search_bar/widgets/top_search_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SearchInternalSearchBar extends StatefulWidget {
  const SearchInternalSearchBar({
    super.key,
    this.openDrawer,
    this.initialText,
  });

  final VoidCallback? openDrawer;
  final String? initialText;

  @override
  State<SearchInternalSearchBar> createState() =>
      SearchInternalSearchBarState();
}

class SearchInternalSearchBarState extends State<SearchInternalSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  bool isHasValue = false;

  final Debouncer debouncer =
      Debouncer(delay: const Duration(milliseconds: 300));

  @override
  void initState() {
    super.initState();
    // if initial text not equal empty
    if (widget.initialText != null && widget.initialText!.isNotEmpty) {
      // set search value equal initial text
      _searchController.text = widget.initialText!;
      isHasValue = true;
    }

    _searchController.addListener(handleTextChange);
  }

  void handleTextChange() {
    final keyword = _searchController.text.toString();
    final queryTokenCubit = context.read<QueryTokenCubit>();

    final isEmpty = keyword.isEmpty;

    setState(() {
      isHasValue = !isEmpty;
    });

    debouncer.run(() {
      queryTokenCubit.queryTokens(keyword);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void handleSuffixOnPressed() {
    if (isHasValue) {
      _searchController.clear();
      context.read<QueryTokenCubit>().reset();
    } else {
      ClipboardUtils.paste().then((value) {
        _searchController.text = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QueryTokenCubit, QueryTokenState>(
      listenWhen: (previous, current) => previous.keyword != current.keyword,
      listener: (context, state) {
        // 同步 cubit state 的 keyword 到 searchController
        if (state.keyword != null && state.keyword != _searchController.text) {
          _searchController.text = state.keyword!;
        } else if (state.keyword == null && _searchController.text.isNotEmpty) {
          _searchController.clear();
        }
      },
      child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              Expanded(
                  child: TopSearchBar(
                prefixIconColor: Colors.black,
                borderColor: AppColors.senary,
                backgroundColor: AppColors.senary,
                searchController: _searchController,
                openDrawer: widget.openDrawer,
                prefix: const SizedBox.shrink(),
                suffixOnPressed: handleSuffixOnPressed,
                hintStyle: TextStyle(color: AppColors.textTertiary(context)),
                suffix: SearchSuffix(
                  isHasValue: isHasValue,
                ),
              )),
              SizedBox(
                width: 15.w,
              ),
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Text(
                  S.of(context).common_cancel,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class SearchSuffix extends StatelessWidget {
  const SearchSuffix({super.key, this.isHasValue = false});

  final bool isHasValue;

  @override
  Widget build(BuildContext context) {
    return isHasValue
        ? Transform.translate(
            offset: Offset(10.w, 0),
            child: ClipOval(
              child: Container(
                height: 20.h,
                width: 20.w,
                decoration:
                    BoxDecoration(color: AppColors.textTertiary(context)),
                child: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Text(
            S.of(context).paste,
            style: TextStyle(color: AppColors.quaternary, fontSize: 12.sp),
          );
  }
}
