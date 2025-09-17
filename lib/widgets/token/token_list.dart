import 'package:flutter/material.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_aigun/widgets/token/token_item.dart';

class TokenList extends StatelessWidget {
  const TokenList({
    super.key,
    required this.onTap,
    this.tokens,
    this.isShowRight = true,
  });

  final Function(Token?)? onTap;
  final List<Token>? tokens;
  final bool isShowRight;

  @override
  Widget build(BuildContext context) {
    // if no tokens, show no tokens text
    if (tokens == null || tokens!.isEmpty) {
      return const Center(child: Text("No tokens"));
    }

    return SafeArea(
        child: ListView.builder(
            itemCount: tokens?.length,
            itemBuilder: (context, index) {
              if (tokens == null) {
                return const SizedBox.shrink();
              }
              return _buildTokenItem(context, tokens![index]);
            }));
  }

  Widget _buildTokenItem(BuildContext context, Token token) {
    return TokenItem(
        token: token,
        title: token.tokenName,
        subtitle: token.symbol,
        trailing: CurrencyFormatter.abbreviateTokenPrice(
            double.tryParse(token.tokenPrice.safeMultiply(token.balance)) ??
                0.0),
        trailingSubtitle: CurrencyFormatter.abbreviateTokenPrice(
            double.tryParse(token.balance) ?? 0.0),
        onTap: (token) => onTap?.call(token),
        isShowRight: isShowRight);
  }
}

class TokenListSkeleton extends StatelessWidget {
  const TokenListSkeleton({super.key, this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return const TokenItemSkeleton();
        });
  }
}
