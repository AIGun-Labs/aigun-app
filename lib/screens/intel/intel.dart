import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/intel/widgets/header.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_list.dart';
import 'package:flutter_aigun/screens/intel/widgets/top_header.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class IntelScreen extends StatefulWidget {
  const IntelScreen({super.key});

  @override
  State<IntelScreen> createState() => _IntelScreenState();
}

class _IntelScreenState extends State<IntelScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = const [
    'AI',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // IntelHeader(),
            const LatestDiscoveriesSection(),
            Expanded(
              child: Container(
                color: AppColors.card(context),
                child: const Stack(
                  children: [
                    IntelList(),
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: IntelUnreadBar(),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IntelUnreadBar extends StatelessWidget {
  const IntelUnreadBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntelCubit, IntelState>(builder: (context, state) {
      if (state.unreadIds.isNotEmpty) {
        return Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Container(
              // height: 38.h,
              decoration: BoxDecoration(
                color: AppColors.quaternary,
                borderRadius: BorderRadius.circular(20.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_upward,
                    size: 18.sp,
                    color: AppColors.white,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    S.of(context).newIntel(state.unreadIds.length),
                    style: TextStyle(fontSize: 14.sp, color: AppColors.white),
                  )
                ],
              ),
            ));
      }
      return const SizedBox.shrink();
    });
  }
}
