part of '../app_routes.dart';

@TypedGoRoute<TradeConfirmRoute>(
    path: RoutePaths.tradeConfirm, name: RouteNames.tradeConfirm)
class TradeConfirmRoute extends GoRouteData {
  const TradeConfirmRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      const CupertinoPage(child: TradeConfirmScreen());
}
