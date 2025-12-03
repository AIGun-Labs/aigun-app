import 'package:freezed_annotation/freezed_annotation.dart';

part 'swap_event.freezed.dart';

/// SwapEvent 用于 Cubit 向 UI 层发送一次性事件
/// UI 层通过 BlocListener 监听并处理这些事件
@freezed
sealed class SwapEvent with _$SwapEvent {
  /// 显示交易成功 Toast
  const factory SwapEvent.showSuccess({
    required String message,
    required String txHash,
    required String symbol,
    required String amount,
    String? txUrl,
  }) = SwapEventShowSuccess;

  /// 显示错误 Toast
  const factory SwapEvent.showError(String message) = SwapEventShowError;

  /// 显示加载中 Toast
  const factory SwapEvent.showLoading() = SwapEventShowLoading;

  /// 关闭加载中 Toast
  const factory SwapEvent.dismissLoading() = SwapEventDismissLoading;

  /// 显示参数无效 Toast
  const factory SwapEvent.showParamsInvalid() = SwapEventShowParamsInvalid;

  /// 导航到接收地址页面
  const factory SwapEvent.navigateToReceive({
    required String avatar,
    required String title,
    required String symbol,
    required String address,
  }) = SwapEventNavigateToReceive;
}
