# Auth Module Migration Plan - Clean Architecture (DDD)

## Overview

将登录注册模块从 `lib/screens/auth/` 迁移到 `lib/features/auth/` ，采用 Clean Architecture + DDD 最佳实践，模仿 Intelligence 模块架构。

---

## Current State Analysis

### 现有文件结构
```
lib/screens/auth/
├── auth.dart                    # LoginScreen - PageView 控制器
├── auth_steps.dart              # 步骤枚举
└── widgets/steps/
    ├── email_step.dart          # 邮箱输入步骤
    ├── verify_code_step.dart    # 验证码步骤
    ├── profile_step.dart        # 资料填写步骤
    └── success_step.dart        # 成功页面

lib/cubits/auth/
├── auth_cubit.dart              # 认证状态管理
└── auth_state.dart              # 状态定义

lib/data/services/api/
├── auth_api.dart                # API 调用

lib/utils/storage/secure/
├── token_storage_service.dart   # Token 存储
└── user_storage_service.dart    # User 存储
```

### 核心业务流程
1. **发送验证码** → Email → API
2. **验证验证码** → Code → API → Token/User 或 新用户流程
3. **注册新用户** → Nickname/InviteCode → API → Token/User
4. **感谢消息** → 记录邀请码使用

---

## Target Architecture

### 目标文件结构
```
lib/features/auth/
├── domain/                           # 领域层 (纯 Dart，无框架依赖)
│   ├── entities/
│   │   ├── auth_user_entity.dart     # 用户实体
│   │   ├── auth_token_entity.dart    # Token 实体
│   │   └── auth_result_entity.dart   # 认证结果实体 (Sealed Union)
│   ├── repositories/
│   │   └── auth_repository.dart      # 认证仓库接口
│   └── value_objects/                # 值对象 (DDD 最佳实践)
│       ├── email.dart                # Email 值对象 (自验证)
│       ├── verification_code.dart    # 验证码值对象
│       ├── nickname.dart             # 昵称值对象
│       └── invite_code.dart          # 邀请码值对象
│
├── application/                      # 应用层 (用例)
│   └── usecases/
│       ├── send_verification_code.dart
│       ├── verify_code.dart
│       ├── register_user.dart
│       ├── submit_thanks_message.dart
│       ├── get_current_user.dart
│       └── logout.dart
│
├── infrastructure/                   # 基础设施层 (实现)
│   ├── datasources/
│   │   ├── auth_remote_source.dart   # API 调用
│   │   └── auth_local_source.dart    # Token/User 本地存储
│   ├── models/
│   │   ├── auth_user_model.dart      # 用户 DTO
│   │   ├── auth_token_model.dart     # Token DTO
│   │   └── auth_response_model.dart  # API 响应 DTO
│   ├── repositories/
│   │   └── auth_repository_impl.dart # 仓库实现
│   └── mappers/
│       └── auth_mapper.dart          # Model <-> Entity 映射
│
└── presentation/                     # 表现层 (UI)
    ├── pages/
    │   └── login_page.dart           # 主登录页面
    ├── cubits/
    │   ├── auth/
    │   │   ├── auth_cubit.dart       # 主认证 Cubit (协调器)
    │   │   └── auth_state.dart       # 认证状态
    │   ├── email_step/
    │   │   ├── email_step_cubit.dart
    │   │   └── email_step_state.dart
    │   ├── verify_step/
    │   │   ├── verify_step_cubit.dart
    │   │   └── verify_step_state.dart
    │   ├── profile_step/
    │   │   ├── profile_step_cubit.dart
    │   │   └── profile_step_state.dart
    │   └── countdown/
    │       └── countdown_cubit.dart  # 倒计时管理
    └── widgets/
        ├── steps/
        │   ├── email_step.dart
        │   ├── verify_code_step.dart
        │   ├── profile_step.dart
        │   └── success_step.dart
        └── common/
            ├── auth_header.dart
            ├── auth_input_field.dart
            └── auth_button.dart
```

---

## Implementation Plan

### Phase 1: Domain Layer (领域层)

#### 1.1 Value Objects (值对象) - DDD 最佳实践
**文件**: `lib/features/auth/domain/value_objects/`

值对象封装业务规则和验证逻辑，确保数据始终有效：

```dart
// email.dart
@freezed
sealed class Email with _$Email {
  const Email._();
  const factory Email.valid(String value) = ValidEmail;
  const factory Email.invalid(String value, String reason) = InvalidEmail;

  factory Email.create(String input) {
    final trimmed = input.trim().toLowerCase();
    if (trimmed.isEmpty) return Email.invalid(input, 'Email is required');
    if (!RegExp(r'^[a-zA-Z0-9@._\-]+$').hasMatch(trimmed)) {
      return Email.invalid(input, 'Invalid email format');
    }
    // More validation...
    return Email.valid(trimmed);
  }

  bool get isValid => this is ValidEmail;
}
```

#### 1.2 Domain Entities (领域实体)
**文件**: `lib/features/auth/domain/entities/`

```dart
// auth_user_entity.dart
@freezed
sealed class AuthUserEntity with _$AuthUserEntity {
  const factory AuthUserEntity({
    required String id,
    required String email,
    String? nickname,
    String? avatar,
    String? inviteCode,
    DateTime? createdAt,
  }) = _AuthUserEntity;
}

// auth_token_entity.dart
@freezed
sealed class AuthTokenEntity with _$AuthTokenEntity {
  const factory AuthTokenEntity({
    required String accessToken,
    required String refreshToken,
  }) = _AuthTokenEntity;
}

// auth_result_entity.dart - Sealed Union for auth outcomes
@freezed
sealed class AuthResultEntity with _$AuthResultEntity {
  // 验证码验证成功 - 已存在用户
  const factory AuthResultEntity.existingUser({
    required AuthUserEntity user,
    required AuthTokenEntity tokens,
  }) = AuthResultExistingUser;

  // 验证码验证成功 - 新用户需要注册
  const factory AuthResultEntity.newUserRequired() = AuthResultNewUserRequired;

  // 注册成功
  const factory AuthResultEntity.registered({
    required AuthUserEntity user,
    required AuthTokenEntity tokens,
    required bool hasInviteCode,
  }) = AuthResultRegistered;
}
```

#### 1.3 Repository Interface (仓库接口)
**文件**: `lib/features/auth/domain/repositories/auth_repository.dart`

```dart
abstract class AuthRepository {
  // 发送验证码
  Future<Result<void>> sendVerificationCode({required Email email});

  // 验证验证码
  Future<Result<AuthResultEntity>> verifyCode({
    required Email email,
    required VerificationCode code,
  });

  // 注册新用户
  Future<Result<AuthResultEntity>> register({
    required Email email,
    required VerificationCode code,
    required Nickname nickname,
    InviteCode? inviteCode,
  });

  // 提交感谢消息
  Future<Result<void>> submitThanksMessage({
    required String messageId,
    required InviteCode inviteCode,
  });

  // 获取当前用户
  Future<Result<AuthUserEntity?>> getCurrentUser();

  // 退出登录
  Future<Result<void>> logout();

  // Token 管理
  Future<AuthTokenEntity?> getStoredTokens();
  Future<void> saveTokens(AuthTokenEntity tokens);
  Future<void> clearTokens();
}
```

---

### Phase 2: Application Layer (应用层)

#### 2.1 Use Cases
**文件**: `lib/features/auth/application/usecases/`

每个用例遵循单一职责原则：

```dart
// send_verification_code.dart
class SendVerificationCode {
  final AuthRepository _repository;

  SendVerificationCode(this._repository);

  Future<Result<void>> call({required String email}) async {
    final emailVO = Email.create(email);
    if (!emailVO.isValid) {
      return Result.failure((emailVO as InvalidEmail).reason);
    }
    return _repository.sendVerificationCode(email: emailVO as ValidEmail);
  }
}

// verify_code.dart
class VerifyCode {
  final AuthRepository _repository;

  VerifyCode(this._repository);

  Future<Result<AuthResultEntity>> call({
    required String email,
    required String code,
  }) async {
    final emailVO = Email.create(email);
    final codeVO = VerificationCode.create(code);

    if (!emailVO.isValid) return Result.failure('Invalid email');
    if (!codeVO.isValid) return Result.failure('Invalid code format');

    return _repository.verifyCode(
      email: emailVO as ValidEmail,
      code: codeVO as ValidVerificationCode,
    );
  }
}

// register_user.dart
class RegisterUser {
  final AuthRepository _repository;

  RegisterUser(this._repository);

  Future<Result<AuthResultEntity>> call({
    required String email,
    required String code,
    required String nickname,
    String? inviteCode,
  }) async {
    // Validate all inputs using Value Objects
    final emailVO = Email.create(email);
    final codeVO = VerificationCode.create(code);
    final nicknameVO = Nickname.create(nickname);
    final inviteCodeVO = inviteCode != null ? InviteCode.create(inviteCode) : null;

    // Check validations
    if (!emailVO.isValid) return Result.failure('Invalid email');
    if (!codeVO.isValid) return Result.failure('Invalid code');
    if (!nicknameVO.isValid) return Result.failure('Invalid nickname');
    if (inviteCodeVO != null && !inviteCodeVO.isValid) {
      return Result.failure('Invalid invite code');
    }

    return _repository.register(
      email: emailVO as ValidEmail,
      code: codeVO as ValidVerificationCode,
      nickname: nicknameVO as ValidNickname,
      inviteCode: inviteCodeVO as ValidInviteCode?,
    );
  }
}
```

---

### Phase 3: Infrastructure Layer (基础设施层)

#### 3.1 Data Models
**文件**: `lib/features/auth/infrastructure/models/`

```dart
// auth_user_model.dart
@freezed
sealed class AuthUserModel with _$AuthUserModel {
  @JsonSerializable(explicitToJson: true)
  const factory AuthUserModel({
    @JsonKey(name: 'pk') String? id,
    String? email,
    String? nickname,
    String? avatar,
    @JsonKey(name: 'invite_code') String? inviteCode,
    @JsonKey(name: 'created_at')
    @NaiveToUtcDateTimeConverter()
    DateTime? createdAt,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
}

// auth_response_model.dart
@freezed
sealed class AuthResponseModel with _$AuthResponseModel {
  @JsonSerializable(explicitToJson: true)
  const factory AuthResponseModel({
    AuthUserModel? user,
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}
```

#### 3.2 Data Sources
**文件**: `lib/features/auth/infrastructure/datasources/`

```dart
// auth_remote_source.dart
class AuthRemoteSource {
  final DioClient _client;

  AuthRemoteSource(this._client);

  Future<void> sendVerificationCode(String email) async {
    await _client.post(
      '/api/v1/intel-user/send-verification-code',
      data: {'email': email},
    );
  }

  Future<AuthResponseModel> verifyCode(String email, String code) async {
    final response = await _client.post(
      '/api/v1/intel-user/verify-code',
      data: {'email': email, 'code': code},
    );
    return AuthResponseModel.fromJson(response);
  }

  Future<AuthResponseModel> register({
    required String email,
    required String verifyCode,
    required String nickname,
    required String deviceId,
    required String deviceType,
    String? inviteCode,
  }) async {
    final response = await _client.post(
      '/api/v2/intel-user/register',
      data: {
        'email': email,
        'verify_code': verifyCode,
        'nickname': nickname,
        'device_id': deviceId,
        'device_type': deviceType,
        if (inviteCode != null) 'invite_code': inviteCode,
      },
    );
    return AuthResponseModel.fromJson(response);
  }

  Future<void> submitThanksMessage(String messageId, String inviteCode) async {
    await _client.post(
      '/api/v1/invite/message',
      data: {'message_id': messageId, 'invite_code': inviteCode},
    );
  }
}

// auth_local_source.dart
class AuthLocalSource {
  final TokenStorageService _tokenStorage;
  final UserStorageService _userStorage;

  AuthLocalSource(this._tokenStorage, this._userStorage);

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _tokenStorage.saveTokens(accessToken, refreshToken);
  }

  Future<(String?, String?)> getTokens() async {
    final access = await _tokenStorage.getAccessToken();
    final refresh = await _tokenStorage.getRefreshToken();
    return (access, refresh);
  }

  Future<void> clearTokens() async {
    await _tokenStorage.deleteTokens();
  }

  Future<void> saveUser(AuthUserModel user) async {
    await _userStorage.saveUser(jsonEncode(user.toJson()));
  }

  Future<AuthUserModel?> getUser() async {
    final json = await _userStorage.getUser();
    if (json == null) return null;
    return AuthUserModel.fromJson(json);
  }

  Future<void> clearUser() async {
    await _userStorage.deleteUser();
  }
}
```

#### 3.3 Repository Implementation
**文件**: `lib/features/auth/infrastructure/repositories/auth_repository_impl.dart`

```dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteSource _remoteSource;
  final AuthLocalSource _localSource;
  final DeviceInfoService _deviceInfo;

  AuthRepositoryImpl(this._remoteSource, this._localSource, this._deviceInfo);

  @override
  Future<Result<void>> sendVerificationCode({required Email email}) async {
    try {
      await _remoteSource.sendVerificationCode(email.value);
      return Result.success(null);
    } on BusinessException catch (e) {
      return _handleBusinessException(e);
    } catch (e, s) {
      Logger.error('Send verification code failed', error: e, stackTrace: s);
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<AuthResultEntity>> verifyCode({
    required Email email,
    required VerificationCode code,
  }) async {
    try {
      final response = await _remoteSource.verifyCode(email.value, code.value);

      if (response.user != null && response.accessToken != null) {
        // 保存 Token 和用户
        await _localSource.saveTokens(
          response.accessToken!,
          response.refreshToken!,
        );
        await _localSource.saveUser(response.user!);

        return Result.success(AuthResultEntity.existingUser(
          user: response.user!.toEntity(),
          tokens: AuthTokenEntity(
            accessToken: response.accessToken!,
            refreshToken: response.refreshToken!,
          ),
        ));
      }

      return Result.success(AuthResultEntity.newUserRequired());
    } on BusinessException catch (e) {
      if (e.code == 200200) {
        // User not exists - need registration
        return Result.success(AuthResultEntity.newUserRequired());
      }
      return _handleBusinessException(e);
    } catch (e, s) {
      Logger.error('Verify code failed', error: e, stackTrace: s);
      return Result.failure(e.toString());
    }
  }

  // ... 其他方法实现
}
```

#### 3.4 Mappers
**文件**: `lib/features/auth/infrastructure/mappers/auth_mapper.dart`

```dart
extension AuthUserModelMapper on AuthUserModel {
  AuthUserEntity toEntity() => AuthUserEntity(
    id: id ?? '',
    email: email ?? '',
    nickname: nickname,
    avatar: avatar,
    inviteCode: inviteCode,
    createdAt: createdAt,
  );
}

extension AuthUserEntityMapper on AuthUserEntity {
  AuthUserModel toModel() => AuthUserModel(
    id: id,
    email: email,
    nickname: nickname,
    avatar: avatar,
    inviteCode: inviteCode,
    createdAt: createdAt,
  );
}
```

---

### Phase 4: Presentation Layer (表现层)

#### 4.1 Cubit State Design
**文件**: `lib/features/auth/presentation/cubits/`

采用协调器模式（类似 IntelligenceCubit）：

```dart
// auth_state.dart
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStep.email) AuthStep currentStep,
    @Default(false) bool isLoading,
    String? errorMessage,
    AuthUserEntity? user,
    @Default(false) bool isAuthenticated,
  }) = _AuthState;
}

enum AuthStep { email, verifyCode, profile, success }

// email_step_state.dart
@freezed
sealed class EmailStepState with _$EmailStepState {
  const factory EmailStepState({
    @Default('') String email,
    @Default(EmailStepStatus.initial) EmailStepStatus status,
    String? errorMessage,
    DateTime? lastSentAt,
  }) = _EmailStepState;

  bool get canSend => status != EmailStepStatus.sending;
  int get remainingSeconds => /* 计算剩余倒计时 */;
}

@freezed
sealed class EmailStepStatus with _$EmailStepStatus {
  const factory EmailStepStatus.initial() = EmailStepInitial;
  const factory EmailStepStatus.sending() = EmailStepSending;
  const factory EmailStepStatus.sent() = EmailStepSent;
  const factory EmailStepStatus.error(String message) = EmailStepError;
}
```

#### 4.2 Main Auth Cubit (协调器)
**文件**: `lib/features/auth/presentation/cubits/auth/auth_cubit.dart`

```dart
class AuthCubit extends Cubit<AuthState> {
  final VerifyCode _verifyCode;
  final RegisterUser _registerUser;
  final EmailStepCubit emailStepCubit;
  final VerifyStepCubit verifyStepCubit;
  final ProfileStepCubit profileStepCubit;

  AuthCubit({
    required VerifyCode verifyCode,
    required RegisterUser registerUser,
    required this.emailStepCubit,
    required this.verifyStepCubit,
    required this.profileStepCubit,
  }) : _verifyCode = verifyCode,
       _registerUser = registerUser,
       super(const AuthState());

  void goToStep(AuthStep step) {
    emit(state.copyWith(currentStep: step));
  }

  Future<void> onVerifyCodeSuccess(AuthResultEntity result) async {
    result.when(
      existingUser: (user, tokens) {
        emit(state.copyWith(
          isAuthenticated: true,
          user: user,
        ));
        // Navigate to wallet
      },
      newUserRequired: () {
        goToStep(AuthStep.profile);
      },
      registered: (user, tokens, hasInviteCode) {
        emit(state.copyWith(
          isAuthenticated: true,
          user: user,
        ));
        if (hasInviteCode) {
          goToStep(AuthStep.success);
        } else {
          // Navigate to wallet
        }
      },
    );
  }
}
```

---

### Phase 5: DI Module

#### 5.1 Auth Module
**文件**: `lib/core/di/modules/auth_module.dart`

```dart
class AuthModule implements InjectionModule {
  final GetIt _sl;

  AuthModule(this._sl);

  @override
  Future<void> init() async {
    // ===== Data Sources =====
    _sl.registerLazySingleton<AuthRemoteSource>(
      () => AuthRemoteSource(_sl<DioClient>()),
    );

    _sl.registerLazySingleton<AuthLocalSource>(
      () => AuthLocalSource(
        _sl<TokenStorageService>(),
        _sl<UserStorageService>(),
      ),
    );

    // ===== Repository =====
    _sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        _sl<AuthRemoteSource>(),
        _sl<AuthLocalSource>(),
        _sl<DeviceInfoService>(),
      ),
    );

    // ===== Use Cases =====
    _sl.registerLazySingleton(() => SendVerificationCode(_sl<AuthRepository>()));
    _sl.registerLazySingleton(() => VerifyCode(_sl<AuthRepository>()));
    _sl.registerLazySingleton(() => RegisterUser(_sl<AuthRepository>()));
    _sl.registerLazySingleton(() => SubmitThanksMessage(_sl<AuthRepository>()));
    _sl.registerLazySingleton(() => GetCurrentUser(_sl<AuthRepository>()));
    _sl.registerLazySingleton(() => Logout(_sl<AuthRepository>()));

    // ===== Sub-Cubits =====
    _sl.registerFactory<EmailStepCubit>(
      () => EmailStepCubit(sendVerificationCode: _sl<SendVerificationCode>()),
    );

    _sl.registerFactory<VerifyStepCubit>(
      () => VerifyStepCubit(verifyCode: _sl<VerifyCode>()),
    );

    _sl.registerFactory<ProfileStepCubit>(
      () => ProfileStepCubit(registerUser: _sl<RegisterUser>()),
    );

    _sl.registerFactory<CountdownCubit>(() => CountdownCubit());

    // ===== Main Cubit =====
    _sl.registerFactory<AuthCubit>(
      () => AuthCubit(
        verifyCode: _sl<VerifyCode>(),
        registerUser: _sl<RegisterUser>(),
        emailStepCubit: _sl<EmailStepCubit>(),
        verifyStepCubit: _sl<VerifyStepCubit>(),
        profileStepCubit: _sl<ProfileStepCubit>(),
      ),
    );
  }
}
```

---

### Phase 6: Route Configuration

#### 6.1 Update Routes
**文件**: `lib/core/router/routes/login_route.dart`

```dart
@TypedGoRoute<LoginRoute>(path: RoutePaths.login, name: RouteNames.login)
final class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<EmailStepCubit>()),
        BlocProvider(create: (_) => getIt<VerifyStepCubit>()),
        BlocProvider(create: (_) => getIt<ProfileStepCubit>()),
        BlocProvider(create: (_) => getIt<CountdownCubit>()),
      ],
      child: const LoginPage(),
    );
  }
}
```

---

## Business Exception Handling Pattern (参考 Swap 模块)

### Repository 层抛出业务异常

参考 `lib/features/swap/data/repositories/swap_repository_impl.dart`：

```dart
// auth_repository_impl.dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteSource _remoteSource;
  final AuthLocalSource _localSource;

  AuthRepositoryImpl(this._remoteSource, this._localSource);

  @override
  Future<Result<AuthResultEntity>> verifyCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _remoteSource.verifyCode(email, code);

      if (response.user != null && response.accessToken != null) {
        // 保存 tokens
        await _localSource.saveTokens(
          response.accessToken!,
          response.refreshToken!,
        );
        await _localSource.saveUser(response.user!);

        return Result.success(AuthResultEntity.existingUser(
          user: response.user!.toEntity(),
          tokens: AuthTokenEntity(
            accessToken: response.accessToken!,
            refreshToken: response.refreshToken!,
          ),
        ));
      }

      return Result.success(const AuthResultEntity.newUserRequired());
    } on DioException catch (e) {
      // 关键：捕获 DioException 并提取 BusinessException
      if (e.error is BusinessException) {
        final be = e.error as BusinessException;

        // 特殊处理：200200 表示用户不存在，需要注册
        if (be.code == 200200) {
          return Result.success(const AuthResultEntity.newUserRequired());
        }

        // 其他业务异常直接返回
        return Result.be(be);
      }
      return Result.failure(e.toString());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<void>> sendVerificationCode({required String email}) async {
    try {
      await _remoteSource.sendVerificationCode(email);
      return Result.success(null);
    } on DioException catch (e) {
      if (e.error is BusinessException) {
        return Result.be(e.error as BusinessException);
      }
      return Result.failure(e.toString());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<AuthResultEntity>> register({
    required String email,
    required String code,
    required String nickname,
    String? inviteCode,
  }) async {
    try {
      final response = await _remoteSource.register(
        email: email,
        verifyCode: code,
        nickname: nickname,
        inviteCode: inviteCode,
      );

      if (response.user != null && response.accessToken != null) {
        await _localSource.saveTokens(
          response.accessToken!,
          response.refreshToken!,
        );
        await _localSource.saveUser(response.user!);

        return Result.success(AuthResultEntity.registered(
          user: response.user!.toEntity(),
          tokens: AuthTokenEntity(
            accessToken: response.accessToken!,
            refreshToken: response.refreshToken!,
          ),
          hasInviteCode: inviteCode?.isNotEmpty ?? false,
        ));
      }

      return Result.failure('Registration failed');
    } on DioException catch (e) {
      if (e.error is BusinessException) {
        return Result.be(e.error as BusinessException);
      }
      return Result.failure(e.toString());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
```

### Cubit 层处理业务异常

参考 `lib/features/swap/presentation/cubit/transaction/transaction_cubit.dart`：

```dart
// verify_step_cubit.dart
class VerifyStepCubit extends Cubit<VerifyStepState> {
  final VerifyCode _verifyCode;

  VerifyStepCubit({required VerifyCode verifyCode})
      : _verifyCode = verifyCode,
        super(const VerifyStepState());

  /// 验证成功回调 (existing user 或 new user required)
  void Function(AuthResultEntity result)? onVerifySuccess;

  /// 验证失败回调 (带业务错误码)
  void Function(String? message, int? code)? onVerifyFailure;

  Future<void> verify(String email, String code) async {
    emit(state.copyWith(status: const VerifyStatus.loading()));

    final result = await _verifyCode.call(email: email, code: code);

    result.whenOrNull(
      success: (authResult) {
        emit(state.copyWith(status: const VerifyStatus.success()));
        onVerifySuccess?.call(authResult);
      },
      failure: (error) {
        emit(state.copyWith(
          status: VerifyStatus.failure(error),
          errorMessage: error,
        ));
        onVerifyFailure?.call(error, null);
      },
      // 关键：处理业务异常
      be: (be) {
        emit(state.copyWith(
          status: VerifyStatus.failure(be.msg),
          errorMessage: be.msg,
          errorCode: be.code,
        ));
        // 根据业务错误码做特殊处理
        _handleBusinessError(be);
        onVerifyFailure?.call(be.msg, be.code);
      },
    );
  }

  /// 处理特定业务错误码
  void _handleBusinessError(BusinessException be) {
    switch (be.code) {
      case 200102: // 验证码过期
        emit(state.copyWith(errorType: VerifyErrorType.codeExpired));
        break;
      case 200103: // 验证码无效
        emit(state.copyWith(errorType: VerifyErrorType.codeInvalid));
        break;
      case 200201: // 用户已存在 (verify-code API)
        emit(state.copyWith(errorType: VerifyErrorType.userExists));
        break;
      default:
        break;
    }
  }
}
```

### Auth 业务错误码常量

```dart
// lib/features/auth/domain/constants/auth_error_codes.dart
abstract class AuthErrorCodes {
  // 验证码相关
  static const int codeExpired = 200102;
  static const int codeInvalid = 200103;
  static const int sendCodeTooFrequently = 200108;
  static const int sendCodeTooMany = 200109;
  static const int emailInvalid = 200110;

  // 用户相关
  static const int userNotExists = 200200;
  static const int userExists = 200201;

  // 注册相关
  static const int inviteCodeInvalid = 200205;
  static const int createWalletFail = 200116;
  static const int walletUserExists = 200117;
  static const int walletPinInvalid = 200118;
}
```

---

## Critical Files to Modify

### New Files (Create)
1. `lib/features/auth/domain/entities/auth_user_entity.dart`
2. `lib/features/auth/domain/entities/auth_token_entity.dart`
3. `lib/features/auth/domain/entities/auth_result_entity.dart`
4. `lib/features/auth/domain/repositories/auth_repository.dart`
5. `lib/features/auth/domain/constants/auth_error_codes.dart`
6. `lib/features/auth/application/usecases/send_verification_code.dart`
7. `lib/features/auth/application/usecases/verify_code.dart`
8. `lib/features/auth/application/usecases/register_user.dart`
9. `lib/features/auth/application/usecases/submit_thanks_message.dart`
10. `lib/features/auth/infrastructure/models/auth_user_model.dart`
11. `lib/features/auth/infrastructure/models/auth_response_model.dart`
12. `lib/features/auth/infrastructure/datasources/auth_remote_source.dart`
13. `lib/features/auth/infrastructure/datasources/auth_local_source.dart`
14. `lib/features/auth/infrastructure/repositories/auth_repository_impl.dart`
15. `lib/features/auth/infrastructure/mappers/auth_mapper.dart`
16. `lib/features/auth/presentation/cubits/auth/auth_cubit.dart`
17. `lib/features/auth/presentation/cubits/auth/auth_state.dart`
18. `lib/features/auth/presentation/cubits/email_step/email_step_cubit.dart`
19. `lib/features/auth/presentation/cubits/email_step/email_step_state.dart`
20. `lib/features/auth/presentation/cubits/verify_step/verify_step_cubit.dart`
21. `lib/features/auth/presentation/cubits/verify_step/verify_step_state.dart`
22. `lib/features/auth/presentation/cubits/profile_step/profile_step_cubit.dart`
23. `lib/features/auth/presentation/cubits/profile_step/profile_step_state.dart`
24. `lib/features/auth/presentation/pages/login_page.dart`
25. `lib/features/auth/presentation/widgets/steps/` (4 step widgets)
26. `lib/core/di/modules/auth_module.dart`

### Existing Files to Modify
1. `lib/core/di/injection_container.dart` - 添加 AuthModule 初始化
2. `lib/core/router/routes/login_route.dart` - 更新路由指向新页面

### Files to Keep (暂时保留旧文件)
1. `lib/cubits/user/user_cubit.dart` - 保留为全局用户状态管理
2. `lib/utils/storage/secure/token_storage_service.dart` - 保留，被 AuthLocalSource 使用
3. `lib/utils/storage/secure/user_storage_service.dart` - 保留，被 AuthLocalSource 使用
4. `lib/screens/auth/` - **暂时保留**，迁移完成验证后再删除
5. `lib/cubits/auth/` - **暂时保留**，迁移完成验证后再删除
6. `lib/data/services/api/auth_api.dart` - **暂时保留**，迁移完成验证后再删除

### Files to Remove (迁移验证完成后)
迁移完成并测试通过后，再删除以下文件：
1. `lib/screens/auth/` - 整个目录
2. `lib/cubits/auth/` - 整个目录
3. `lib/data/services/api/auth_api.dart`

---

## Route Update (路由更新)

### 更新 login_route.dart

**文件**: `lib/core/router/routes/login_route.dart`

```dart
part of 'app_routes.dart';

@TypedGoRoute<LoginRoute>(path: RoutePaths.login, name: RouteNames.login)
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) {
    // 更新：使用新的 Auth Feature 页面和 Cubits
    return CupertinoPage(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<AuthCubit>()),
          BlocProvider(create: (_) => getIt<EmailStepCubit>()),
          BlocProvider(create: (_) => getIt<VerifyStepCubit>()),
          BlocProvider(create: (_) => getIt<ProfileStepCubit>()),
        ],
        // 使用新的 LoginPage (from features/auth/)
        child: const LoginPage(),
      ),
    );
  }
}
```

### 或者使用 SlideHRouteData (带动画)

```dart
part of 'app_routes.dart';

@TypedGoRoute<LoginRoute>(path: RoutePaths.login, name: RouteNames.login)
final class LoginRoute extends SlideHRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget buildPageChild(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<EmailStepCubit>()),
        BlocProvider(create: (_) => getIt<VerifyStepCubit>()),
        BlocProvider(create: (_) => getIt<ProfileStepCubit>()),
      ],
      child: const LoginPage(),
    );
  }
}
```

---

## Design Patterns Applied

1. **Clean Architecture**: 严格分层，依赖倒置
2. **DDD Value Objects**: Email, VerificationCode, Nickname, InviteCode 自验证值对象
3. **Sealed Union Types**: AuthResultEntity 使用 Freezed sealed class 表示多态结果
4. **Repository Pattern**: 抽象数据访问，便于测试和替换
5. **Use Case Pattern**: 单一职责，业务逻辑封装
6. **Coordinator Pattern**: AuthCubit 协调多个子 Cubit
7. **Result<T> Pattern**: 统一错误处理
8. **Extension Mappers**: Model <-> Entity 转换
9. **Factory Registration**: 每次登录流程使用新的 Cubit 实例

---

## Migration Strategy

1. **Phase 1**: 创建 domain 层（实体、值对象、仓库接口）
2. **Phase 2**: 创建 application 层（用例）
3. **Phase 3**: 创建 infrastructure 层（数据源、模型、仓库实现）
4. **Phase 4**: 创建 presentation 层（Cubit、页面、组件）
5. **Phase 5**: 创建 DI 模块并注册
6. **Phase 6**: 更新路由配置
7. **Phase 7**: 测试新实现
8. **Phase 8**: 删除旧文件

---

## Estimated Effort

- Domain Layer: 6-8 files
- Application Layer: 5-6 files
- Infrastructure Layer: 6-8 files
- Presentation Layer: 10-12 files
- DI & Routing: 2-3 files

**Total**: ~30+ files to create/modify
