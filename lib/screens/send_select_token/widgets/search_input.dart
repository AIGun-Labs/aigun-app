import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/send_select_token/cubit/send_select_token_cubit.dart';
import 'package:flutter_aigun/widgets/input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      isPassword: false,
      hintText: S.of(context).tokens_tokenName,
      fontSize: 16.sp,
      controller: TextEditingController(),
      height: 50.h,
      fillColor: const Color.fromRGBO(209, 209, 209, 0.25),
      borderRadius: BorderRadius.circular(20),
      onChanged: (value) {
        context.read<SendSelectTokenCubit>().updateKeyword(value);
      },
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SvgPicture.asset(
          'assets/images/icons/icons8-search.svg',
          width: 20.w,
          height: 20.w,
          colorFilter: ColorFilter.mode(
            Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
            BlendMode.srcIn,
          ),
        ),
      ),
      borderSide: BorderSide.none,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    );
  }
}
