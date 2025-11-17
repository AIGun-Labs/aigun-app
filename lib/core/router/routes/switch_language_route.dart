part of 'app_routes.dart';

@TypedGoRoute<SwitchLanguageRoute>(
    path: RoutePaths.switchLanguage, name: RouteNames.switchLanguage)
class SwitchLanguageRoute extends GoRouteData {
  const SwitchLanguageRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      const CupertinoPage(child: SwitchLanguageScreen());
}
