part of 'app_routes.dart';

@TypedGoRoute<WebviewPreviewRoute>(
    path: RoutePaths.webviewPreview, name: RouteNames.webviewPreview)
class WebviewPreviewRoute extends GoRouteData {
  const WebviewPreviewRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      const CupertinoPage(child: WebviewScreen());
}
