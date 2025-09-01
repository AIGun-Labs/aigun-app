import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/input_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupListItem extends StatelessWidget {
  final String title;
  final bool isDefault;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const GroupListItem({
    super.key,
    required this.title,
    this.isDefault = false,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(title),
      background: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16.w),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) => onDelete?.call(),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(
            color: InputTheme.getBorderColor(context),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 0,
          ),
          // 移除垂直padding
          minVerticalPadding: 0,
          // 让内容更紧凑
          visualDensity: VisualDensity.compact,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              height: 1,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onEdit,
                child: Icon(
                  Icons.edit_outlined,
                  size: 20.w,
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withValues(alpha: 0.55),
                ),
              ),
              SizedBox(width: 20.w),
              // 移除拖动图标，在CustomDragHandle中处理
            ],
          ),
        ),
      ),
    );
  }
}
