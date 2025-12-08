part of 'app_routes.dart';

@TypedGoRoute<LoginRoute>(path: RoutePaths.login, name: RouteNames.login)
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) {
    // Use new Auth Feature with Clean Architecture
    return CupertinoPage(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<AuthCubit>()),
          BlocProvider(create: (_) => getIt<EmailStepCubit>()),
          BlocProvider(create: (_) => getIt<VerifyStepCubit>()),
          BlocProvider(create: (_) => getIt<ProfileStepCubit>()),
        ],
        child: const LoginPage(),
      ),
    );
  }
}
