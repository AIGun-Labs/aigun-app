import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/colors.dart';

class GlobalErrorWidget extends StatelessWidget {
  const GlobalErrorWidget({
    super.key,
    this.title,
    this.message,
    this.onRetry,
    this.icon,
    this.showRetryButton = true,
    this.iconSize,
    this.spacing,
    this.retryButtonText,
    this.padding,
  });

  final String? title;
  final String? message;
  final VoidCallback? onRetry;
  final Widget? icon;
  final bool showRetryButton;
  final double? iconSize;
  final double? spacing;
  final String? retryButtonText;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error Icon
            _buildIcon(context),

            SizedBox(height: spacing ?? 24.h),

            // Error Title
            if (title != null && title!.isNotEmpty)
              Text(
                title!,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary(context),
                ),
                textAlign: TextAlign.center,
              ),

            if (title != null && message != null) SizedBox(height: 12.h),

            // Error Message
            if (message != null && message!.isNotEmpty)
              Text(
                message!,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary(context),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

            // Retry Button
            if (showRetryButton && onRetry != null) ...[
              SizedBox(height: spacing ?? 32.h),
              _buildRetryButton(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    if (icon != null) {
      return icon!;
    }

    // Default error icon
    return Container(
      width: iconSize ?? 80.w,
      height: iconSize ?? 80.h,
      decoration: BoxDecoration(
        color: AppColors.tertiary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.error_outline,
        size: (iconSize ?? 80.w) * 0.6,
        color: AppColors.tertiary,
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onRetry,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.refresh, size: 18.sp, color: Colors.white),
              SizedBox(width: 8.w),
              Text(
                retryButtonText ?? '',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Network Error Widget - Specific implementation for network errors
class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({super.key, required this.onRetry, this.message});

  final VoidCallback onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return GlobalErrorWidget(
      title: '',
      message: message ?? '',
      onRetry: onRetry,
      icon: Container(
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: AppColors.textTertiary(context).withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.wifi_off,
          size: 48.sp,
          color: AppColors.textTertiary(context),
        ),
      ),
    );
  }
}

// Empty Data Widget - For when there's no data to display
class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
    this.title,
    this.message,
    this.onRefresh,
    this.icon,
  });

  final String? title;
  final String? message;
  final VoidCallback? onRefresh;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GlobalErrorWidget(
      title: title ?? '',
      message: message ?? '',
      onRetry: onRefresh,
      showRetryButton: onRefresh != null,
      retryButtonText: '',
      icon:
          icon ??
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.textTertiary(context).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.inbox_outlined,
              size: 48.sp,
              color: AppColors.textTertiary(context),
            ),
          ),
    );
  }
}

// Loading Error Widget - For data loading failures
class LoadingErrorWidget extends StatelessWidget {
  const LoadingErrorWidget({super.key, required this.onRetry, this.error});

  final VoidCallback onRetry;
  final dynamic error;

  @override
  Widget build(BuildContext context) {
    String errorMessage = '';

    if (error != null) {
      if (error is String) {
        errorMessage = error;
      } else if (error.toString().contains('SocketException')) {
        errorMessage = '，';
      } else if (error.toString().contains('TimeoutException')) {
        errorMessage = '，';
      }
    }

    return GlobalErrorWidget(
      title: '',
      message: errorMessage,
      onRetry: onRetry,
      icon: Container(
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: AppColors.tertiary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.error_outline,
          size: 48.sp,
          color: AppColors.tertiary,
        ),
      ),
    );
  }
}

// Custom Error Widget Builder for specific scenarios
class CustomErrorWidgetBuilder {
  static Widget build({
    required BuildContext context,
    required CustomErrorType type,
    String? customTitle,
    String? customMessage,
    VoidCallback? onRetry,
    Widget? customIcon,
  }) {
    switch (type) {
      case CustomErrorType.network:
        return NetworkErrorWidget(
          onRetry: onRetry ?? () {},
          message: customMessage,
        );
      case CustomErrorType.empty:
        return EmptyDataWidget(
          title: customTitle,
          message: customMessage,
          onRefresh: onRetry,
          icon: customIcon,
        );
      case CustomErrorType.loading:
        return LoadingErrorWidget(
          onRetry: onRetry ?? () {},
          error: customMessage,
        );
      case CustomErrorType.general:
        return GlobalErrorWidget(
          title: customTitle ?? '',
          message: customMessage ?? '，',
          onRetry: onRetry,
          icon: customIcon,
        );
    }
  }
}

enum CustomErrorType { network, empty, loading, general }
