import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../themes/themes.dart';

class SearchInput extends StatefulWidget {
  const SearchInput(
      {super.key,
      required this.controller,
      this.borderRadius = const BorderRadius.all(Radius.circular(20)),
      this.hintText = "Place search keyword",
      this.prefixIcon,
      this.hintColor,
      this.backgroundColor,
      this.suffixIcon,
      this.height = 46.0,
      this.textColor});

  final TextEditingController controller;
  final BorderRadius borderRadius;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? hintColor;
  final Color? textColor;
  final Color? backgroundColor;
  final double height;

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextField(
        controller: widget.controller,
        style: TextStyle(
            color: widget.textColor ?? AppColors.textPrimary(context)),
        decoration: InputDecoration(
          filled: widget.backgroundColor != null,
          fillColor: widget.backgroundColor ?? Colors.white,
          contentPadding: EdgeInsets.zero, // 去掉内边距 才能让文本居中
          hintText: widget.hintText ?? "Search name or CA",
          hintStyle: TextStyle(color: widget.hintColor ?? Colors.grey),
          // prefixIcon: const Icon(Icons.search_sharp),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: widget.prefixIcon ??
                SvgPicture.asset(
                  "assets/images/icons/lightning-search.svg",
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    AppColors.textSecondary(context),
                    BlendMode.srcIn,
                  ),
                ),
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.all(6.0),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red[500]!.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(14 / 2),
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
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.textTertiary(context), width: 1),
              borderRadius: widget.borderRadius),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.textTertiary(context), width: 1),
              borderRadius: widget.borderRadius),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.textTertiary(context), width: 1),
              borderRadius: widget.borderRadius),
        ),
      ),
    );
  }
}
