part of 'app_routes.dart';

@TypedGoRoute<TokenDetailRoute>(
  path: RoutePaths.tokenDetail,
  name: RouteNames.tokenDetail,
)
class TokenDetailRoute extends GoRouteData with $TokenDetailRoute {
  const TokenDetailRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      const CupertinoPage(child: TokenDetailScreen());
}
