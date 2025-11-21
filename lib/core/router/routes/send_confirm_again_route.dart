part of 'app_routes.dart';

@TypedGoRoute<SendConfirmAgainRoute>(
    path: RoutePaths.sendConfirmAgain, name: RouteNames.sendConfirmAgain)
class SendConfirmAgainRoute extends GoRouteData {
  const SendConfirmAgainRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      slideH(const SendConfirmAgainScreen());
}
