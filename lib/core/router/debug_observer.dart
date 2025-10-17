import 'package:flutter/material.dart';

import '../../utils/logger.dart';

class DebugNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    Logger.info("didPush: $route, $previousRoute");
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    Logger.info("didPop: $route, $previousRoute");
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    Logger.info("didReplace: $newRoute, $oldRoute");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    Logger.info("didRemove: $route, $previousRoute");
  }
}
