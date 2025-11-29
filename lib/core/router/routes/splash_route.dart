part of 'app_routes.dart';

@TypedGoRoute<SplashRoute>(path: RoutePaths.splash, name: RouteNames.splash)
class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      fade(const SplashScreen());
}
