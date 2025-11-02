import 'package:flutter/material.dart';
import 'package:flutter_aigun/services/analytics/analytics_manager.dart';

/// 统计分析使用示例
/// 
/// 这个文件展示了如何在实际业务中使用 AnalyticsManager
class AnalyticsExample {
  /// 示例 1：用户登录
  static Future<void> exampleUserLogin() async {
    // 方式 1：使用便捷方法
    await AnalyticsManager().logLogin(method: 'google');

    // 方式 2：使用通用方法
    await AnalyticsManager().logEvent('login', parameters: {
      'method': 'google',
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });

    // 设置用户 ID
    await AnalyticsManager().setUserId('user_12345');

    // 设置用户属性
    await AnalyticsManager().setUserProperty('account_type', 'premium');
  }

  /// 示例 2：用户注册
  static Future<void> exampleUserSignUp() async {
    await AnalyticsManager().logSignUp(method: 'email');
    
    // 记录注册来源
    await AnalyticsManager().logEvent('sign_up_source', parameters: {
      'referrer': 'social_media',
      'campaign': 'summer_promotion',
    });
  }

  /// 示例 3：用户退出登录
  static Future<void> exampleUserLogout() async {
    await AnalyticsManager().logEvent('logout');
    
    // 清除用户 ID
    await AnalyticsManager().clearUserId();
  }

  /// 示例 4：电商 - 查看商品
  static Future<void> exampleViewProduct(String productId) async {
    await AnalyticsManager().logEvent('view_item', parameters: {
      'item_id': productId,
      'item_name': '示例商品',
      'item_category': '电子产品',
      'price': 999.99,
      'currency': 'USD',
    });
  }

  /// 示例 5：电商 - 加入购物车
  static Future<void> exampleAddToCart(String productId, int quantity) async {
    await AnalyticsManager().logEvent('add_to_cart', parameters: {
      'item_id': productId,
      'quantity': quantity,
      'value': 999.99,
      'currency': 'USD',
    });
  }

  /// 示例 6：电商 - 购买完成
  static Future<void> examplePurchase(String orderId, double totalAmount) async {
    await AnalyticsManager().logPurchase(
      currency: 'USD',
      value: totalAmount,
      items: {
        'transaction_id': orderId,
        'affiliation': 'Online Store',
        'shipping': 10.0,
        'tax': 5.0,
      },
    );
  }

  /// 示例 7：社交 - 分享内容
  static Future<void> exampleShare(String contentType, String contentId) async {
    await AnalyticsManager().logShare(
      contentType: contentType,
      itemId: contentId,
    );
  }

  /// 示例 8：搜索
  static Future<void> exampleSearch(String keyword) async {
    await AnalyticsManager().logSearch(searchTerm: keyword);
  }

  /// 示例 9：页面浏览（在 StatefulWidget 中使用）
  static Future<void> examplePageView(String pageName) async {
    await AnalyticsManager().logScreenView(
      screenName: pageName,
      screenClass: pageName,
    );
  }

  /// 示例 10：自定义业务事件
  static Future<void> exampleCustomEvent() async {
    // 记录交易事件
    await AnalyticsManager().logEvent('trade_completed', parameters: {
      'trade_type': 'buy',
      'token_symbol': 'BTC',
      'amount': 0.5,
      'price': 50000.0,
      'platform': 'mobile',
    });

    // 记录钱包事件
    await AnalyticsManager().logEvent('wallet_connected', parameters: {
      'wallet_type': 'metamask',
      'chain': 'ethereum',
      'success': true,
    });

    // 记录错误事件
    await AnalyticsManager().logEvent('app_error', parameters: {
      'error_type': 'network_error',
      'error_message': 'Connection timeout',
      'page': 'trade_page',
    });
  }
}

/// 使用示例的页面 Widget
class AnalyticsExamplePage extends StatefulWidget {
  const AnalyticsExamplePage({Key? key}) : super(key: key);

  @override
  State<AnalyticsExamplePage> createState() => _AnalyticsExamplePageState();
}

class _AnalyticsExamplePageState extends State<AnalyticsExamplePage> {
  @override
  void initState() {
    super.initState();
    // 页面进入时记录页面浏览
    AnalyticsManager().logScreenView(
      screenName: 'analytics_example_page',
      screenClass: 'AnalyticsExamplePage',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('统计分析示例'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildButton(
            '登录事件',
            () => AnalyticsExample.exampleUserLogin(),
          ),
          _buildButton(
            '注册事件',
            () => AnalyticsExample.exampleUserSignUp(),
          ),
          _buildButton(
            '退出登录',
            () => AnalyticsExample.exampleUserLogout(),
          ),
          _buildButton(
            '查看商品',
            () => AnalyticsExample.exampleViewProduct('product_123'),
          ),
          _buildButton(
            '加入购物车',
            () => AnalyticsExample.exampleAddToCart('product_123', 1),
          ),
          _buildButton(
            '完成购买',
            () => AnalyticsExample.examplePurchase('order_123', 999.99),
          ),
          _buildButton(
            '分享内容',
            () => AnalyticsExample.exampleShare('article', 'article_123'),
          ),
          _buildButton(
            '搜索',
            () => AnalyticsExample.exampleSearch('Flutter'),
          ),
          _buildButton(
            '自定义事件',
            () => AnalyticsExample.exampleCustomEvent(),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('已记录: $title')),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(title),
      ),
    );
  }
}


