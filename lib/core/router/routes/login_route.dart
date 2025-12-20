part of 'app_routes.dart';

@TypedGoRoute<LoginRoute>(path: RoutePaths.login, name: RouteNames.login)
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    // Use new Auth Feature with Clean Architecture
    final authCubit = getIt<AuthCubit>();

    // Set auth complete callback - initialize user session
    authCubit.onAuthComplete = (result) async {
      // Initialize user session (fetch user info, connect WebSocket, etc.)
      print('result User: ${result.toString()}');

      await getIt<NewUserCubit>().login(result);
    };

    // Set navigation callback for successful authentication
    authCubit.onNavigateToHome = () {
      // Navigate to wallet page and clear the navigation stack
      const WalletRoute().go(context);
    };

    return CupertinoPage(
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authCubit),
          // Use the same sub-cubit instances from AuthCubit to ensure callbacks work
          BlocProvider.value(value: authCubit.emailStepCubit),
          BlocProvider.value(value: authCubit.verifyStepCubit),
          BlocProvider.value(value: authCubit.profileStepCubit),
        ],
        child: const LoginPage(),
      ),
    );
  }
}
