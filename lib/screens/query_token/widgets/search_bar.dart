import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/query_token/query_token.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/debounce.dart';
import 'package:flutter_aigun/utils/debouncer.dart';
import 'package:flutter_aigun/utils/logger.dart';
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
    final isEmpty = _searchController.text.toString().trim().isEmpty;

    setState(() {
      isHasValue = !isEmpty;
    });

    if (!isEmpty) {
      debouncer.run(() {
        context
            .read<QueryTokenCubit>()
            .queryToken(_searchController.text.toString().trim());
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void handleSuffixOnPressed() {
    isHasValue
        ? _searchController.clear()
        : ClipboardUtils.paste().then((value) {
            _searchController.text = value;
          });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
        ));
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
