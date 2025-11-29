part of 'app_routes.dart';

@TypedGoRoute<QueryTokenRoute>(
  path: RoutePaths.searchInternal,
  name: RouteNames.searchInternal,
)
class QueryTokenRoute extends GoRouteData with $QueryTokenRoute {
  const QueryTokenRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      const CupertinoPage(child: QueryTokenScreen());
}
