import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TokenDetailScreen extends StatelessWidget {
  const TokenDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取跳转参数
    final params = GoRouterState.of(context).extra as Map<String, dynamic>;

    final address = params['address'] ?? '';
    final chainId = params['chainId'] ?? '';

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text(address),
          const SizedBox(height: 10),
          Text(chainId),
        ],
      )),
    );
  }
}
