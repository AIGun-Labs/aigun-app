import 'package:get_it/get_it.dart';

import '../../../features/auth/application/usecases/register_user.dart';
import '../../../features/auth/application/usecases/send_verification_code.dart';
import '../../../features/auth/application/usecases/submit_thanks_message.dart';
import '../../../features/auth/application/usecases/verify_code.dart';
import '../../../features/auth/domain/repositories/auth_repository.dart';
import '../../../features/auth/infrastructure/datasources/auth_local_source.dart';
import '../../../features/auth/infrastructure/datasources/auth_remote_source.dart';
import '../../../features/auth/infrastructure/repositories/auth_repository_impl.dart';
import '../../../features/auth/presentation/cubits/auth/auth_cubit.dart';
import '../../../features/auth/presentation/cubits/email_step/email_step_cubit.dart';
import '../../../features/auth/presentation/cubits/profile_step/profile_step_cubit.dart';
import '../../../features/auth/presentation/cubits/verify_step/verify_step_cubit.dart';
import '../../../utils/storage/secure/token_storage_service.dart';
import '../../../utils/storage/secure/user_storage_service.dart';
import '../module_repo.dart';

/// Auth Feature DI Module
///
/// Registers all dependencies for the authentication feature.
/// Follows Clean Architecture layered registration:
/// Data Sources -> Repository -> Use Cases -> Cubits
class AuthModule implements InjectionModule {
  AuthModule(this._sl);
  final GetIt _sl;

  @override
  Future<void> init() async {
    // ==================== Data Sources ====================

    _sl.registerLazySingleton<AuthRemoteSource>(() => AuthRemoteSource(_sl()));

    _sl.registerLazySingleton<AuthLocalSource>(
      () => AuthLocalSource(
        _sl<TokenStorageService>(),
        _sl<UserStorageService>(),
      ),
    );

    // ==================== Repository ====================

    _sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(_sl<AuthRemoteSource>(), _sl<AuthLocalSource>()),
    );

    // ==================== Use Cases ====================

    _sl.registerLazySingleton<SendVerificationCode>(
      () => SendVerificationCode(_sl<AuthRepository>()),
    );

    _sl.registerLazySingleton<VerifyCode>(
      () => VerifyCode(_sl<AuthRepository>()),
    );

    _sl.registerLazySingleton<RegisterUser>(
      () => RegisterUser(_sl<AuthRepository>()),
    );

    _sl.registerLazySingleton<SubmitThanksMessage>(
      () => SubmitThanksMessage(_sl<AuthRepository>()),
    );

    // ==================== Sub-Cubits ====================
    // Using LazySingleton - call reset() on logout to clear state

    _sl.registerLazySingleton<EmailStepCubit>(
      () => EmailStepCubit(sendVerificationCode: _sl<SendVerificationCode>()),
    );

    _sl.registerLazySingleton<VerifyStepCubit>(
      () => VerifyStepCubit(verifyCode: _sl<VerifyCode>()),
    );

    _sl.registerLazySingleton<ProfileStepCubit>(
      () => ProfileStepCubit(
        registerUser: _sl<RegisterUser>(),
        submitThanksMessage: _sl<SubmitThanksMessage>(),
      ),
    );

    // ==================== Main Cubit ====================

    _sl.registerLazySingleton<AuthCubit>(
      () => AuthCubit(
        emailStepCubit: _sl<EmailStepCubit>(),
        verifyStepCubit: _sl<VerifyStepCubit>(),
        profileStepCubit: _sl<ProfileStepCubit>(),
        submitThanksMessage: _sl<SubmitThanksMessage>(),
      ),
    );
  }
}
