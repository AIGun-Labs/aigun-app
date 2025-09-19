import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFDDE3E1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          _buildTab(context, '行情', 0),
          _buildTab(context, 'AI', 1, showBadge: true, badgeText: '3', badgeColor: const Color(0xFF1099FB)),
          _buildTab(context, '风险', 2, showBadge: true, badgeText: '2', badgeColor: const Color(0xFFFE6256)),
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
  }) {
    final isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
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
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(height: 8.h),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2.h,
                width: 30.w,
                color: isSelected ? AppColors.textPrimary(context) : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}