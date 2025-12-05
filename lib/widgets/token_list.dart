import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../l10n/l10n.dart';
import '../themes/themes.dart';
import 'token/models/token.dart';
import 'token_card.dart';
import 'token_skeleton.dart';

class TokenList extends StatefulWidget {
  const TokenList({
    super.key,
    required this.tokens,
    required this.isLoading,
    this.errorMessage,
    this.showAddress = false,
    this.replace = false,
    required this.onTap,
  });
  final bool showAddress;
  final bool replace;
  final List<Token>? tokens;
  final Function(Token) onTap;
  // final List<Address>? addressList;
  final bool isLoading;
  final String? errorMessage;

  @override
  State<TokenList> createState() => _TokenListState();
}

class _TokenListState extends State<TokenList> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      if (widget.tokens != null) {
        return _buildTokenList(context);
      }

      return const TokenSkeleton();
    }

    return _buildTokenList(context);
  }

  Widget _buildTokenList(BuildContext context) {
    if (widget.tokens?.isEmpty == true) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Center(
          child: Text(
            S.of(context).noToken,
            style: TextStyle(
              color: AppColors.textPrimary(context),
              fontSize: 16.sp,
            ),
          ),
        ),
      );
    }

    return Column(
      children:
          widget.tokens?.map((token) {
            return TokenCard(
              token: token,
              showAddress: widget.showAddress,
              onTap: () {
                widget.onTap(token);
              },
            );
          }).toList() ??
          [],
    );
  }
}
