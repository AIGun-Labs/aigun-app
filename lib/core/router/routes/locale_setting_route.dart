part of 'app_routes.dart';

@TypedGoRoute<LocaleSettingRoute>(
  path: RoutePaths.localeSetting,
  name: RouteNames.localeSetting,
)
class LocaleSettingRoute extends GoRouteData with $LocaleSettingRoute {
  const LocaleSettingRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      const CupertinoPage(child: LocaleSettingScreen());
}
