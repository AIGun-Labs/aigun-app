import 'package:flutter/material.dart';
import 'package:flutter_aigun/services/analytics/analytics_manager.dart';
import 'package:flutter_aigun/utils/logger.dart';

/// 路由分析观察者
/// 自动监听路由变化并记录页面浏览统计
class AnalyticsRouteObserver extends NavigatorObserver {

  /// 获取路由名称
  String? _getRouteName(Route<dynamic>? route) {
    if (route == null) return null;
    
    final String? routeName = route.settings.name;
    if (routeName == null || routeName.isEmpty) {
      return null;
    }
    
    return routeName;
  }

  /// 记录页面浏览（页面进入）
  void _logScreenView(Route<dynamic>? route) {
    if (route == null) return;

    final String? routeName = _getRouteName(route);
    if (routeName == null) {
      Logger.debug('路由名称为空，跳过统计');
      return;
    }

    try {
      // 记录页面浏览
      AnalyticsManager().logScreenView(
        screenName: routeName,
        screenClass: route.runtimeType.toString(),
      );
      
      Logger.debug('📊 页面进入统计: $routeName');
    } catch (e) {
      Logger.error('记录页面浏览失败', e);
    }
  }

  /// 记录页面离开（仅用于友盟统计）
  void _logScreenEnd(Route<dynamic>? route) {
    if (route == null) return;

    final String? routeName = _getRouteName(route);
    if (routeName == null) return;

    try {
      // 如果 AnalyticsManager 使用的是友盟，需要调用 onPageEnd
      // 这里我们直接记录一个自定义事件来表示页面离开
      AnalyticsManager().logEvent('page_end', parameters: {
        'screen_name': routeName,
      });
      
      Logger.debug('📊 页面离开统计: $routeName');
    } catch (e) {
      Logger.error('记录页面离开失败', e);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    
    // 如果有上一个页面，记录页面离开
    if (previousRoute != null) {
      _logScreenEnd(previousRoute);
    }
    
    // 记录新页面浏览
    _logScreenView(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    
    // 记录当前页面离开
    _logScreenEnd(route);
    
    // 返回到上一个页面时，记录上一个页面
    if (previousRoute != null) {
      _logScreenView(previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    
    // 记录旧页面离开
    if (oldRoute != null) {
      _logScreenEnd(oldRoute);
    }
    
    // 记录新页面浏览
    _logScreenView(newRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    
    // 记录移除的页面离开
    _logScreenEnd(route);
    
    // 如果有上一个页面，记录浏览
    if (previousRoute != null) {
      _logScreenView(previousRoute);
    }
  }
}

