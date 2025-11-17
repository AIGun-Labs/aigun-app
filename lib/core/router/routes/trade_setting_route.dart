part of 'app_routes.dart';

@TypedGoRoute<TradeSettingRoute>(
    path: RoutePaths.tradeSetting, name: RouteNames.tradeSetting)
class TradeSettingRoute extends GoRouteData {
  const TradeSettingRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      const CupertinoPage(child: TradeSettingScreen());
}
