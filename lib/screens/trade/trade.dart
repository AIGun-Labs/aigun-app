import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/widgets/swap/widgets/swap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TradeScreen extends StatelessWidget {
  const TradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      final isLoggedIn =
          context.select((UserCubit cubit) => cubit.state.status.isLoggedIn);

      if (!isLoggedIn) {
        return const Center(child: Text("Please login first"));
      }
    }

    return const Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: TradeSwap(),
      )),
    );
  }
}
