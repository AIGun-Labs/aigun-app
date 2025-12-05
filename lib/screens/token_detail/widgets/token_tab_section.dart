import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors.dart';

class TokenTabSection extends StatefulWidget {
  const TokenTabSection({
    super.key,
    required this.onTabChanged,
    this.selectedIndex = 0,
  });

  final Function(int) onTabChanged;
  final int selectedIndex;

  @override
  State<TokenTabSection> createState() => _TokenTabSectionState();
}

class _TokenTabSectionState extends State<TokenTabSection> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(TokenTabSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      setState(() {
        _selectedIndex = widget.selectedIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFDDE3E1), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildTab(context, '', 0, leftPadding: 24.w),
          _buildTab(
            context,
            'AI',
            1,
            showBadge: true,
            badgeText: '3',
            badgeColor: const Color(0xFF1099FB),
            leftPadding: 31.w,
          ),
          _buildTab(
            context,
            '',
            2,
            showBadge: true,
            badgeText: '2',
            badgeColor: const Color(0xFFFE6256),
            leftPadding: 35.w,
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    String label,
    int index, {
    bool showBadge = false,
    String? badgeText,
    Color? badgeColor,
    double leftPadding = 0,
  }) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        if (_selectedIndex != index) {
          setState(() {
            _selectedIndex = index;
          });
          widget.onTabChanged(index);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        // padding: EdgeInsets.only(left: leftPadding),
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        height: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected
                  ? AppColors.textPrimary(context)
                  : Colors.transparent,
              width: 2.h,
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: showBadge ? 2.w : 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? AppColors.textPrimary(context)
                        : AppColors.textTertiary(context),
                  ),
                ),
                if (showBadge && badgeText != null) ...[
                  SizedBox(width: 4.w),
                  Text(
                    badgeText,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: badgeColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
