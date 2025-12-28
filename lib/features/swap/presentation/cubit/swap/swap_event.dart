import 'package:freezed_annotation/freezed_annotation.dart';

part 'swap_event.freezed.dart';

@freezed
sealed class SwapEvent with _$SwapEvent {
  const factory SwapEvent.showSuccess({
    required String message,
    required String txHash,
    required String symbol,
    required String amount,
    String? txUrl,
  }) = SwapEventShowSuccess;
  const factory SwapEvent.showError(String message, int? code) =
      SwapEventShowError;
  const factory SwapEvent.showLoading() = SwapEventShowLoading;
  const factory SwapEvent.dismissLoading() = SwapEventDismissLoading;
  const factory SwapEvent.showParamsInvalid() = SwapEventShowParamsInvalid;
  const factory SwapEvent.navigateToReceive({
    required String avatar,
    required String title,
    required String symbol,
    required String address,
  }) = SwapEventNavigateToReceive;
  const factory SwapEvent.showSolMinimumWarning() =
      SwapEventShowSolMinimumWarning;
}
