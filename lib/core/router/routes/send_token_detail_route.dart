part of '../app_routes.dart';

@TypedGoRoute<SendTokenDetailRoute>(
    path: RoutePaths.sendTokenDetail, name: RouteNames.sendTokenDetail)
class SendTokenDetailRoute extends GoRouteData {
  const SendTokenDetailRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      const CupertinoPage(child: SendTokenDetailScreen());
}
