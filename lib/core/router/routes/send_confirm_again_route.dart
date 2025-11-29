part of 'app_routes.dart';

@TypedGoRoute<SendConfirmAgainRoute>(
    path: RoutePaths.sendConfirmAgain, name: RouteNames.sendConfirmAgain)
class SendConfirmAgainRoute extends GoRouteData with $SendConfirmAgainRoute {
  const SendConfirmAgainRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      slideH(const SendConfirmAgainScreen(), context: c);
}
