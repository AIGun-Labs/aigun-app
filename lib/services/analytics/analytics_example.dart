import 'package:flutter/material.dart';

import 'analytics_manager.dart';

///
class AnalyticsExample {
  static Future<void> exampleUserLogin() async {
    await AnalyticsManager().logLogin(method: 'google');
    await AnalyticsManager().logEvent(
      'login',
      parameters: {
        'method': 'google',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
    await AnalyticsManager().setUserId('user_12345');
    await AnalyticsManager().setUserProperty('account_type', 'premium');
  }

  static Future<void> exampleUserSignUp() async {
    await AnalyticsManager().logSignUp(method: 'email');
    await AnalyticsManager().logEvent(
      'sign_up_source',
      parameters: {'referrer': 'social_media', 'campaign': 'summer_promotion'},
    );
  }

  static Future<void> exampleUserLogout() async {
    await AnalyticsManager().logEvent('logout');
    await AnalyticsManager().clearUserId();
  }

  static Future<void> exampleViewProduct(String productId) async {
    await AnalyticsManager().logEvent(
      'view_item',
      parameters: {
        'item_id': productId,
        'item_name': '',
        'item_category': '',
        'price': 999.99,
        'currency': 'USD',
      },
    );
  }

  static Future<void> exampleAddToCart(String productId, int quantity) async {
    await AnalyticsManager().logEvent(
      'add_to_cart',
      parameters: {
        'item_id': productId,
        'quantity': quantity,
        'value': 999.99,
        'currency': 'USD',
      },
    );
  }

  static Future<void> examplePurchase(
    String orderId,
    double totalAmount,
  ) async {
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

  static Future<void> exampleShare(String contentType, String contentId) async {
    await AnalyticsManager().logShare(
      contentType: contentType,
      itemId: contentId,
    );
  }

  static Future<void> exampleSearch(String keyword) async {
    await AnalyticsManager().logSearch(searchTerm: keyword);
  }

  static Future<void> examplePageView(String pageName) async {
    await AnalyticsManager().logScreenView(
      screenName: pageName,
      screenClass: pageName,
    );
  }

  static Future<void> exampleCustomEvent() async {
    await AnalyticsManager().logEvent(
      'trade_completed',
      parameters: {
        'trade_type': 'buy',
        'token_symbol': 'BTC',
        'amount': 0.5,
        'price': 50000.0,
        'platform': 'mobile',
      },
    );
    await AnalyticsManager().logEvent(
      'wallet_connected',
      parameters: {
        'wallet_type': 'metamask',
        'chain': 'ethereum',
        'success': true,
      },
    );
    await AnalyticsManager().logEvent(
      'app_error',
      parameters: {
        'error_type': 'network_error',
        'error_message': 'Connection timeout',
        'page': 'trade_page',
      },
    );
  }
}

class AnalyticsExamplePage extends StatefulWidget {
  const AnalyticsExamplePage({super.key});

  @override
  State<AnalyticsExamplePage> createState() => _AnalyticsExamplePageState();
}

class _AnalyticsExamplePageState extends State<AnalyticsExamplePage> {
  @override
  void initState() {
    super.initState();
    AnalyticsManager().logScreenView(
      screenName: 'analytics_example_page',
      screenClass: 'AnalyticsExamplePage',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildButton('', () => AnalyticsExample.exampleUserLogin()),
          _buildButton('', () => AnalyticsExample.exampleUserSignUp()),
          _buildButton('', () => AnalyticsExample.exampleUserLogout()),
          _buildButton(
            '',
            () => AnalyticsExample.exampleViewProduct('product_123'),
          ),
          _buildButton(
            '',
            () => AnalyticsExample.exampleAddToCart('product_123', 1),
          ),
          _buildButton(
            '',
            () => AnalyticsExample.examplePurchase('order_123', 999.99),
          ),
          _buildButton(
            '',
            () => AnalyticsExample.exampleShare('article', 'article_123'),
          ),
          _buildButton('', () => AnalyticsExample.exampleSearch('Flutter')),
          _buildButton('', () => AnalyticsExample.exampleCustomEvent()),
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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(': $title')));
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(title),
      ),
    );
  }
}
