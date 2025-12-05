import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../l10n/l10n.dart';
import '../themes/themes.dart';

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
      builder: (BuildContext context, RefreshStatus? mode) {
        return SingleChildScrollView(
          child: Container(
            height: 100.h,
            color: AppColors.card(_savedContext),
            child: Column(
              children: [
                const RefreshLoading(),
                RefreshText(
                  text: S.of(context).app_title,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RefreshLoading extends StatelessWidget {
  const RefreshLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return DotLottieLoader.fromAsset("assets/lottie/loading.lottie",
        frameBuilder: (context, dotlottie) {
      if (dotlottie != null) {
        return Lottie.memory(dotlottie.animations.values.single,
            height: 60.w, width: 60.w);
      }
      return const SizedBox.shrink();
    });
  }
}

class RefreshText extends StatelessWidget {
  const RefreshText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: 12.sp, color: AppColors.textQuaternary(context)));
  }
}
