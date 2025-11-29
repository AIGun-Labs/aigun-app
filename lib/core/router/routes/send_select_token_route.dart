part of 'app_routes.dart';

@TypedGoRoute<SendSelectTokenRoute>(
  path: RoutePaths.sendSelectToken,
  name: RouteNames.sendSelectToken,
)
class SendSelectTokenRoute extends GoRouteData with $SendSelectTokenRoute {
  const SendSelectTokenRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      const CupertinoPage(child: SendSelectTokenScreen());
}
