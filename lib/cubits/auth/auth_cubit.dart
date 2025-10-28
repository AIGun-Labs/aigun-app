import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/core/custom_exceptions.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/auth/auth_state.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/services/api/auth_api.dart';
import 'package:flutter_aigun/utils/storage/secure/token_storage_service.dart';
import 'package:flutter_aigun/utils/storage/secure/user_storage_service.dart';
import 'package:flutter_aigun/utils/validators/form_validator.dart';
import 'package:get_it/get_it.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthApi _authApi = GetIt.instance<AuthApi>();
  final TokenStorageService tokenStorage =
      GetIt.instance<TokenStorageService>();
  AuthCubit() : super(const AuthState(email: "", code: "", nickname: ""));

  final UserCubit userCubit = getIt<UserCubit>();

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void codeChanged(String code) {
    emit(state.copyWith(code: code));
  }

  void nicknameChanged(String nickname) {
    emit(state.copyWith(nickname: nickname));
  }

  void inviteCodeChanged(String inviteCode) {
    emit(state.copyWith(inviteCode: inviteCode));
  }

  void changeAgreementNotConfirmed(bool? value) {
    if (value == null) return;
    emit(state.copyWith(isAgreementNotConfirmed: value));

    if (value) {
      emit(state.copyWith(isAgreementNotConfirmedValid: true));
    }
  }

  // 初始化倒计时
  void initializeCountdown() {
    if (state.countdownStartTime == null) {
      emit(state.copyWith(countdownStartTime: DateTime.now()));
    }
  }

  // 清除事件
  void clearEvent() {
    emit(state.copyWith(event: null));
  }

  void updatePaymentPin(String paymentPin) {
    emit(state.copyWith(paymentPin: paymentPin));
  }

  void updateThanksMessageId(int messageId) {
    emit(state.copyWith(thanksMessageId: messageId));
  }

  Future<void> sendVerificationCode(
    BuildContext context,
  ) async {
    emit(state.copyWith(sendCodeState: const SendCodeStatus.initial()));
    if (state.sendCodeState.isSendingCode) return;

// 校验邮箱验证码
    if (!FormValidator.validateEmail(state.email).isValid) {
      emit(state.copyWith(
          sendCodeState:
              const SendCodeStatus.failure(SendCodeFailure.emailInvalid)));
      return;
    }

    try {
      await _authApi.sendVerificationCode(state.email);

      emit(state.copyWith(
        sendCodeState: const SendCodeStatus.success(),
        countdownStartTime: DateTime.now(), // 记录发送时间
      ));
      // callback(); // 发送验证码成功后，调用回调函数
    } on DioException catch (e, s) {
      if (e.error is BusinessException) {
        BusinessException be = e.error as BusinessException;

        _handleBusinessException(be.code, be.msg, e, s);
      } else {
        emit(state.copyWith(
            sendCodeState:
                const SendCodeStatus.failure(SendCodeFailure.unknown)));
      }
      await SentryService().reportError(e, s,
          tags: {"feature": "sendVerificationCode", "level": "2"},
          extra: {"email": state.email});
    } catch (e, s) {
      emit(state.copyWith(
          sendCodeState:
              const SendCodeStatus.failure(SendCodeFailure.unknown)));
      await SentryService().reportError(e, s,
          tags: {"feature": "sendVerificationCode", "level": "2"},
          extra: {"email": state.email});
    } finally {
      emit(state.copyWith(sendCodeState: const SendCodeStatus.initial()));
    }
  }

  Future<void> verifyCode() async {
    emit(state.copyWith(verifyCodeState: const VerifyCodeStatus.initial()));
    try {
      if (!FormValidator.validateVerificationCode(state.code).isValid) {
        emit(state.copyWith(
            verifyCodeState: const VerifyCodeStatus.failure(
                VerifyCodeFailure.verifyCodeInvalidFormat)));
        return;
      }

      await _authApi.verifyEmailCode(email: state.email, code: state.code);

      await Future.wait([
        userCubit.getUserInfo().catchError((e) {
          Logger.error("getUserInfo error: $e");
          return null;
        }),
        userCubit.getUserSubscriptions().catchError((e) {
          Logger.error("getUserSubscriptions error: $e");
          return null;
        }),
        getIt<IntelCubit>().connectWebSocket().catchError((e) {
          Logger.error("connectWebSocket error: $e");
          return null;
        })
      ]);

      emit(state.copyWith(verifyCodeState: const VerifyCodeStatus.success()));
    } on DioException catch (e, s) {
      // 业务状态码错误
      if (e.error is BusinessException) {
        BusinessException be = e.error as BusinessException;

        _handleBusinessException(be.code, be.msg, e, s);
      } else {
        emit(state.copyWith(
            verifyCodeState:
                const VerifyCodeStatus.failure(VerifyCodeFailure.unknown)));
      }
      await SentryService().reportError(e, s,
          tags: {"feature": "verifyCode", "level": '2'},
          extra: {"email": state.email, "code": state.code});
    } catch (e, s) {
      await SentryService().reportError(e, s,
          tags: {"feature": "login", "level": '2'},
          extra: {"email": state.email, "code": state.code});
      emit(state.copyWith(
          verifyCodeState:
              const VerifyCodeStatus.failure(VerifyCodeFailure.unknown)));
    } finally {
      emit(state.copyWith(verifyCodeState: const VerifyCodeStatus.initial()));
    }
  }

  Future<void> register() async {
    emit(state.copyWith(registerState: const RegisterStatus.initial()));
    if (!FormValidator.validateNickname(state.nickname).isValid) {
      emit(state.copyWith(
          registerState:
              const RegisterStatus.failure(RegisterFailure.nicknameInvalid)));
      return;
    }

    if (!state.isAgreementNotConfirmed) {
      emit(state.copyWith(
          registerState: const RegisterStatus.failure(
              RegisterFailure.agreementNotConfirmed)));
      return;
    }

    // validate invite code
    if (!FormValidator.validateInviteCode(state.inviteCode).isValid) {
      emit(state.copyWith(
          registerState:
              const RegisterStatus.failure(RegisterFailure.inviteCodeInvalid)));
      return;
    }

    try {
      await _authApi.register(
          state.email, state.code, state.nickname, state.inviteCode
          // , state.paymentPin
          );

      await userCubit.getUserInfo();
      // Registration successful and redirected to the homepage
      // 登录成功

      emit(state.copyWith(
        registerState: const RegisterStatus.success(),
      ));
    } on DioException catch (e, s) {
      if (e.error is BusinessException) {
        // Business Exception handling
        BusinessException be = e.error as BusinessException;

        _handleBusinessException(be.code, be.msg, e, s);
      } else {
        emit(state.copyWith(
            registerState:
                const RegisterStatus.failure(RegisterFailure.registerFail)));
      }
      await SentryService().reportError(e, s, tags: {
        "feature": "register",
        "level": '2'
      }, extra: {
        "email": state.email,
        "code": state.code,
        "nickname": state.nickname,
        "inviteCode": state.inviteCode
      });
    } catch (e, s) {
      emit(state.copyWith(
          registerState:
              const RegisterStatus.failure(RegisterFailure.unknown)));
      await SentryService().reportError(e, s, tags: {
        "feature": "login",
        "level": '2'
      }, extra: {
        "email": state.email,
        "code": state.code,
        "nickname": state.nickname,
        "inviteCode": state.inviteCode
      });
    } finally {
      emit(state.copyWith(registerState: const RegisterStatus.initial()));
    }
  }

  /// 处理业务异常，根据状态码执行不同操作
  Future<void> _handleBusinessException(
      int code, String message, dynamic e, dynamic s) async {
    switch (code) {
      case 200200: // 用户不存在
        emit(state.copyWith(
            verifyCodeState: const VerifyCodeStatus.failure(
                VerifyCodeFailure.userNotExist)));
        break;
      case 200201: // 用户已存在
        emit(state.copyWith(
            verifyCodeState:
                const VerifyCodeStatus.failure(VerifyCodeFailure.userExist)));
        // callback();
        break;
      case 200103: // 验证码错误
        emit(state.copyWith(
            verifyCodeState: const VerifyCodeStatus.failure(
                VerifyCodeFailure.verifyCodeFail)));
        break;
      case 200205:
        // 邀请人不存在
        emit(state.copyWith(
            registerState: const RegisterStatus.failure(
                RegisterFailure.inviteCodeInvalid)));
        break;
      case 200108:
        // 发送验证码过于频繁
        emit(state.copyWith(
            sendCodeState:
                const SendCodeStatus.failure(SendCodeFailure.sendCodeMany)));
        break;

      case 200110:
        emit(state.copyWith(
            sendCodeState:
                const SendCodeStatus.failure(SendCodeFailure.emailInvalid)));
        break;

      case 200102:
        emit(state.copyWith(
            verifyCodeState: const VerifyCodeStatus.failure(
                VerifyCodeFailure.verifyCodeExpired)));
        break;
      case 200116:
        emit(state.copyWith(
            registerState: const RegisterStatus.failure(
                RegisterFailure.createWalletFail)));
      case 200117:
        emit(state.copyWith(
            registerState:
                const RegisterStatus.failure(RegisterFailure.walletUserExist)));
        break;

      case 200118:
        emit(state.copyWith(
            registerState: const RegisterStatus.failure(
                RegisterFailure.walletPinInvalid)));
        break;
      default:
        showSimpleToast("unknown error");
        break;
    }
  }

  Future<void> createThanksMessage(Function() callback) async {
    emit(state.copyWith(
        createThanksMessageState: const CreateThanksMessageStatus.initial()));

    final userId = await getIt<UserStorageService>().getUserId();
    if (userId == null) {
      emit(state.copyWith(
          createThanksMessageState: const CreateThanksMessageStatus.failure(
              CreateThanksMessageFailure.userNotExist)));
      return;
    }

    try {
      await _authApi.createThanksMessage(
          userId, state.thanksMessageId, state.inviteCode);

      emit(state.copyWith(
          createThanksMessageState: const CreateThanksMessageStatus.success()));
    } catch (e, s) {
      emit(state.copyWith(
          createThanksMessageState: const CreateThanksMessageStatus.failure(
              CreateThanksMessageFailure.unknown)));

      await SentryService().reportError(e, s, tags: {
        "feature": "login",
        "level": '2'
      }, extra: {
        "userId": userId,
        "thanksMessageId": state.thanksMessageId,
        "inviteCode": state.inviteCode
      });
      return;
    } finally {
      emit(state.copyWith(
          createThanksMessageState: const CreateThanksMessageStatus.initial()));
    }
  }
}
