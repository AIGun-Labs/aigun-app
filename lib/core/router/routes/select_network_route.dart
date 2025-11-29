part of 'app_routes.dart';

@TypedGoRoute<SelectNetworkRoute>(
  path: RoutePaths.selectNetwork,
  name: RouteNames.selectNetwork,
)
class SelectNetworkRoute extends GoRouteData with $SelectNetworkRoute {
  const SelectNetworkRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      const CupertinoPage(child: SelectNetworkScreen());
}
