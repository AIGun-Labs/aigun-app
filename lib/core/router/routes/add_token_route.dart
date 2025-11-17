part of 'app_routes.dart';

@TypedGoRoute<AddTokenRoute>(
    path: RoutePaths.addToken, name: RouteNames.addToken)
class AddTokenRoute extends GoRouteData {
  const AddTokenRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      const CupertinoPage(child: AddTokenScreen());
}
