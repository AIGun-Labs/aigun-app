import 'package:flutter/material.dart';

import '../../services/analytics/analytics_manager.dart';
import '../../utils/logger.dart';

class AnalyticsRouteObserver extends NavigatorObserver {
  String? _getRouteName(Route<dynamic>? route) {
    if (route == null) return null;

    final String? routeName = route.settings.name;
    if (routeName == null || routeName.isEmpty) {
      return null;
    }

    return routeName;
  }

  void _logScreenView(Route<dynamic>? route) {
    if (route == null) return;

    final String? routeName = _getRouteName(route);
    if (routeName == null) {
      Logger.debug('，');
      return;
    }

    try {
      AnalyticsManager().logScreenView(
        screenName: routeName,
        screenClass: route.runtimeType.toString(),
      );

      Logger.debug('📊 : $routeName');
    } catch (e) {
      Logger.error('', e);
    }
  }

  void _logScreenEnd(Route<dynamic>? route) {
    if (route == null) return;

    final String? routeName = _getRouteName(route);
    if (routeName == null) return;

    try {
      AnalyticsManager().logEvent(
        'page_end',
        parameters: {'screen_name': routeName},
      );

      Logger.debug('📊 : $routeName');
    } catch (e) {
      Logger.error('', e);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null) {
      _logScreenEnd(previousRoute);
    }
    _logScreenView(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _logScreenEnd(route);
    if (previousRoute != null) {
      _logScreenView(previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) {
      _logScreenEnd(oldRoute);
    }
    _logScreenView(newRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _logScreenEnd(route);
    if (previousRoute != null) {
      _logScreenView(previousRoute);
    }
  }
}
