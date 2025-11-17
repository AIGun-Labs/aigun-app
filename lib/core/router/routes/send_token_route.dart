part of 'app_routes.dart';

@TypedGoRoute<SendTokenRoute>(
    path: RoutePaths.sendToken, name: RouteNames.sendToken)
class SendTokenRoute extends GoRouteData {
  const SendTokenRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      const CupertinoPage(child: SendTokenStateScreen());
}
