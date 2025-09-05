import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/add_token/cubit/add_token_cubit.dart';
import 'package:flutter_aigun/screens/add_token/cubit/add_token_state.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/bottom_button.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'widgets/contract_input.dart';
import 'widgets/network_selector.dart';

class AddTokenScreen extends StatelessWidget {
  const AddTokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTokenCubit(),
      child: BlocListener<AddTokenCubit, AddTokenState>(
        listener: (context, state) {
          if (state.isError) {
            return showErrorButtonSheet(context);
          }

          if (state.isSuccess) {
            return showSuccessButtonSheet(context);
          }
        },
        child: Scaffold(
          appBar:
              CustomAppBar(title: S.of(context).tokens_addToken.substring(1)),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NetworkSelector(),
                SizedBox(height: 21.h),
                const ContractInput(),
                SizedBox(height: 10.h),
                BlocBuilder<AddTokenCubit, AddTokenState>(
                  builder: (context, state) {
                    if (state.addressError) {
                      return Text(
                        S.of(context).validation_addressInvalid,
                        style: TextStyle(fontSize: 16.sp, color: Colors.red),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomButton(
            child: BlocBuilder<AddTokenCubit, AddTokenState>(
              builder: (context, state) {
                return CustomButton(
                  height: 50.h,
                  fontSize: 16.sp,
                  text: S.of(context).common_confirm,
                  backgroundColor: AppColors.background(context),
                  textColor: AppColors.textPrimary(context),
                  onPressed: state.addressError ||
                          state.chainError ||
                          state.tokenAddress.isEmpty
                      ? null
                      : () {
                          showSimpleToast('Conning soon...');
                          // context.read<AddTokenCubit>().addToken();
                        },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void showSuccessButtonSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (BuildContext context) {
        return BottomButton(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5.h),
              Center(
                child: Text(
                  S.of(context).tokens_addTokenNow,
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
              SizedBox(height: 51.h),
              Text(
                "HELLO",
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(height: 5.h),
              Text(
                "Hello Doge",
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 51.h),
              Row(
                children: [
                  Flexible(
                    child: CustomButton(
                      onPressed: () => context.pop(),
                      backgroundColor: Color(0xffffffff),
                      textColor: Colors.black,
                      isBottomButton: true,
                      borderSide: BorderSide(color: Color(0xFFB2B2B2)),
                      text: S.of(context).common_cancel,
                      fontSize: 16.sp,
                      height: 50.h,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Flexible(
                    child: CustomButton(
                      onPressed: () => {
                        context.go(
                          Routes.home,
                          extra: NavIndex.wallet,
                        ),
                        showAddTokenSuccessToast(context)
                      },
                      backgroundColor: Color(0xff000000),
                      textColor: Colors.white,
                      text: S.of(context).common_ok,
                      fontSize: 16.sp,
                      isBottomButton: true,
                      height: 50.h,
                      child: Text(
                        S.of(context).common_ok,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void showErrorButtonSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return BottomButton(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5.h),
              Image.asset(
                'assets/images/question.png', // 确保图片路径正确
                width: 77.w,
                height: 77.h,
              ),
              SizedBox(height: 20.h),
              Text(
                S.of(context).tokens_contractAddressError,
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onPressed: () => context.pop(),
                backgroundColor: Color(0xff000000),
                textColor: Colors.white,
                text: S.of(context).common_ok,
                fontSize: 16.sp,
                height: 50.h,
                child: Text(
                  S.of(context).common_ok,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
