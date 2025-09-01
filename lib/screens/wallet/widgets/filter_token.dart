import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/input_theme.dart';
import 'package:flutter_aigun/widgets/input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterToken extends StatelessWidget {
  const FilterToken({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceCubit, BalanceState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 184.w,
              ),
              child: CustomInput(
                height: 34.w,
                hintText: S.of(context).ui_searchAndAdd,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                onChanged: (value) {
                  context.read<BalanceCubit>().updateSearchQuery(value);
                },
                isOutline: true,
                fontSize: 12.sp,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: SvgPicture.asset(
                      'assets/images/icons/icons8-search.svg',
                      colorFilter: ColorFilter.mode(
                        InputTheme.getPrefixIconTheme(context),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: () => context.read<BalanceCubit>().toggleHideSmallAssets(),
              child: Row(
                children: [
                  SizedBox(
                    width: 19.w,
                    height: 19.w,
                    child: Checkbox(
                      value: state.hideSmallAssets,
                      onChanged: (bool? value) {
                        if (value != null) {
                          context
                              .read<BalanceCubit>()
                              .setHideSmallAssets(value);
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    S.of(context).wallet_hideSmallAssets,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
