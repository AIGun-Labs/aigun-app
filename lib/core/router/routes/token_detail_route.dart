part of 'app_routes.dart';

@TypedGoRoute<TokenDetailRoute>(
  path: RoutePaths.tokenDetail,
  name: RouteNames.tokenDetail,
)
class TokenDetailRoute extends GoRouteData with $TokenDetailRoute {
  const TokenDetailRoute(this.$extra, {required this.type, this.tokenType});

  final TokenEntity $extra;

  final String type;

  final String? tokenType;

  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) => CupertinoPage(
    child: TokenDetailScreen(token: $extra, type: type, tokenType: tokenType),
  );
}
