import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/core/custom_exceptions.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/auth/auth_state.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/network/network_state.dart' as network;
import 'package:flutter_aigun/data/services/api/auth_api.dart';
import 'package:flutter_aigun/utils/storage/secure/token_storage_service.dart';
import 'package:flutter_aigun/utils/storage/secure/user_storage_service.dart';
import 'package:flutter_aigun/utils/validators/auth_validator.dart';
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

  Future<void> login(String email, String code, Function() loginSuccess) async {
    try {
      emit(state.copyWith(
          verifyCodeStatus: const network.NetworkState.loading()));
      await _authApi.verifyEmailCode(email: email, code: code);

    emit(state.copyWith(
        verifyCodeStatus: const network.NetworkState.success(null),
        event: const SingleShotEvent.loginSuccess(),
        isLoggedIn: true));
    await userCubit.getUserInfo();
      Future.delayed(const Duration(seconds: 2), () {
        loginSuccess(); // sign in success
      });
    } on DioException catch (e) {
      if (e.error is BusinessException) {
        BusinessException be = e.error as BusinessException;
        emit(
          state.copyWith(
            verifyCodeStatus: network.NetworkState.error(
                network.Failure.business(be.code, be.msg)),
          ),
        );

        // 根据业务状态码执行不同操作
        _handleBusinessException(be.code, be.msg, loginSuccess);
      } else {
        emit(
          state.copyWith(
            verifyCodeStatus: const network.NetworkState.error(
                network.Failure.network("网络错误，验证码错误")),
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(
          verifyCodeStatus: const network.NetworkState.error(
              network.Failure.network("网络错误，验证码错误"))));
    } finally {
      emit(state.copyWith(
          verifyCodeStatus: const network.NetworkState.initial()));
    }
  }

  Future<void> sendVerificationCode(
      BuildContext context, Function() callback) async {
    if (state.isLoading) return; // 如果正在发送验证码，则不发送

    if (!FormValidator.validateEmail(state.email).isValid) {
      emit(state.copyWith(isEmailValid: false));
      emit(state.copyWith(
        event: const SingleShotEvent.showDialog(
          titleKey: "邮箱格式错误",
          messageKey: "请输入正确的邮箱",
        ),
      ));
      return;
    }

    emit(state.copyWith(isEmailValid: true));

    try {
      emit(
          state.copyWith(sendCodeStatus: const network.NetworkState.loading()));
      await _authApi.sendVerificationCode(state.email);
      emit(state.copyWith(
        sendCodeStatus: const network.NetworkState.success(null),
        event: const SingleShotEvent.showDialog(
          titleKey: "发送验证码成功",
          messageKey: "验证码已发送至邮箱",
        ),
      ));
      callback(); // 发送验证码成功后，调用回调函数
    } on DioException catch (e) {
      if (e.error is BusinessException) {
        BusinessException be = e.error as BusinessException;
        _handleBusinessException(be.code, be.msg, callback);
        emit(state.copyWith(
            sendCodeStatus: network.NetworkState.error(
                network.Failure.business(be.code, be.msg))));
      } else {
        emit(state.copyWith(
            sendCodeStatus: const network.NetworkState.error(
                network.Failure.network("网络错误，发送验证码失败")),
            event: SingleShotEvent.showDialog(
                titleKey: "网络错误，发送验证码失败", messageKey: "网络错误，发送验证码失败")));
      }
    } finally {
      emit(
          state.copyWith(sendCodeStatus: const network.NetworkState.initial()));
    }
  }

  Future<void> verifyCode(Function() callback, Function() loginSuccess) async {
    if (!FormValidator.validateVerificationCode(state.code).isValid) {
      emit(state.copyWith(isCodeValid: false));
      return;
    }

    emit(state.copyWith(isCodeValid: true));

    try {
      emit(state.copyWith(
          verifyCodeStatus: const network.NetworkState.loading()));
      await _authApi.verifyEmailCode(email: state.email, code: state.code);

      await userCubit.getUserInfo();
      // 延迟 2 秒后，登录成功
      Future.delayed(const Duration(seconds: 2), () {
        loginSuccess(); // sign in success

        // 要使用原本的 stream 更新 state
        emit(state.copyWith(
            verifyCodeStatus: const network.NetworkState.success(null),
            event: const SingleShotEvent.loginSuccess(),
            isLoggedIn: true));
      });
    } on DioException catch (e) {
      // 业务状态码错误
      if (e.error is BusinessException) {
        BusinessException be = e.error as BusinessException;
        emit(
          state.copyWith(
            verifyCodeStatus: network.NetworkState.error(
                network.Failure.business(be.code, be.msg)),
          ),
        );
        if (be.code == 200200) {
          // loginSuccess();
          emit(state.copyWith(
              event: const SingleShotEvent.showDialog(
                  titleKey: "用户不存在", messageKey: "该邮箱未注册，请先注册账号")));
          callback();
          return;
        }

        if (be.code == 200103) {
          emit(state.copyWith(
              event: const SingleShotEvent.showDialog(
                  titleKey: "验证码错误", messageKey: "请输入正确的验证码")));
          return;
        }

        if (be.code == 200201) {
          emit(
            state.copyWith(
              event: const SingleShotEvent.showDialog(
                  titleKey: "用户已存在", messageKey: "该邮箱已注册，请直接登录"),
            ),
          );
          callback();
          return;
        }

        if (be.code == 200102) {
          emit(state.copyWith(
              event: const SingleShotEvent.showDialog(
                  titleKey: "验证码过期", messageKey: "请重新发送验证码")));
          callback();
          return;
        }

        // 根据业务状态码执行不同操作
        // _handleBusinessException(be.code, be.msg, callback);
      } else {
        emit(
          state.copyWith(
            verifyCodeStatus: const network.NetworkState.error(
                network.Failure.network("网络错误，验证码错误")),
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(
          verifyCodeStatus: const network.NetworkState.error(
              network.Failure.network("网络错误，验证码错误"))));
    }
    // finally {
    //   emit(state.copyWith(
    //       verifyCodeStatus: const network.NetworkState.initial()));
    // }
  }

  /// 处理业务异常，根据状态码执行不同操作
  void _handleBusinessException(int code, String message, Function callback) {
    switch (code) {
      case 200200: // 用户不存在
        emit(state.copyWith(
            event: const SingleShotEvent.showDialog(
                titleKey: "用户不存在", messageKey: "该邮箱未注册，请先注册账号")));
        callback();
        break;
      case 200201: // 用户已存在
        emit(state.copyWith(
            isUserExists: true, event: const SingleShotEvent.userExists()));
        // callback();
        break;
      case 200103: // 验证码错误
        emit(state.copyWith(
          event: const SingleShotEvent.showDialog(
            titleKey: "验证码错误",
            messageKey: "请输入正确的验证码",
          ),
        ));
        break;
      case 200205:
        emit(state.copyWith(isInviteCodeValid: false));
        break;
      default:
        emit(state.copyWith(
          event: SingleShotEvent.showDialog(
            titleKey: "验证失败",
            messageKey: message,
          ),
        ));
        break;
    }
  }

  Future<void> register(Function() callback, Function() userExists) async {
    // validate  nickname
    if (!FormValidator.validateNickname(state.nickname).isValid) {
      emit(state.copyWith(isNicknameValid: false));
      return;
    }
    emit(state.copyWith(isNicknameValid: true));

    // validate invite code
    if (!FormValidator.validateInviteCode(state.inviteCode).isValid) {
      emit(state.copyWith(isInviteCodeValid: false));
      return;
    }
    emit(state.copyWith(isInviteCodeValid: true));

    if (!AuthValidator.validatePaymentPin(state.paymentPin).isValid) {
      emit(state.copyWith(isPaymentPinValid: false));
      return;
    }
    emit(state.copyWith(isPaymentPinValid: true));

// 添加 loading 效果
    emit(state.copyWith(isLoading: true));

    try {
      emit(
          state.copyWith(registerStatus: const network.NetworkState.loading()));

      await _authApi.register(state.email, state.code, state.nickname,
          state.inviteCode, state.paymentPin);

      await userCubit.getUserInfo();
      // Registration successful and redirected to the homepage
      // 登录成功
      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(
            registerStatus: const network.NetworkState.success(null),
            event: const SingleShotEvent.showDialog(
                titleKey: "注册成功", messageKey: "注册成功"),
            isLoggedIn: true));
        callback();
      });
    } on DioException catch (e) {
      if (e.error is BusinessException) {
        // Business Exception handling
        BusinessException be = e.error as BusinessException;

        _handleBusinessException(be.code, be.msg, callback);

        if (be.code == 200201) {
          // 用户已存在
          userExists();
          emit(state.copyWith(
              event: const SingleShotEvent.showDialog(
                  titleKey: "用户已存在", messageKey: "该邮箱已注册，请直接登录")));
          return;
        }

        emit(state.copyWith(
            registerStatus: network.NetworkState.error(
                network.Failure.business(be.code, be.msg))));
      } else {
        emit(state.copyWith(
            registerStatus: const network.NetworkState.error(
                network.Failure.network("网络错误，注册失败"))));
      }
    } catch (e) {
      emit(state.copyWith(
          registerStatus: const network.NetworkState.error(
              network.Failure.network("网络错误，注册失败"))));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> createThanksMessage(Function() callback) async {
    emit(state.copyWith(isLoading: true));

    final userId = await getIt<UserStorageService>().getUserId();
    if (userId == null) {
      emit(state.copyWith(isLoading: false));
      return;
    }

    try {
      final response = await _authApi.createThanksMessage(
          userId, state.thanksMessageId, state.inviteCode);
      if (response.code == 0) {
        callback();
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      return;
    }
  }
}
