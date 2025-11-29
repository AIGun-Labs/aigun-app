part of 'app_routes.dart';

@TypedGoRoute<LoginRoute>(path: RoutePaths.login, name: RouteNames.login)
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      const CupertinoPage(child: LoginScreen());
}
