import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectNetworkBottomSheet extends StatelessWidget {
  const SelectNetworkBottomSheet({super.key, required this.onSelect});

  final Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return _buildBottomSheet(context);
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          _buildHandle(),
          SizedBox(height: 20.h),
          _buildTitle(context),
          SizedBox(height: 15.h),
          _buildNetworkList(context, onSelect),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        width: 40.w,
        height: 5.h,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(3.r),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Center(
      child: Text(
        S.of(context).wallet_selectNetwork,
        style: TextStyle(fontSize: 18.sp),
      ),
    );
  }

  Widget _buildNetworkList(BuildContext context, Function(String) onSelect) {
    return BlocBuilder<ChainCubit, ChainState>(
      builder: (context, state) {
        return Flexible(
          // child: ListView.builder(
          //       itemCount: state.chains.length,
          //   itemBuilder: (context, index) {
          //     return GestureDetector(
          //       onTap: () {
          //         // 处理网络选择逻辑
          //         Navigator.of(context).pop();
          //         onSelect(state.chains[index].chainId);
          //       },
          //       child: Padding(
          //         padding: EdgeInsets.only(bottom: 25.h),
          //         child: Row(
          //           children: [
          //             // CachedImage(
          //             //   imageUrl: state.chains[index].logo,
          //             //   width: 45.w,
          //             //   height: 45.w,
          //             // ),
          //             SizedBox(width: 12.w),
          //             Text(
          //               state.chains[index].chainName,
          //               style: TextStyle(fontSize: 16.sp),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
          child: const SizedBox.shrink(),
        );
      },
    );
  }
}

void showSelectNetworkBottomSheet(
    BuildContext context, Function(String) onSelect) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.90,
        child: SelectNetworkBottomSheet(
          onSelect: onSelect,
        ),
      );
    },
  );
}
