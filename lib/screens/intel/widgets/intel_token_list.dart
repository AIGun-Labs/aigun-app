import 'package:flutter/material.dart';

import '../../../data/models/intel/intel.dart';
import 'intel_token_item.dart';

class IntelTokenList extends StatefulWidget {
  const IntelTokenList({super.key, required this.tokens});

  final List<Entity>? tokens;
  @override
  State<IntelTokenList> createState() => _IntelTokenListState();
}

class _IntelTokenListState extends State<IntelTokenList> {
  @override
  Widget build(BuildContext context) {
    final tokens = widget.tokens;

    if (tokens == null || tokens.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
        itemCount: tokens.length,
        shrinkWrap: true,
        // controller: scrollController,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final token = tokens[index];

          if (token.id == null) {
            return const SizedBox.shrink();
          }
          return IntelTokenItem(
            token: token,
          );
        });
  }
}
