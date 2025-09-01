import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/data/services/index.dart';
import 'package:flutter_aigun/screens/check_your_email/cubit/verification_state.dart';
import 'package:flutter_aigun/utils/storage/local/countdown_storage.dart';
import 'package:get_it/get_it.dart';

class VerificationCubit extends Cubit<VerificationState> {
  Timer? _timer;
  final CountdownStorage _countdownStorage = CountdownStorage();
  final UserApi _userApi = GetIt.instance<UserApi>();

  VerificationCubit(String email, String type)
      : super(const VerificationState()) {
    _initialize(email, type);
  }

  Future<void> _initialize(String email, String type) async {
    final adjustedCountdown = await _countdownStorage.loadCountdown(email);
    if (adjustedCountdown > 0) {
      emit(state.copyWith(countdown: adjustedCountdown));
      startCountdown(email);
    } else {
      sendCode(email, type);
      startCountdown(email);
    }
  }

  void startCountdown(String email) {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newCountdown = state.countdown - 1;
      if (newCountdown <= 0) {
        timer.cancel();
        _updateCountdown(0, email);
      } else {
        _updateCountdown(newCountdown, email);
      }
    });
  }

  void _updateCountdown(int countdown, String email) {
    emit(state.copyWith(
      countdown: countdown,
      isResendLoading: countdown > 0,
    ));
    _countdownStorage.saveCountdown(email, countdown);
  }

  Future<void> sendCode(String email, String type) async {
    if (state.isResendLoading || state.countdown > 0) return;

    emit(state.copyWith(
      countdown: 60,
      isResendLoading: true,
      errorCode: null,
    ));

    startCountdown(email);

    try {
      await _userApi.sendVerificationCode(
        email: email,
        type: type,
      );
    } catch (e) {
      if (e is ApiException) {
        emit(state.copyWith(
          errorCode: e.code.toString(),
          isResendLoading: false,
          countdown: 0,
        ));
      } else {
        emit(state.copyWith(
          isResendLoading: false,
          countdown: 0,
        ));
      }
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
