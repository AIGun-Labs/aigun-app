import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_cubit.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/token_header_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenDetailScreen extends StatelessWidget {
  const TokenDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TokenHeaderBar(),
      body: SafeArea(child: BlocBuilder<TokenDetailCubit, TokenDetailState>(
          builder: (context, state) {
        final token = state.token;

        return Column(
          children: [
            Text(token?.address ?? ''),
            const SizedBox(height: 10),
            Text(token?.chainId.toString() ?? ''),
          ],
        );
      })),
    );
  }
}
