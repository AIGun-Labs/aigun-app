import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRefreshHeader extends StatefulWidget {
  const CustomRefreshHeader({super.key});

  @override
  State<CustomRefreshHeader> createState() => _CustomRefreshHeaderState();
}

class _CustomRefreshHeaderState extends State<CustomRefreshHeader> {
  late BuildContext _savedContext;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _savedContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      height: 100.h,
      // refreshStyle: RefreshStyle.Behind,
      builder: (BuildContext context, RefreshStatus? mode) {
        // Widget body;

        // switch (mode) {
        //   case RefreshStatus.idle:
        //     // 初始状态，不显示动画
        //     body = _buildLoading();
        //     break;
        //   case RefreshStatus.canRefresh:
        //     // 可以刷新状态，显示准备刷新的动画
        //     body = Column(
        //       children: [
        //         _buildLoading(),
        //         _buildText(
        //           '没有噪音 只有先机',
        //         ),
        //       ],
        //     );
        //     break;
        //   case RefreshStatus.refreshing:
        //     // 正在刷新状态，显示加载动画
        //     body = Column(
        //       children: [
        //         _buildLoading(),
        //         _buildText(
        //           '正在刷新...',
        //         ),
        //       ],
        //     );
        //     break;
        //   case RefreshStatus.completed:
        //     // 完成状态
        //     body = Column(
        //       children: [
        //         _buildLoading(),
        //         _buildText(
        //           '刷新成功',
        //         ),
        //       ],
        //     );
        //     break;
        //   case RefreshStatus.failed:
        //     // 失败状态
        //     body = Column(
        //       children: [
        //         _buildLoading(),
        //         _buildText(
        //           '刷新失败',
        //         ),
        //       ],
        //     );
        //     break;
        //   default:
        //     body = const SizedBox.shrink();
        // }

        return SingleChildScrollView(
          child: Container(
            height: 100.h,
            // constraints: BoxConstraints(minHeight: 200.h),
            color: AppColors.card(_savedContext),
            child: Column(
              children: [
                _buildLoading(),
                _buildText(
                  S.of(context).app_title,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() {
    return DotLottieLoader.fromAsset("assets/lottie/loading.lottie",
        frameBuilder: (context, dotlottie) {
      if (dotlottie != null) {
        return Lottie.memory(dotlottie.animations.values.single,
            height: 60.h, width: 60.w);
      }
      return const SizedBox.shrink();
    });
  }

  Widget _buildText(String text) {
    return Text(text,
        style: TextStyle(
            fontSize: 12.sp, color: AppColors.textQuaternary(context)));
  }
}
