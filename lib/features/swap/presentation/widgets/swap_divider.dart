import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../themes/themes.dart';
import '../cubit/swap/swap_cubit.dart';

/// 交换分隔符组件
///
/// 显示在来源代币和目标代币之间，包含交换按钮
class SwapTokenDivider extends StatelessWidget {
  const SwapTokenDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: Divider(height: 1, color: AppColors.border(context)),
        ),
        Center(
          child: _SwapButton(
            onPressed: () => context.read<SwapCubit>().swapToken(),
          ),
        ),
      ],
    );
  }
}

/// 交换按钮
class _SwapButton extends StatelessWidget {
  const _SwapButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.w,
      height: 35.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.buttonGradientStart,
            AppColors.buttonGradientEnd,
          ],
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          'assets/images/icons/swap-outline.svg',
          height: 16.w,
          width: 16.w,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
