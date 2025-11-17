part of 'app_routes.dart';

@TypedGoRoute<ReceiveAddressRoute>(
    path: RoutePaths.receiveAddress, name: RouteNames.receiveAddress)
class ReceiveAddressRoute extends GoRouteData {
  const ReceiveAddressRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      const CupertinoPage(child: ReceiveAddressScreen());
}
